[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# Die Kunst des Faulenzens

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

Ein Repository, das sich auf strategische Faulheit für ein einfacheres, leistungsstärkeres Leben konzentriert und KI-Agenten, Sprachlernen, praktische Automatisierung sowie vlog-basierte Workflows in der realen Welt abdeckt.

| Fokus | Inhalt dieses README |
|---|---|
| 🤖 Automatisierung | Kernwerkzeuge, Skripte und praktische Workflows, die du lokal ausführen kannst |
| 🧠 Lernen | Sprachbezogene Erstprojekte und Beispiele für effiziente Lerngewohnheiten |
| 📚 Teilen | Mehrsprachige Dokumentation, Projektlinks und Beitragsanleitungen |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Inhaltsverzeichnis

- [Überblick](#überblick)
- [Projekte](#projekte)
- [Repository-Struktur](#repository-struktur)
- [Funktionen](#funktionen)
- [Voraussetzungen](#voraussetzungen)
- [Installation](#installation)
- [Verwendung](#verwendung)
- [Konfiguration](#konfiguration)
- [Beispiele](#beispiele)
- [Entwicklungsnotizen](#entwicklungsnotizen)
- [Fehlerbehebung](#fehlerbehebung)
- [Roadmap](#roadmap)
- [Einführung](#einführung)
- [Die Theorie des Faulenzens](#die-theorie-des-faulenzens)
- [Praktische Tipps und Tricks](#praktische-tipps-und-tricks)
- [Anwendungsfälle](#anwendungsfälle)
- [KI-Agenten und Automatisierung](#ki-agenten-und-automatisierung)
- [Sprachlernen und Vlogs](#sprachlernen-und-vlogs)
- [Community-Beiträge](#community-beiträge)
- [❤️ Support](#-support)
- [Kontakt](#kontakt)
- [Beiträge](#beiträge)
- [Lizenz](#lizenz)

## Überblick

`the-art-of-lazying` ist ein Hub-Repository für strategische, praktische Faulheit: Automatisiere repetitive Arbeit, verbessere Sprachlern-Workflows und dokumentiere reale Experimente mit Skripten und Vlogs.

| Auf einen Blick | Details |
|---|---|
| 🎯 Kernthema | Strategische Faulheit für Produktivität, Lernen und kreative Ergebnisse |
| 🧩 Repository-Stil | Mischung aus lokalen Tools + kuratierten externen Projekten |
| 🛠️ Lokale Highlights | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Dokumentation | Haupt-README + mehrsprachige Varianten in `i18n/` |

Dieses Repository enthält beides:
- kuratierte Links zu verwandten externen Projekten.
- lokale Tools und Code, insbesondere:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare E-Ink + OpenAI-Wortlern-Anzeige).
  - `scripts/lazy-care/SafeShell` (sichere Shell-Funktionen zum Löschen/Wiederherstellen).
  - `vlogs/chatgpt-traffic` und `vlogs/repo2text` (kleine Python-Utilities).

## Projekte

### 🚀 KI-gestützte kreative Werkzeuge

| Projekt | Beschreibung | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-Ink-Anzeige mit GPT-gestütztem Wortlernen | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse der Wortherkunft und Darstellung als Graph. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Werkzeuge für effizientes Sprachenlernen mit möglichst wenig Aufwand | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video- und Bildunterschriftenerstellung mit OpenAI CLIP-Embeddings + GPT-Decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Video-Untertitelung: Schlüsselbilder mit Katna/OpenCV extrahieren und Untertitel mit einem ViT+GPT-2-Modell generieren | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Mehrsprachige Transkriptions-Pipeline mit fein-granularer Spracherkennung | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Sprachbarrieren für globalen kreativen Austausch abbauen | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatische Metadaten-Erstellung für Videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | KI-gestütztes automatisches Videobearbeitungswerkzeug mit Transkription, Auto-Untertiteln, Hervorhebungen und Metadaten-Generierung | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Vereinheitlichung von Veröffentlichungs-Workflows | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automatisiertes System zum Überwachen, Verarbeiten und Veröffentlichen von Videoinhalten auf mehreren Plattformen | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Fortgeschrittene Techniken für den effizienten Einsatz von KI-Assistenten | |

### ⚙️ Automatisierungswerkzeuge (lokal in diesem Repository)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: sichere Shell-Löschoperationen (`saferm`), Wiederherstellung (`unrm`) und explizite dauerhafte Löschung (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: Domain-zu-IP-Auflösung und deduplizierte Ausgabegenerierung.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: Führt Python-Dateien pro Verzeichnis in Textbündel für KI-gestützte Analyse zusammen.

## Repository-Struktur

```text
the-art-of-lazying/
├── README.md
├── README_EN.md
├── README_CN.md
├── LICENSE
├── .github/
│   └── FUNDING.yml
├── i18n/
│   ├── README.ar.md
│   ├── README.es.md
│   ├── README.fr.md
│   ├── README.ja.md
│   ├── README.ko.md
│   ├── README.vi.md
│   ├── README.zh-Hans.md
│   └── README.zh-Hant.md
├── code/
│   └── EinkWordsGPT/
│       ├── README.md
│       ├── README_CN.md
│       ├── words_gpt.py
│       ├── words_data.py
│       ├── words_update.py
│       ├── epd_7in3f_test.py
│       ├── words_phonetics.db
│       ├── data/
│       ├── font/
│       └── pic/
├── scripts/
│   └── lazy-care/
│       ├── README.md
│       └── SafeShell/
│           ├── README.md
│           └── safeshell_functions.sh
├── examples/
│   └── lazy-learning/BuildChachaGPTWithChatGPT/
├── books/
├── demos/
├── figs/
└── vlogs/
    ├── chatgpt-traffic/
    ├── repo2text/
    └── google-framework/
```

Hinweis: Ältere, allgemeine Ordnerdiagramme in früheren README-Versionen verwiesen auf abstrakte Pfade (zum Beispiel `book/`, `code/ai-agents/`), die nicht exakt mit dem aktuellen Repository-Baum übereinstimmen. Die obige Struktur spiegelt die aktuellen Dateien wider.

## Funktionen

- Framework für strategische Faulheit in Bereichen Produktivität, Lernen und Content-Workflows.
- Kuratierte KI-Projektpalette über Transkription, Untertitelung, Übersetzung und Publikationsautomatisierung.
- Hardware-basiertes Sprachlernen mit GPT-gestützter Wortauswahl (`EinkWordsGPT`).
- Praktische Shell-Sicherheitstools für umkehrbare Löschvorgänge.
- Skriptbasierte Utilities für DNS/Domain-Traffic-Prüfungen und Repository-zu-Text-Konvertierung.
- Mehrsprachige Dokumentationsunterstützung über `i18n/`.

## Voraussetzungen

Allgemein:
- Git
- Python 3.9+ empfohlen

Für `code/EinkWordsGPT`:
- Raspberry Pi (die Projektdokumentation erwähnt Raspberry Pi 5)
- Waveshare 7.3-inch 7-color e-ink Display mit Python-Treiber-Support (`waveshare_epd`)
- In der Codebasis verwendete Python-Pakete: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (Python Standardbibliothek `sqlite3` wird verwendet)
- OpenAI API-Schlüssel in der Umgebung konfiguriert (der Code initialisiert `OpenAI()` direkt)

Für `vlogs/chatgpt-traffic`:
- `dnspython`

Für `scripts/lazy-care/SafeShell`:
- Bash oder Zsh mit Zugriff auf `realpath`, `mv` und `/bin/rm`

## Installation

Repository klonen:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Üblich benötigte Python-Abhängigkeiten installieren (Repository-weit):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Hinweis: `code/EinkWordsGPT/README.md` erwähnt `requirements.txt`, aber aktuell ist keine `requirements.txt` in diesem Repository vorhanden. Installiere die Pakete wie oben manuell.

## Verwendung

### 1) EinkWordsGPT (lokaler Hardware-Workflow)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optionaler Hardware-/Display-Test
python words_gpt.py        # Skript-Schleife starten (aktualisiert ca. alle 300 s)
```

Optionales Datenbank-Wartungsskript:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (sichererer Lösch-Workflow)

Shell-Funktionen laden:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # oder ~/.zshrc
source ~/.bashrc                          # oder source ~/.zshrc
```

Befehle verwenden:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) ChatGPT Traffic Resolver

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text-Merger

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Hinweis: `convert-repo-to-merged-text.py` verwendet derzeit harte Pfade (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Passe diese Konstanten vor dem Einsatz in einem anderen Repository an.

## Konfiguration

### OpenAI-Konfiguration (`code/EinkWordsGPT`)

Der Code erstellt den Client mit:

```python
client = OpenAI()
```

Richte daher deine API-Anmeldedaten mit der üblichen OpenAI-Umgebungsvariablen-Methode ein, bevor du Skripte ausführst.

### Datenbankpfad (`code/EinkWordsGPT`)

Standard im Code:

```python
db_path = 'words_phonetics.db'
```

Vergewissere dich, dass `words_phonetics.db` in `code/EinkWordsGPT/` vorhanden ist (sie ist derzeit im Repository enthalten).

### SafeShell Papierkorb-Speicherort

`saferm`/`unrm`/`removeitanyway` nutzen einen festen Basis-Pfad:

```bash
/mnt/disk/BIN/ROOT
```

Passe diesen Pfad in `scripts/lazy-care/SafeShell/safeshell_functions.sh` an, falls deine Umgebung abweicht.

## Beispiele

- E-Ink-Wortkarten-Demos in `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Build-Hinweise/-Materialien für ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Entwicklungsnotizen

- Dieses Repository ist eine Multi-Projekt-Showcase-Sammlung mit lokaler Codebasis und externen Projektlinks.
- Es gibt derzeit kein Root-Paketmanager- oder Build-Manifest (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` sind auf Root-Ebene nicht vorhanden).
- Mehrere Unter-Readmes sind template-ähnlich und können teilweise im Vergleich zum aktuellen Dateilayout veraltet sein; die Befehle in diesem README sind an die aktuell vorhandenen Pfade/Skripte angepasst.
- `README_EN.md` und `README_CN.md` existieren als Altvarianten; `README.md` + `i18n/*` sind die aktive mehrsprachige Struktur.

## Fehlerbehebung

- `ModuleNotFoundError` bei Python-Paketen:
  - Installiere die Abhängigkeiten erneut mit `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` in `EinkWordsGPT`:
  - Installiere die Waveshare e-paper Python-Treiber-/Bibliothek in deiner Raspberry-Pi-Umgebung.

- OpenAI-Authentifizierungsfehler:
  - Vergewissere dich, dass dein OpenAI API-Key als Umgebungsvariable gesetzt ist, bevor du `words_gpt.py` oder `words_update.py` ausführst.

- `saferm`/`unrm` nicht gefunden nach Einrichtung:
  - Prüfe, dass du die richtige Shell-RC-Datei geladen und `safeshell_functions.sh` erfolgreich angehängt hast.

- `unrm` kann Dateien nicht wiederherstellen:
  - Prüfe, dass dein Wiederherstellungs-Pfad zum spiegelbildlichen Papierkorb-Layout von SafeShell unter `/mnt/disk/BIN/ROOT` passt.

- Skript `repo2text` erzeugt keine Ausgabe:
  - Aktualisiere `source_directory` in `convert-repo-to-merged-text.py` auf einen vorhandenen Ordner.

## Roadmap

- Ausbau der README-Übereinstimmung in allen i18n-Dateien (derzeit eher Zusammenfassungen in vielen Sprachen).
- Ergänzung von umgebungsspezifischen Setup-Dokumenten für Waveshare e-ink Treiber.
- Erstellen eines reproduzierbaren Root-Level-Abhängigkeitsmanifests für lokale Tools.
- Hinzufügen von Validierungs-/Testskripten für kritische Utilities.
- Fortsetzung der Konsolidierung externer Projektlinks mit aussagekräftigeren lokalen Demos.

## Einführung

Die Kunst des Faulenzens versteht strategische Faulheit als Methode, Energieeinsatz zu optimieren und sich auf das zu konzentrieren, was wirklich zählt. Dieses Repository untersucht, wie absichtliches Faulen zu höherer Produktivität, Kreativität und Lebensqualität führen kann.

## Die Theorie des Faulenzens

Eine umfassende Einführung in die Prinzipien der strategischen Faulheit mit Fokus darauf, wie Produktivität und Wohlbefinden durch Priorisierung, Delegieren und Automatisieren von Aufgaben maximiert werden.

Der Kern ist die Anwendung von Pareto's 80/20-Regel auf den Alltag: Identifiziere die 20 % der Aktivitäten, die 80 % der gewünschten Ergebnisse liefern.

## Praktische Tipps und Tricks

Eine Sammlung umsetzbarer Ratschläge zur Anwendung fauler Prinzipien in Arbeit, Beziehungen und Selbstfürsorge:
- Automatisiere repetitive Aufgaben
- Nutze die Pomodoro-Technik für das Zeitmanagement
- Erstelle Systeme, die Entscheidungsmüdigkeit reduzieren
- Nutze KI-Tools als Unterstützung

## Anwendungsfälle

Praxisnahe Beispiele dafür, wie Faulheitsprinzipien Probleme lösen und Effizienz verbessern:
- Wie Unternehmer Delegation und Automatisierung nutzen, um sich auf Geschäftswachstum zu fokussieren
- Wie Wissenschaftler Forschungsabläufe verschlanken
- Wie Content-Creator ihren Produktionsprozess optimieren

## KI-Agenten und Automatisierung

Erkunde die Entwicklung von KI-Agenten und Automatisierungswerkzeugen, die Aufgaben vereinfachen:
- ChatGPT als persönlicher Assistent
- Eigene Automatisierungs-Workflows bauen
- E-Ink-Displays für passives Lernen erstellen

## Sprachlernen und Vlogs

Ressourcen und Techniken für effizientes Sprachenlernen sowie Vlogs, die den „Lazying“-Weg dokumentieren:
- Personalisierte Sprachlern-Projekte mit Spaced Repetition
- Umsetzung immersiver Lernmethoden
- Aufbau von Projekten, die passives Lernen fördern

## Community-Beiträge

Teile deine eigenen Erfahrungen, Tipps und Ideen zu strategischer Faulheit:
- Forum für den Austausch von Produktivitäts-Hacks
- Werkzeuge und Vorlagen für tägliche Routinen
- Kollaborative Projekte für „lazy efficiency"

## Kontakt

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- E-Mail: lach@lazying.art

## Beiträge

Beiträge sind willkommen in Code, Dokumentation, Beispielen und Übersetzungen.

1. Forke das Repository.
2. Erstelle einen Branch (`git checkout -b feature/your-feature`).
3. Nimm Änderungen mit klaren Commit-Meldungen vor.
4. Eröffne einen Pull Request mit Motivation und Auswirkung.

Wenn du nicht weißt, wo du anfangen sollst:
- Verbessere die Setup-Dokumentation für ein lokales Tool.
- Füge Tests oder Validierungsskripte für bestehende Utilities hinzu.
- Verbessere die Konsistenz/Qualität einer `i18n/README.*.md`-Variante.

## Lizenz

Diese Repository enthält den GPLv3-Lizenztext im Root (`LICENSE`) und in mehreren Unterordnern.

Hinweis: Einige Unterprojekt-READMEs nennen MIT. Solange jedes Unterprojekt nicht einzeln geklärt ist, gilt das Wurzel-Repository als GPLv3-gesteuert; prüfe bei geplanter unabhängiger Weiterverbreitung pro Unterprojekt.


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
