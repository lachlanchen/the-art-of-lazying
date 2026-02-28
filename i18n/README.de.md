[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

# The Art of Lazying

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

Ein Repository mit Fokus auf strategische Faulheit für ein einfacheres, wirkungsvolleres Leben, mit Themen wie AI-Agents, Sprachlernen, praktischer Automatisierung und vlog-basierten Workflows aus der realen Welt.

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
- [Hinweise zur Entwicklung](#hinweise-zur-entwicklung)
- [Fehlerbehebung](#fehlerbehebung)
- [Roadmap](#roadmap)
- [Einführung](#einführung)
- [Die Theorie des Lazying](#die-theorie-des-lazying)
- [Praktische Tipps und Tricks](#praktische-tipps-und-tricks)
- [Anwendungsfälle](#anwendungsfälle)
- [AI-Agents und Automatisierung](#ai-agents-und-automatisierung)
- [Sprachlernen und Vlogs](#sprachlernen-und-vlogs)
- [Community-Beiträge](#community-beiträge)
- [Kontakt](#kontakt)
- [Unterstützung / Spenden](#unterstützung--spenden)
- [Mitwirken](#mitwirken)
- [Lizenz](#lizenz)

## Überblick

`the-art-of-lazying` ist ein Hub-Repository für praktische strategische Faulheit: repetitive Arbeit automatisieren, Sprachlern-Workflows verbessern und reale Experimente über Skripte und Vlogs dokumentieren.

| Auf einen Blick | Details |
|---|---|
| 🎯 Kernthema | Strategische Faulheit für Produktivität, Lernen und kreativen Output |
| 🧩 Repository-Stil | Hybrid aus lokalen Tools + kuratierten externen Projekten |
| 🛠️ Lokale Highlights | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Dokumentation | Root-README + mehrsprachige Varianten in `i18n/` |

Dieses Repository enthält beides:
- Kuratierte Links zu verwandten externen Projekten.
- Lokale Tools und Code, insbesondere:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare E-Ink + OpenAI-Wortlern-Display).
  - `scripts/lazy-care/SafeShell` (sichere Delete/Restore-Shell-Funktionen).
  - `vlogs/chatgpt-traffic` und `vlogs/repo2text` (kleine Python-Utilities).

## Projekte

### 🚀 KI-gestützte Kreativ-Tools

| Projekt | Beschreibung | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-Ink-Display mit GPT-gestütztem Wortlernen | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse des Wortursprungs und Darstellung als Graph. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Tools für effizientes Sprachlernen mit minimalem Aufwand | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video- und Bild-Beschriftung mit OpenAI-CLIP-Embeddings + GPT-Decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Video-Captioning-Tool: Keyframes mit Katna/OpenCV extrahieren und Captions mit einem ViT+GPT-2-Modell erzeugen | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Mehrsprachige Transkriptions-Pipeline mit fein granularer Spracherkennung | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Sprachbarrieren für globalen kreativen Austausch abbauen | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatische Metadaten-Erzeugung für Videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | KI-gestütztes automatisches Video-Editing mit Transkription, Auto-Untertiteln, Highlighting und Metadaten-Erzeugung | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Content-Publishing-Workflows optimieren | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automatisiertes System zur Überwachung, Verarbeitung und Veröffentlichung von Videoinhalten auf mehreren Plattformen | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Fortgeschrittene Techniken für den effektiven Einsatz von KI-Assistenten | |

### ⚙️ Automatisierungs-Tools (lokal in diesem Repository)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: sichereres Löschen in der Shell (`saferm`), Wiederherstellung (`unrm`) und explizites permanentes Löschen (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: Domain-zu-IP-Resolver und Generator für deduplizierte Ausgaben.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: fasst Python-Dateien nach Verzeichnis zu Text-Bundles für KI-gestützte Analyse zusammen.

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

Hinweis: Ältere generische Ordnerdiagramme in früheren README-Varianten verweisen auf abstrakte Pfade (z. B. `book/`, `code/ai-agents/`), die nicht exakt zum aktuellen Repository-Baum passen. Die obige Struktur spiegelt den aktuellen Dateistand wider.

## Funktionen

- Framework für strategische Faulheit in Produktivität, Lernen und Content-Workflows.
- Kuratiertes KI-Projektportfolio mit Transkription, Captioning, Übersetzung und Publishing-Automatisierung.
- Hardware-integriertes Sprachlernen mit GPT-unterstützter Wortauswahl (`EinkWordsGPT`).
- Praktische Shell-Sicherheitswerkzeuge für reversible Lösch-Workflows.
- Utility-Skripte nach dem Script-first-Prinzip für DNS/Domain-Traffic-Checks und Repository-zu-Text-Konvertierung.
- Mehrsprachige Dokumentation über `i18n/`.

## Voraussetzungen

Allgemein:
- Git
- Python 3.9+ empfohlen

Für `code/EinkWordsGPT`:
- Raspberry Pi (in den Projektdokumenten wird Raspberry Pi 5 erwähnt)
- Waveshare 7.3-Zoll-7-Farben-E-Ink-Display mit Python-Treiber-Support (`waveshare_epd`)
- In Code verwendete Python-Pakete: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (Python-Stdlib `sqlite3` wird verwendet)
- OpenAI API key in Umgebungsvariablen konfiguriert (der Code initialisiert `OpenAI()` direkt)

Für `vlogs/chatgpt-traffic`:
- `dnspython`

Für `scripts/lazy-care/SafeShell`:
- Bash- oder Zsh-Shell mit Zugriff auf `realpath`, `mv` und `/bin/rm`

## Installation

Repository klonen:

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Häufig genutzte Python-Abhängigkeiten installieren (repository-weite Basis):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Hinweis: `code/EinkWordsGPT/README.md` erwähnt `requirements.txt`, aber aktuell ist keine `requirements.txt` in diesem Repository vorhanden. Installiere die Pakete manuell wie oben.

## Verwendung

### 1) EinkWordsGPT (lokaler Hardware-Flow)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optionaler Hardware-/Display-Test
python words_gpt.py        # startet die Display-Schleife (aktualisiert etwa alle 300 s)
```

Optionales Skript zur Datenbankpflege:

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

### 3) ChatGPT-Traffic-Resolver

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text-Merger

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Hinweis: `convert-repo-to-merged-text.py` verwendet derzeit hartcodierte Pfade (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Bearbeite diese Konstanten vor der Ausführung für ein anderes Repository.

## Konfiguration

### OpenAI-Konfiguration (`code/EinkWordsGPT`)

Der Code erstellt den Client mit:

```python
client = OpenAI()
```

Konfiguriere daher deine API-Zugangsdaten mit dem Standardansatz über OpenAI-Umgebungsvariablen, bevor du die Skripte ausführst.

### Datenbankpfad (`code/EinkWordsGPT`)

Standard im Code:

```python
db_path = 'words_phonetics.db'
```

Stelle sicher, dass `words_phonetics.db` in `code/EinkWordsGPT/` vorhanden ist (die Datei ist aktuell in diesem Repository enthalten).

### SafeShell-Papierkorbpfad

`saferm`/`unrm`/`removeitanyway` verwenden einen festen Basispfad:

```bash
/mnt/disk/BIN/ROOT
```

Passe diesen Pfad in `scripts/lazy-care/SafeShell/safeshell_functions.sh` an, wenn sich deine Umgebung unterscheidet.

## Beispiele

- E-Ink-Wortkarten-Demos in `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Build-Notizen/Materialien für ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Hinweise zur Entwicklung

- Dies ist ein Multi-Projekt-Showcase-Repository mit lokalem Code und externen Projektlinks.
- Aktuell gibt es auf Root-Ebene keinen Package-Manager oder Build-Manifest (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` sind im Root nicht vorhanden).
- Mehrere Unter-READMEs sind eher vorlagenartig und können gegenüber dem aktuellen Dateilayout teilweise veraltet sein; die Befehle in diesem README sind auf aktuell existierende Pfade/Skripte abgestimmt.
- `README_EN.md` und `README_CN.md` existieren als ältere Varianten; `README.md` + `i18n/*` ist die aktive mehrsprachige Struktur.

## Fehlerbehebung

- `ModuleNotFoundError` für Python-Pakete:
  - Installiere Abhängigkeiten erneut mit `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` in `EinkWordsGPT`:
  - Installiere den Waveshare-E-Paper-Python-Treiber/die Bibliothek in deiner Raspberry-Pi-Umgebung.

- OpenAI-Authentifizierungsfehler:
  - Prüfe, ob dein OpenAI API key vor dem Ausführen von `words_gpt.py` oder `words_update.py` in den Umgebungsvariablen gesetzt ist.

- `saferm`/`unrm` nach der Einrichtung nicht gefunden:
  - Stelle sicher, dass du die richtige Shell-RC-Datei geladen und `safeshell_functions.sh` erfolgreich angehängt hast.

- `unrm` kann Dateien nicht wiederherstellen:
  - Prüfe, ob dein Wiederherstellungspfad zur gespiegelten Papierkorbstruktur von SafeShell unter `/mnt/disk/BIN/ROOT` passt.

- `repo2text`-Skript erzeugt keine Ausgabe:
  - Setze `source_directory` in `convert-repo-to-merged-text.py` auf einen existierenden Ordner.

## Roadmap

- Parität der Root-README in allen i18n-Dateien ausbauen (aktuell sind viele Sprachen noch zusammengefasst).
- Umgebungsabhängige Setup-Dokumentation für Waveshare-E-Ink-Treiber hinzufügen.
- Reproduzierbare Abhängigkeits-Manifeste auf Root-Ebene für lokale Tools hinzufügen.
- Validierungs-/Testskripte für kritische Utilities ergänzen.
- Externe Projektlinks weiter konsolidieren und lokale Demos ausbauen.

## Einführung

The Art of Lazying stellt strategische Faulheit als Ansatz vor, den Energieeinsatz zu optimieren und sich auf das wirklich Wichtige zu konzentrieren. Dieses Repository zeigt, wie bewusste Faulheit zu höherer Produktivität, Kreativität und Lebensqualität führen kann.

## Die Theorie des Lazying

Eine umfassende Einführung in die Prinzipien strategischer Faulheit mit Fokus darauf, Produktivität und Wohlbefinden durch Priorisieren, Delegieren und Automatisieren zu maximieren.

Das zentrale Prinzip ist die Anwendung der Pareto-80/20-Regel auf den Alltag: die 20 % der Aktivitäten identifizieren, die 80 % der gewünschten Ergebnisse liefern.

## Praktische Tipps und Tricks

Eine Sammlung umsetzbarer Hinweise, wie sich Lazying-Prinzipien auf Arbeit, Beziehungen und Selbstfürsorge anwenden lassen:
- Wiederkehrende Aufgaben automatisieren
- Die Pomodoro-Technik für Zeitmanagement nutzen
- Systeme aufbauen, die Entscheidungsmüdigkeit reduzieren
- KI-Tools zur Unterstützung einsetzen

## Anwendungsfälle

Praxisnahe Beispiele, die zeigen, wie Lazying-Prinzipien Probleme lösen und Effizienz steigern:
- Wie Unternehmer Delegation und Automatisierung nutzen, um sich auf Unternehmenswachstum zu konzentrieren
- Wie Akademiker Forschungs-Workflows verschlanken
- Wie Content-Creator ihren Produktionsprozess optimieren

## AI-Agents und Automatisierung

Entdecke die Entwicklung von AI-Agents und Automatisierungs-Tools, die Aufgaben vereinfachen:
- ChatGPT als persönlicher Assistent
- Eigene Automatisierungs-Workflows bauen
- E-Ink-Displays für passives Lernen erstellen

## Sprachlernen und Vlogs

Ressourcen und Techniken für effizientes Sprachlernen sowie Vlogs, die die Lazying-Reise dokumentieren:
- Personalisiertes Sprachlernen mit Spaced Repetition erstellen
- Immersive Lerntechniken umsetzen
- Projekte bauen, die passives Lernen fördern

## Community-Beiträge

Teile deine eigenen Erfahrungen, Tipps und Ideen zu strategischer Faulheit:
- Forum zum Austausch von Produktivitäts-Hacks
- Tools und Vorlagen für tägliche Routinen
- Kollaborative Projekte für effiziente Faulheit

## Kontakt

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## Unterstützung / Spenden

<div align="center">
<table style="margin:0 auto; text-align:center; border-collapse:collapse;">
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate">https://chat.lazying.art/donate</a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate"><img src="figs/donate_button.svg" alt="Donate" height="44"></a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://paypal.me/RongzhouChen">
        <img src="https://img.shields.io/badge/PayPal-Donate-003087?logo=paypal&logoColor=white" alt="Donate with PayPal">
      </a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400">
        <img src="https://img.shields.io/badge/Stripe-Donate-635bff?logo=stripe&logoColor=white" alt="Donate with Stripe">
      </a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>WeChat</strong></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>Alipay</strong></td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="WeChat QR" src="figs/donate_wechat.png" width="240"/></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="Alipay QR" src="figs/donate_alipay.png" width="240"/></td>
  </tr>
</table>
</div>

Zusätzliche Funding-Links aus `.github/FUNDING.yml`:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## Mitwirken

Beiträge sind bei Code, Doku, Beispielen und Übersetzungen willkommen.

1. Forke das Repository.
2. Erstelle einen Branch (`git checkout -b feature/your-feature`).
3. Nimm Änderungen mit klaren Commit-Messages vor.
4. Öffne einen Pull Request mit Motivation und Auswirkungen.

Wenn du nicht weißt, wo du anfangen sollst:
- Setup-Dokumentation für ein lokales Tool verbessern.
- Tests oder Validierungsskripte für bestehende Utilities ergänzen.
- Parität/Qualität für eine Variante `i18n/README.*.md` verbessern.

## Lizenz

Dieses Repository enthält den GPLv3-Lizenztext im Root (`LICENSE`) sowie in mehreren Unterordnern.

Hinweis: Einige Subprojekt-READMEs erwähnen MIT. Bis jedes Submodul geklärt ist, behandle das Root-Repository als GPLv3-reguliert und prüfe pro Subprojekt, wenn du Code unabhängig weiterverteilen möchtest.
