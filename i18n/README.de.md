[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> Hinweis: Dieses Repository wurde migriert. Die aktive Entwicklung läuft weiter unter https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

Ein Repository, das strategische Faulheit für ein einfacheres, produktiveres Leben fördert und dabei AI-Agenten, Sprachenlernen sowie Vlogs mit praktischen Tipps und realen Anwendungsfällen zusammenführt.

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

## Überblick

`the-art-of-lazying-legacy` ist ein kuratiertes Dach-Repository rund um strategische Faulheit:

- Konzeptionelle Inhalte zur Anwendung der „Lazying“-Philosophie in Arbeit und Alltag.
- Praktische Code-Artefakte, einschließlich E-Ink + GPT-Sprachenlernen (`code/EinkWordsGPT`).
- Utility-Skripte für sicherere Workflows (`scripts/lazy-care/SafeShell`).
- Vlog-nahe Tools und Automatisierungs-Snippets (`vlogs/`).
- Demo-Assets und Beispiele (`demos/`, `examples/`, `figs/`).

| Snapshot | Wert |
|---|---|
| Repository-Rolle | Legacy-Archiv + Ideenlandkarte |
| Aktive Entwicklung | https://github.com/lachlanchen/the-art-of-lazying |
| Mehrsprachige README-Dateien | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n-Verzeichnis | `i18n/` (vorhanden) |

Dieses Repository bleibt als Legacy-Archiv und Ideenlandkarte nützlich, während die aktive Entwicklung in das oben verlinkte migrierte Repository verschoben wurde.

## Projekte

### 🤖 KI-gestützte Kreativ-Tools

| Projekt | Beschreibung | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-Ink-Display mit GPT-gestütztem Vokabellernen | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse von Wortherkünften und Darstellung als Graph. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Tools für effizientes Sprachenlernen mit minimalem Aufwand | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video- und Bild-Untertitelung mit OpenAI-CLIP-Embeddings + GPT-Decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Video-Captioning-Tool: Keyframes mit Katna/OpenCV extrahieren und Captions mit einem ViT+GPT-2-Modell erzeugen | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Mehrsprachige Transkriptionspipeline mit feingranularer Spracherkennung | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Sprachbarrieren für globalen kreativen Austausch abbauen | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatische Metadaten-Erzeugung für Videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | KI-gestütztes automatisches Video-Editing mit Transkription, Auto-Untertiteln, Hervorhebungen und Metadaten-Erzeugung | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Optimierung von Content-Publishing-Workflows | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automatisches System zur Überwachung, Verarbeitung und Veröffentlichung von Videoinhalten auf mehreren Plattformen | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Fortgeschrittene Techniken für den effektiven Einsatz von KI-Assistenten | |

## Automatisierungstools

Das Repository enthält lokal direkt ausführbare Automatisierungs-Utilities:

| Pfad | Zweck |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Kontinuierliche E-Ink-Wortkarten-Rendering-Schleife (Standard-Refresh alle 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch- und gezielte Aktualisierung von Wortdetails gegen OpenAI-gestützte Logik. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Hardware-Test für Waveshare 7,3\" E-Paper. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Shell-Funktionen `saferm`, `unrm` und `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Domain-zu-IP-Auflösung + deduplizierte Ausgabe. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Führt `.py`-Dateien je Unterverzeichnis in `.txt`-Dateien zusammen. |

## Ordnerstruktur

### Aktuelle Repository-Struktur (präzise)

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
├── i18n/                      # currently present
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

The Art of Lazying präsentiert strategische Faulheit als Ansatz, den Energieeinsatz zu optimieren und sich auf das zu konzentrieren, was wirklich zählt. Dieses Repository zeigt, wie absichtsvolle Faulheit zu höherer Produktivität, Kreativität und mehr Wohlbefinden führen kann.

## Die Theorie des Lazying

Eine umfassende Einführung in die Prinzipien strategischer Faulheit mit Fokus darauf, Produktivität und Wohlbefinden durch Priorisierung, Delegation und Automatisierung von Aufgaben zu maximieren.

Das Kernprinzip ist die Anwendung der Pareto-80/20-Regel auf den Alltag: die 20 % der Aktivitäten zu identifizieren, die 80 % der gewünschten Ergebnisse erzeugen.

## Praktische Tipps und Tricks

Eine Sammlung umsetzbarer Ratschläge zur Anwendung von Lazying-Prinzipien auf Arbeit, Beziehungen und Selbstfürsorge:

- Wiederkehrende Aufgaben automatisieren
- Die Pomodoro-Technik für Zeitmanagement nutzen
- Systeme aufbauen, die Entscheidungsmüdigkeit reduzieren
- KI-Tools zur Unterstützung einsetzen

## Anwendungsfälle

Beispiele aus dem echten Leben, die zeigen, wie Lazying-Prinzipien Probleme lösen und Effizienz steigern:

- Wie Unternehmer Delegation und Automatisierung nutzen, um sich auf Geschäftswachstum zu konzentrieren
- Wie Wissenschaftler Forschungs-Workflows verschlanken
- Wie Content-Creator ihren Produktionsprozess optimieren

## AI-Agenten und Automatisierung

Entdecke die Entwicklung von AI-Agenten und Automatisierungstools, die Aufgaben vereinfachen:

- ChatGPT als persönlichen Assistenten verwenden
- Eigene Automatisierungs-Workflows aufbauen
- E-Ink-Displays für passives Lernen erstellen

## Sprachenlernen und Vlogs

Ressourcen und Techniken für effizientes Sprachenlernen sowie Vlogs, die die Lazying-Reise dokumentieren:

- Personalisiertes Sprachenlernen mit Spaced Repetition erstellen
- Immersive Lerntechniken umsetzen
- Projekte bauen, die passives Lernen fördern

## Community-Beiträge

Teile deine eigenen Erfahrungen, Tipps und Ideen zu strategischer Faulheit:

- Forum zum Austausch von Produktivitäts-Hacks
- Tools und Vorlagen für tägliche Routinen
- Kollaborative Projekte für faule Effizienz

## Voraussetzungen

Das Repository enthält mehrere unabhängige Skripte, daher variieren die Voraussetzungen je nach Modul.

Gemeinsame Basis:

- Python 3.9+
- `pip`
- Git

Projektspezifische Hinweise aus den Quelldateien:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (für E-Paper-Hardwareabläufe)
- `sqlite3` (Standardbibliothek)

Hardware-Anforderungen für die vollständige `EinkWordsGPT`-Laufzeit:

- Raspberry Pi (in der Projektdokumentation wird Raspberry Pi 5 erwähnt)
- Waveshare 7-color 7.3-inch e-ink panel

## Installation

Da es kein root-weites Dependency-Manifest gibt, installiere die Abhängigkeiten manuell für das Modul, das du ausführen willst.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Optionale/Hardware-Abhängigkeit:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell-Setup:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Nutzung

### 1) EinkWordsGPT-Display-Schleife ausführen

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Wortdetails erneut prüfen/aktualisieren

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Waveshare-7,3-Zoll-Panel testen

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) ChatGPT-bezogene Domains auflösen und IP-Ausgabe erzeugen

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Python-Dateien je Verzeichnis zu KI-freundlichen Text-Bundles zusammenführen

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Sichereren Datei-Lösch-Workflow verwenden

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Konfiguration

### OpenAI-Anmeldedaten

`EinkWordsGPT` und Update-Skripte verwenden `OpenAI()` aus dem offiziellen SDK und erwarten, dass Anmeldedaten in deiner Umgebung konfiguriert sind.

Annahme (empfohlen):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Datenbankpfad

`code/EinkWordsGPT/words_gpt.py` und `words_update.py` verwenden:

- `db_path = 'words_phonetics.db'`

Führe Skripte aus `code/EinkWordsGPT` aus oder passe die Pfade an, wenn du sie von anderswo startest.

### SafeShell-Trash-Root

`saferm`/`unrm`/`removeitanyway` verwenden aktuell einen festen Basispfad:

- `/mnt/disk/BIN/ROOT`

Stelle sicher, dass dieser Pfad existiert und beschreibbar ist, bevor du dich auf `saferm` verlässt.

### Repo2Text-Pfade

`vlogs/repo2text/convert-repo-to-merged-text.py` enthält derzeit fest kodierte Pfade:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Bearbeite diese Konstanten so, dass sie zu deinem lokalen Projekt passen.

## Beispiele

### Beispiel: E-Ink-Lernkarten-Zyklus

- Skript wählt Wortdetails aus (oder lädt sie nach).
- Die Wortkarte rendert Phonetik, Silbensegmentierung und japanische Synonym-Hinweise.
- Der Bildschirm aktualisiert sich alle 5 Minuten (`time.sleep(300)`).

### Beispiel: Sicherer Lösch-Workflow

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Beispiel: Domain/IP-Ausgabedatei

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Entwicklungshinweise

- Dies ist ein Legacy-Repository; aktive Entwicklung findet statt unter: https://github.com/lachlanchen/the-art-of-lazying
- Inhalte auf Top-Level sind kuratorisch und verlinken auf viele externe Repositories.
- `i18n/` existiert, ist aber derzeit leer; Sprach-READMEs liegen aktuell auf Top-Level.
- Es gibt kein root-weites `requirements.txt` oder `pyproject.toml`.

Beibehaltener Kompatibilitätshinweis:

- Frühere Dokus in Unterordnern erwähnen eventuell Skripte (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`), die jetzt in `scripts/lazy-care/SafeShell/safeshell_functions.sh` zusammengeführt sind.

## Fehlerbehebung

- `ModuleNotFoundError`: Fehlende Python-Pakete aus [Voraussetzungen](#voraussetzungen) installieren.
- `openai`-Authentifizierungsfehler: prüfen, ob `OPENAI_API_KEY` in der Shell exportiert ist.
- Waveshare-Laufzeitprobleme: SPI/Device-Setup prüfen und Vendor-Abhängigkeiten auf dem Pi installieren.
- `saferm` scheint nichts zu tun: prüfen, ob `/mnt/disk/BIN/ROOT` existiert und Schreibrechte hat.
- `repo2text` erzeugt keine Dateien: sicherstellen, dass `source_directory` auf einen vorhandenen Ordner mit `.py`-Dateien zeigt.
- `chatgpt-traffic`-Domain-Anomalien: die `domains`-Liste im Skript vor produktivem Einsatz prüfen und bereinigen.

## Roadmap

- Dieses Repository als stabiles Legacy-Archiv mit klaren Verweisen auf aktive Projekte beibehalten.
- Dependency-Manifeste für jedes ausführbare Untermodul verbessern.
- In zukünftigen Revisionen ein konsistentes i18n-Layout unter `/i18n` ergänzen.
- Praktische Beispiele und reproduzierbare Setup-Anleitungen für Hardware- und Nicht-Hardware-Flows erweitern.

## Mitwirken

Beiträge sind willkommen.

1. Forke das Projekt.
2. Erstelle deinen Feature-Branch (`git checkout -b feature/AmazingFeature`).
3. Committe deine Änderungen (`git commit -m 'Add some AmazingFeature'`).
4. Pushe den Branch (`git push origin feature/AmazingFeature`).
5. Öffne einen Pull Request.

Du kannst auch beitragen, indem du:

- Verbesserungen für Workflows strategischer Faulheit vorschlägst.
- Probleme in Skripten oder Dokumentation meldest.
- Die Reproduzierbarkeit von Setups für Hardware-/Software-Pfade verbesserst.

## Lizenz

Dieses Repository ist unter der GNU General Public License v3.0 lizenziert. Siehe [LICENSE](LICENSE).

## Danksagungen

Besonderer Dank gilt den Beitragenden, dem OpenAI-Team sowie den Raspberry-Pi-/Maker-Communities, die Experimente rund um Lernsysteme mit geringer Reibung unterstützen.

## Kontakt

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
