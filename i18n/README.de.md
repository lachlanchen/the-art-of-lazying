[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Hinweis: Dieses Repository wurde migriert. Die aktive Entwicklung wird unter https://github.com/lachlanchen/the-art-of-lazying fortgeführt.

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

Ein Repository, das strategische Faulheit für ein einfacheres, produktiveres Leben fördert und dabei KI-Agenten, Sprachenlernen sowie Vlogs mit praktischen Tipps und realen Anwendungsfällen zusammenführt.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Inhaltsverzeichnis

- [Überblick](#überblick)
- [Projekte](#projekte)
- [Automatisierungstools](#automatisierungstools)
- [Ordnerstruktur](#ordnerstruktur)
- [Einführung](#einführung)
- [Die Theorie des Lazying](#die-theorie-des-lazying)
- [Praktische Tipps und Tricks](#praktische-tipps-und-tricks)
- [Anwendungsfälle](#anwendungsfälle)
- [AI-Agenten und Automatisierung](#ai-agenten-und-automatisierung)
- [Sprachenlernen und Vlogs](#sprachenlernen-und-vlogs)
- [Community-Beiträge](#community-beiträge)
- [Voraussetzungen](#voraussetzungen)
- [Installation](#installation)
- [Nutzung](#nutzung)
- [Konfiguration](#konfiguration)
- [Beispiele](#beispiele)
- [Entwicklungshinweise](#entwicklungshinweise)
- [Fehlerbehebung](#fehlerbehebung)
- [Roadmap](#roadmap)
- [Mitwirken](#mitwirken)
- [Lizenz](#lizenz)
- [Danksagungen](#danksagungen)
- [Kontakt](#kontakt)

## Schnellzugriff

| Bedarf | Einstiegspunkt |
|---|---|
| Hauptinhalte anzeigen | [Überblick](#überblick) |
| Abhängigkeiten installieren | [Voraussetzungen](#voraussetzungen) |
| Beispiele ausführen | [Nutzung](#nutzung) |
| Häufige Probleme beheben | [Fehlerbehebung](#fehlerbehebung) |
| Mitmachen | [Mitwirken](#mitwirken) |

## Überblick

`the-art-of-lazying-legacy` ist ein kuratiertes Dach-Repository rund um strategische Faulheit:

- Konzeptionelle Inhalte zur Anwendung der "Lazying"-Philosophie in Arbeit und Alltag.
- Praktische Code-Artefakte, einschließlich E-Ink + GPT-Sprachenlernen (`code/EinkWordsGPT`).
- Hilfreiche Skripte für sicherere Arbeitsabläufe (`scripts/lazy-care/SafeShell`).
- Vlog-nahe Tools und Automatisierungsschnipsel (`vlogs/`).
- Demo-Assets und Beispiele (`demos/`, `examples/`, `figs/`).

| Snapshot | Wert |
|---|---|
| Rollen im Repository | Legacy-Archiv + Ideenlandkarte |
| Aktive Entwicklung | https://github.com/lachlanchen/the-art-of-lazying |
| Mehrsprachige README-Dateien | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n-Verzeichnis | `i18n/` (vorhanden) |
| Sprachenlernen | Spaced Repetition + GPT-Workflows |
| Schwerpunkt der Automatisierung | Skripte, Beschriftungen, Veröffentlichung und Hardware-Workflows |

Dieses Repository bleibt als Legacy-Archiv und Ideenlandkarte nützlich, während die aktive Entwicklung in das oben verlinkte migrierte Repository verlagert wurde.

---

## Projekte

### 🤖 KI-gestützte Kreativ-Tools

| Projekt | Beschreibung | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-Ink-Display mit GPT-gestütztem Vokabellernen | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse von Wortherkünften und Visualisierung als Graph | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Werkzeuge für effizientes Sprachenlernen mit minimalem Aufwand | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video- und Bild-Untertitelung mit OpenAI-CLIP-Embeddings + GPT-Decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Videountertitelungs-Tool: Keyframes mit Katna/OpenCV extrahieren und Captions mit einem ViT+GPT-2-Modell erzeugen | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Mehrsprachige Transkriptions-Pipeline mit fein aufgelöster Spracherkennung | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Sprachbarrieren für globalen kreativen Austausch abbauen | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatische Metadatengenerierung für Videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | KI-gestütztes automatisches Video-Editing mit Transkription, Auto-Untertiteln, Hervorhebungen und Metadaten-Erzeugung | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Optimierung von Content-Publishing-Workflows | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automatisches System zur Überwachung, Verarbeitung und Veröffentlichung von Videoinhalten auf mehreren Plattformen | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Fortgeschrittene Techniken für den effektiven Einsatz von KI-Assistenten | |

## Automatisierungstools

Das Repository enthält lokal direkt ausführbare Automatisierungswerkzeuge:

| Pfad | Zweck |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Kontinuierliche E-Ink-Wortkarten-Render-Schleife (Standard-Refresh alle 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch- und gezielte Aktualisierung von Wortdetails mit OpenAI-gestützter Logik. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Hardware-Test für das Waveshare 7,3" E-Paper-Display. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Shell-Funktionen `saferm`, `unrm` und `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Auflösung von Domains zu IPs + deduplizierte Ausgabe. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Führt `.py`-Dateien je Unterverzeichnis in `.txt`-Dateien zusammen. |

## Ordnerstruktur

### Aktuelle Repository-Struktur (genau)

```text
the-art-of-lazying-legacy/
├── README.md
├── README_EN.md
├── README_CN.md
├── LICENSE
├── books/
├── code/
│   └── EinkWordsGPT/
├── demos/
├── examples/
├── figs/
├── i18n/                      # derzeit vorhanden
├── scripts/
│   └── lazy-care/
└── vlogs/
```

### Ursprüngliche konzeptionelle Struktur (beibehalten)

```text
the-art-of-lazying/
│
├───code/
│ ├───ai-agents/
│ ├───automation/
│ └───language-learning/
│
├───book/
│ ├───manuscript/
│ └───resources/
│
├───examples/
│ ├───practical-tips/
│ ├───use-cases/
│ └───community-contributions/
│
└───vlogs/
  ├───language-learning/
  └───lazy-lifestyle/
```

> Hinweis: Die konzeptionelle Karte oben wird bewusst aus früheren README-Versionen beibehalten. Der Block „Aktuelle Repository-Struktur“ spiegelt den konkreten Baum dieses Legacy-Repositories wider.

## Einführung

The Art of Lazying stellt strategische Faulheit als Methode dar, um den Energieeinsatz zu optimieren und sich auf das zu konzentrieren, was wirklich zählt. Dieses Repository zeigt, wie absichtsvolle Faulheit zu höherer Produktivität, Kreativität und mehr Wohlbefinden führen kann.

## Die Theorie des Lazying

Eine umfassende Einführung in die Prinzipien strategischer Faulheit mit Fokus darauf, Produktivität und Wohlbefinden durch Priorisierung, Delegation und Automatisierung von Aufgaben zu maximieren.

Das Kernprinzip ist die Anwendung der Pareto-80/20-Regel auf den Alltag: die 20 % der Aktivitäten zu identifizieren, die 80 % der gewünschten Ergebnisse erzeugen.

## Praktische Tipps und Tricks

Eine Sammlung umsetzbarer Ratschläge zur Anwendung von Lazying-Prinzipien auf Arbeit, Beziehungen und Selbstfürsorge:

- Wiederkehrende Aufgaben automatisieren
- Die Pomodoro-Technik für das Zeitmanagement nutzen
- Systeme aufbauen, die Entscheidungsmüdigkeit reduzieren
- KI-Werkzeuge zur Unterstützung einsetzen

## Anwendungsfälle

Beispiele aus dem realen Leben, die zeigen, wie Lazying-Prinzipien Probleme lösen und die Effizienz steigern:

- Wie Unternehmer Delegation und Automatisierung nutzen, um sich auf das Unternehmenswachstum zu konzentrieren
- Wie Forschende ihre Arbeitsabläufe im Studium vereinfachen
- Wie Content Creator ihren Produktionsprozess optimieren

## AI-Agenten und Automatisierung

Ausbau von KI-Agenten und Automatisierungstools, die Aufgaben vereinfachen:

- ChatGPT als persönlichen Assistenten nutzen
- Eigene Automatisierungs-Workflows aufbauen
- E-Ink-Displays für passives Lernen erstellen

## Sprachenlernen und Vlogs

Ressourcen und Techniken für effizientes Sprachenlernen sowie Vlogs, die die Lazying-Reise dokumentieren:

- Personalisierter Sprachunterricht mit Spaced Repetition aufbauen
- Immersive Lerntechniken einsetzen
- Projekte erstellen, die passives Lernen fördern

## Community-Beiträge

Teile eigene Erfahrungen, Tipps und Ideen zu strategischer Faulheit:

- Forum für den Austausch von Produktivitäts-Tricks
- Werkzeuge und Vorlagen für tägliche Routinen
- Gemeinsame Projekte für effiziente Entlastung

## Voraussetzungen

Das Repository enthält mehrere unabhängige Skripte, daher variieren die Voraussetzungen je nach Modul.

Gemeinsame Basis:

- Python 3.9+
- `pip`
- Git

Projektspezifische Signale aus den Quelldateien:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (für E-Paper-Hardware-Flows)
- `sqlite3` (Standardbibliothek)

Hardware-Anforderungen für den vollständigen `EinkWordsGPT`-Betrieb:

- Raspberry Pi (Projekt-Dokumentation nennt Raspberry Pi 5)
- Waveshare 7-Farben 7,3-Zoll E-Ink-Panel

## Installation

Da kein zentrales Dependency-Manifest existiert, installiere Abhängigkeiten manuell für das Modul, das du ausführen möchtest.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Optionale/hardwarebezogene Abhängigkeit:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell-Setup:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Nutzung

### 1) EinkWordsGPT-Display-Schleife starten

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Wortdetails erneut prüfen/aktualisieren

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Waveshare 7,3-Zoll-Panel testen

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) ChatGPT-bezogene Domains auflösen und IP-Ausgabe erzeugen

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Python-Dateien pro Verzeichnis für KI-freundliche Text-Bundles zusammenführen

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Sichereren Dateilöschungs-Workflow nutzen

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Konfiguration

### OpenAI-Zugangsdaten

`EinkWordsGPT` und Update-Skripte nutzen `OpenAI()` aus dem offiziellen SDK und erwarten, dass die Zugangsdaten in deiner Umgebung konfiguriert sind.

Empfehlung:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Datenbankpfad

`code/EinkWordsGPT/words_gpt.py` und `words_update.py` verwenden:

- `db_path = 'words_phonetics.db'`

Starte die Skripte aus `code/EinkWordsGPT` oder passe die Pfade an, wenn du sie von einem anderen Ort startest.

### SafeShell-Müll-Wurzel

`saferm`/`unrm`/`removeitanyway` nutzen derzeit einen festen Basispfad:

- `/mnt/disk/BIN/ROOT`

Stelle sicher, dass dieser Pfad existiert und beschreibbar ist, bevor du dich auf `saferm` verlässt.

### Repo2Text-Pfade

`vlogs/repo2text/convert-repo-to-merged-text.py` hat derzeit hardcodierte Pfade:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Passe diese Konstanten an dein lokales Projekt an.

## Beispiele

### Beispiel: E-Ink-Lernkartenzyklus

- Das Skript wählt (oder lädt) Wortdetails aus.
- Die Wortkarte rendert Aussprachezeichen, Silbensegmentierung und japanische Synonymhinweise.
- Der Bildschirm aktualisiert sich alle 5 Minuten (`time.sleep(300)`).

### Beispiel: Sicherer Löschworkflow

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Beispiel: Domain-/IP-Ausgabedatei

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Entwicklungshinweise

- Dies ist ein Legacy-Repository; aktive Entwicklung ist hier: https://github.com/lachlanchen/the-art-of-lazying
- Inhalte auf oberster Ebene sind kuratierend und verlinken zu vielen externen Repositories.
- `i18n/` existiert, ist jedoch derzeit leer; die sprachspezifischen READMEs leben derzeit auf oberster Ebene.
- Weder `requirements.txt` noch `pyproject.toml` sind im Root vorhanden.

Kompatibilitätsnotiz:

- Frühere Dokumentation in Unterordnern kann auf Skripte (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) verweisen, die nun in `scripts/lazy-care/SafeShell/safeshell_functions.sh` konsolidiert sind.

## Fehlerbehebung

- `ModuleNotFoundError`: Installiere fehlende Python-Pakete aus den [Voraussetzungen](#voraussetzungen).
- `openai`-Authentifizierungsfehler: prüfe, ob `OPENAI_API_KEY` in deiner Shell exportiert ist.
- Waveshare-Laufzeitprobleme: überprüfe SPI-/Gerätekonfiguration und installiere die Hardware-Abhängigkeiten auf dem Pi.
- `saferm` macht scheinbar nichts: prüfe, ob `/mnt/disk/BIN/ROOT` existiert und Schreibrechte besitzt.
- `repo2text` erzeugt keine Dateien: stelle sicher, dass `source_directory` auf einen existierenden Ordner mit `.py`-Dateien zeigt.
- `chatgpt-traffic`-Anomalien bei Domains: prüfe und bereinige die `domains`-Liste im Skript vor dem Produktionseinsatz.

## Roadmap

- Dieses Repository als stabiles Legacy-Archiv mit klaren Hinweisen auf aktive Projekte erhalten.
- Abhängigkeitsmanifeste für jedes ausführbare Modul verbessern.
- In künftigen Revisionen ein konsistentes i18n-Layout unter `/i18n` hinzufügen.
- Praktische Beispiele und reproduzierbare Setup-Anleitungen für Hardware- und Nicht-Hardware-Workflows erweitern.

## Mitwirken

Beiträge sind willkommen.

1. Forke das Projekt.
2. Erstelle deinen Feature-Branch (`git checkout -b feature/AmazingFeature`).
3. Committe deine Änderungen (`git commit -m 'Add some AmazingFeature'`).
4. Push zum Branch (`git push origin feature/AmazingFeature`).
5. Öffne einen Pull Request.

Du kannst auch beitragen, indem du:

- Verbesserungen für strategische-Laziness-Workflows vorschlägst.
- Fehler in Skripten oder Dokumentation meldest.
- Die Reproduzierbarkeit von Setups für Hardware- und Software-Pfade verbesserst.

## Lizenz

Dieses Repository ist unter der GNU General Public License v3.0 lizenziert. Siehe [LICENSE](LICENSE).

## Danksagungen

Besonderer Dank gilt den Mitwirkenden, dem OpenAI-Team sowie den Raspberry-Pi- und Maker-Communities, die Experimente mit reibungsarmen Lernsystemen unterstützen.

## Kontakt

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
