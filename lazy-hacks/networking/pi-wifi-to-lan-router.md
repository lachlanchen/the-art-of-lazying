# Raspberry Pi Wi-Fi To LAN Router

This note documents a Raspberry Pi setup that takes an upstream Wi-Fi connection and shares it to wired Ethernet clients through NAT.

Despite some script names using "bridge", this is not a true layer-2 bridge. It is a small Linux router:

```text
upstream Wi-Fi -> wlan0 -> NAT -> eth0 -> downstream LAN
```

## Runtime Shape

The expected shape is:

```text
wlan0: upstream Wi-Fi, receives DHCP/default route from the Wi-Fi network
eth0:  static LAN gateway, for example 192.168.2.1/24
dnsmasq: DHCP server for eth0 clients
iptables/nftables: NAT masquerade out wlan0
net.ipv4.ip_forward: 1
```

Traffic flow:

1. A downstream device plugs into the Pi's Ethernet side.
2. `dnsmasq` leases it an address such as `192.168.2.159`.
3. That client uses the Pi as its gateway.
4. The Pi forwards packets from `eth0` to `wlan0`.
5. NAT masquerade rewrites traffic so it can leave through the upstream Wi-Fi.

## Failure Mode Seen

The Pi had a long-running uptime and then became unreachable or appeared frozen after several days.

Important evidence:

- no logged kernel panic
- no OOM kill
- no EXT4 or SD-card I/O error
- no thermal shutdown
- no undervoltage/throttling flag at inspection time
- journal from the previous boot was marked unclean after reboot
- final useful logs before reboot were Wi-Fi/DHCP/NTP related

This pattern suggests the first failure was likely upstream Wi-Fi/internet interruption, followed by a hard reset or unlogged lock.

For an always-on router, two weak points matter most:

- Enterprise or campus Wi-Fi can force roaming, reauthentication, and DHCP renewal.
- Wi-Fi power saving can make an always-on forwarding path less reliable.

## First Stabilization Steps

Disable Wi-Fi powersave for the upstream NetworkManager connection:

```bash
sudo nmcli connection modify YOUR_WIFI_CONNECTION 802-11-wireless.powersave 2
sudo nmcli connection down YOUR_WIFI_CONNECTION
sudo nmcli connection up YOUR_WIFI_CONNECTION
```

Clean and persist a single NAT rule set:

```bash
sudo iptables -F FORWARD
sudo iptables -t nat -F POSTROUTING

sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

sudo netfilter-persistent save
```

Then consider adding a small systemd watchdog that pings the upstream gateway and restarts the Wi-Fi connection plus `dnsmasq` if forwarding breaks.

## Applied Fix Result

After running the safe apply mode, the intended final state is:

```text
net.ipv4.ip_forward: 1
Wi-Fi powersave: disabled for the upstream NetworkManager connection
eth0: static LAN gateway, 192.168.2.1/24
wlan0: upstream Wi-Fi, DHCP/default route from the Wi-Fi network
dnsmasq: active and enabled
```

The firewall should have one clean forwarding and NAT rule set:

```text
FORWARD:
-A FORWARD -i eth0 -o wlan0 -j ACCEPT
-A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

NAT POSTROUTING:
-A POSTROUTING -o wlan0 -j MASQUERADE
```

Verification should include:

```bash
cat /proc/sys/net/ipv4/ip_forward
nmcli -f 802-11-wireless.powersave connection show YOUR_WIFI_CONNECTION
ip -brief addr show eth0
ip -brief addr show wlan0
systemctl is-active dnsmasq
sudo iptables -S FORWARD
sudo iptables -t nat -S POSTROUTING
ping -c 2 8.8.8.8
getent hosts google.com
```

If those checks match the shape above, the fix does not need to be rerun.

One display-only bug was also fixed in the helper script: the status command should query `eth0` and `wlan0` separately instead of passing both interface names to one `ip -brief addr show` call.

## Full Script

This is the observed active script. It installs and uninstalls the Wi-Fi-to-LAN NAT router setup.

```bash
#!/usr/bin/env bash

set -e

[ $EUID -ne 0 ] && echo "Please run as root" >&2 && exit 1

# Function to display usage
usage() {
    echo "Usage: $0 -i | -u"
    echo "  -i    Install bridge configuration"
    echo "  -u    Uninstall bridge configuration"
    exit 1
}

# Check for exactly one argument
if [ "$#" -ne 1 ]; then
    usage
fi

case "$1" in
    -i)
        # Install steps
        echo "Installing bridge configuration..."

        # Update system and install required packages
        apt update && \
        DEBIAN_FRONTEND=noninteractive apt install -y \
            dnsmasq netfilter-persistent iptables-persistent

        # Create and persist iptables rule
        iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
        netfilter-persistent save

        # Enable IPv4 forwarding
        sed -i.bak 's/#*net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
        sysctl -p /etc/sysctl.conf

        # Configure eth0 with a static IP address
        cat <<'EOF' >/etc/network/interfaces.d/eth0
auto eth0
allow-hotplug eth0
iface eth0 inet static
  address 192.168.2.1
  netmask 255.255.255.0
EOF

        # Create dnsmasq DHCP configuration
        cat <<'EOF' >/etc/dnsmasq.d/bridge.conf
interface=eth0
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.2.2,192.168.2.254,12h
EOF

        # Restart dnsmasq to apply the new configuration
        systemctl restart dnsmasq
        systemctl enable dnsmasq

        # Mask networking.service to prevent conflicts
        systemctl mask networking.service

        echo "Installation complete. Your Raspberry Pi is now configured as a WiFi to Ethernet bridge."
        ;;
    -u)
        # Uninstall steps
        echo "Uninstalling bridge configuration..."

        # Remove the iptables rule
        iptables -t nat -D POSTROUTING -o wlan0 -j MASQUERADE || true
        netfilter-persistent save

        # Restore original sysctl.conf if backup exists
        if [ -f /etc/sysctl.conf.bak ]; then
            mv /etc/sysctl.conf.bak /etc/sysctl.conf
        else
            # Comment out net.ipv4.ip_forward=1 if backup not found
            sed -i 's/^net.ipv4.ip_forward=1/#net.ipv4.ip_forward=1/' /etc/sysctl.conf
        fi
        sysctl -p /etc/sysctl.conf

        # Remove the static IP configuration for eth0
        rm -f /etc/network/interfaces.d/eth0

        # Remove dnsmasq configuration
        rm -f /etc/dnsmasq.d/bridge.conf

        # Restart dnsmasq to apply changes
        systemctl restart dnsmasq

        # Unmask networking.service
        systemctl unmask networking.service

        echo "Uninstallation complete. The bridge configuration has been removed."
        ;;
    *)
        # Invalid option
        usage
        ;;
esac
```

## Script Logic

Install:

```bash
sudo ./bridge_final.sh -i
```

What it does:

1. Installs `dnsmasq`, `netfilter-persistent`, and `iptables-persistent`.
2. Adds NAT masquerade on outbound `wlan0`.
3. Saves netfilter rules.
4. Enables IPv4 forwarding in `/etc/sysctl.conf`.
5. Configures `eth0` with static `192.168.2.1/24`.
6. Configures `dnsmasq` to serve `192.168.2.2` through `192.168.2.254`.
7. Restarts and enables `dnsmasq`.
8. Masks `networking.service`.

Uninstall:

```bash
sudo ./bridge_final.sh -u
```

What it does:

1. Deletes one NAT masquerade rule.
2. Saves netfilter rules.
3. Restores or disables IPv4 forwarding.
4. Removes the static `eth0` config.
5. Removes the `dnsmasq` bridge config.
6. Restarts `dnsmasq`.
7. Unmasks `networking.service`.

## Caveats

The script is useful, but it is not idempotent:

- repeated install appends duplicate `MASQUERADE` rules
- uninstall removes only one matching NAT rule
- it edits `/etc/sysctl.conf` directly
- it calls `apt update` during setup
- it does not disable Wi-Fi powersave
- it has no watchdog for upstream Wi-Fi failure

A hardened version should use `iptables -C` before adding rules, clean duplicates before saving, write a dedicated `/etc/sysctl.d/*.conf`, disable Wi-Fi powersave, and run a health watchdog for the upstream link.
