[English](README.md) · [العربية](i18n/README.ar.md) · [Español](i18n/README.es.md) · [Français](i18n/README.fr.md) · [日本語](i18n/README.ja.md) · [한국어](i18n/README.ko.md) · [Tiếng Việt](i18n/README.vi.md) · [中文 (简体)](i18n/README.zh-Hans.md) · [中文（繁體）](i18n/README.zh-Hant.md) · [Deutsch](i18n/README.de.md) · [Русский](i18n/README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> Note: This repository has been migrated. Active development continues at https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

A repository that promotes strategic laziness for a simplified, productive life, encompassing AI agents, language learning, and vlogs with practical tips and real-life use cases.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Table of Contents

- [Overview](#overview)
- [Projects](#projects)
- [Automation Tools](#automation-tools)
- [Folder Structure](#folder-structure)
- [Introduction](#introduction)
- [The Theory of Lazying](#the-theory-of-lazying)
- [Practical Tips and Tricks](#practical-tips-and-tricks)
- [Use Cases](#use-cases)
- [AI Agents and Automation](#ai-agents-and-automation)
- [Language Learning and Vlogs](#language-learning-and-vlogs)
- [Community Contributions](#community-contributions)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Examples](#examples)
- [Development Notes](#development-notes)
- [Troubleshooting](#troubleshooting)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Connect](#connect)

## Overview

`the-art-of-lazying-legacy` is a curated umbrella repository around strategic laziness:

- Conceptual content about applying the "lazying" philosophy to work and life.
- Practical code artifacts, including e-ink + GPT language learning (`code/EinkWordsGPT`).
- Utility scripts for safer workflows (`scripts/lazy-care/SafeShell`).
- Vlog-side tooling and automation snippets (`vlogs/`).
- Demo assets and examples (`demos/`, `examples/`, `figs/`).

| Snapshot | Value |
|---|---|
| Repository role | Legacy archive + idea map |
| Active development | https://github.com/lachlanchen/the-art-of-lazying |
| Multilingual README files | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n directory | `i18n/` (present) |

This repository remains useful as a legacy archive and idea map, while active development has moved to the migrated repository linked above.

## Projects

### 🤖 AI-Powered Creative Tools

| Project | Description | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-ink display with GPT-powered word learning | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Words origin analysis and presenting in graph. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Tools for efficient language learning with minimal effort | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video & image captioning with OpenAI CLIP embeddings + GPT decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Video captioning tool: extract key-frames with Katna/OpenCV & generate captions with a ViT+GPT-2 model | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Multilingual transcription pipeline with fine-grained language detection | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Breaking language barriers for global creative exchange | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatic metadata generation for videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI-powered automatic video editing tool with transcription, auto-subtitle, highlighting, and metadata generation | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Streamlining content publishing workflows | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automated system for monitoring, processing, and publishing video content to multiple platforms | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Advanced techniques for effectively using AI assistants | |

## Automation Tools

The repository includes directly runnable local automation utilities:

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Continuous e-ink word-card rendering loop (default refresh every 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch and targeted word detail refresh against OpenAI-backed logic. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3" e-paper hardware test. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, and `removeitanyway` shell functions. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Domain-to-IP resolution + deduplicated output. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Merge `.py` files by subdirectory into `.txt` files. |

## Folder Structure

### Current Repository Structure (accurate)

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

### Original Conceptual Structure (preserved)

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

> Note: The conceptual map above is intentionally preserved from earlier README versions. The "Current Repository Structure" block reflects the concrete tree in this legacy repository.

## Introduction

The Art of Lazying presents strategic laziness as a way to optimize energy use and focus on what truly matters. This repository explores how intentional laziness can lead to higher productivity, creativity, and well-being.

## The Theory of Lazying

A comprehensive introduction to the principles of strategic laziness, focusing on how to maximize productivity and well-being by prioritizing, delegating, and automating tasks.

The key principle is applying Pareto's 80/20 rule to daily life - identifying the 20% of activities that produce 80% of desired outcomes.

## Practical Tips and Tricks

A collection of actionable advice on applying lazy principles to work, relationships, and self-care:

- Automating repetitive tasks
- Using the Pomodoro Technique for time management
- Creating systems that reduce decision fatigue
- Leveraging AI tools for assistance

## Use Cases

Real-life examples demonstrating how lazying principles solve problems and improve efficiency:

- How entrepreneurs use delegation and automation to focus on business growth
- How academics streamline research workflows
- How content creators optimize their production process

## AI Agents and Automation

Explore the development of AI agents and automation tools that simplify tasks:

- Using ChatGPT as a personal assistant
- Building custom automation workflows
- Creating e-ink displays for passive learning

## Language Learning and Vlogs

Resources and techniques for efficient language learning, plus vlogs documenting the lazying journey:

- Creating personalized language learning with spaced repetition
- Implementing immersive learning techniques
- Building projects that encourage passive learning

## Community Contributions

Share your own experiences, tips, and ideas on strategic laziness:

- Forum for exchanging productivity hacks
- Tools and templates for daily routines
- Collaborative projects for lazy efficiency

## Prerequisites

The repository contains multiple independent scripts, so prerequisites vary by module.

Common baseline:

- Python 3.9+
- `pip`
- Git

Project-specific signals from source files:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (for e-paper hardware flows)
- `sqlite3` (standard library)

Hardware requirements for full `EinkWordsGPT` runtime:

- Raspberry Pi (project docs mention Raspberry Pi 5)
- Waveshare 7-color 7.3-inch e-ink panel

## Installation

Because there is no root dependency manifest, install dependencies manually for the module you want to run.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Optional/hardware dependency:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell setup:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Usage

### 1) Run EinkWordsGPT display loop

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Recheck/update word details

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Test Waveshare 7.3-inch panel

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Resolve ChatGPT-related domains and IP output

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Merge Python files by directory for AI-friendly text bundles

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Use safer file-delete workflow

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Configuration

### OpenAI Credentials

`EinkWordsGPT` and update scripts use `OpenAI()` from the official SDK and expect credentials to be configured in your environment.

Assumption (recommended):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Database Location

`code/EinkWordsGPT/words_gpt.py` and `words_update.py` use:

- `db_path = 'words_phonetics.db'`

Run scripts from `code/EinkWordsGPT` or update paths if launching elsewhere.

### SafeShell Trash Root

`saferm`/`unrm`/`removeitanyway` currently use a fixed base path:

- `/mnt/disk/BIN/ROOT`

Ensure this path exists and is writable before relying on `saferm`.

### Repo2Text Paths

`vlogs/repo2text/convert-repo-to-merged-text.py` currently has hard-coded paths:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Edit these constants to match your local project.

## Examples

### Example: E-ink learning card cycle

- Script chooses (or fetches) word details.
- Word card renders phonetics, syllable segmentation, and Japanese synonym hints.
- Screen refreshes every 5 minutes (`time.sleep(300)`).

### Example: Safe deletion workflow

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Example: Domain/IP output file

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Development Notes

- This is a legacy repository; active development is at: https://github.com/lachlanchen/the-art-of-lazying
- Top-level content is curatorial and links to many external repositories.
- `i18n/` exists but is currently empty; language READMEs currently live at top level.
- No root `requirements.txt` or `pyproject.toml` is present.

Preserved compatibility note:

- Earlier docs in subfolders may mention scripts (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) that are now consolidated in `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Troubleshooting

- `ModuleNotFoundError`: Install missing Python packages listed in [Prerequisites](#prerequisites).
- `openai` auth errors: confirm `OPENAI_API_KEY` is exported in your shell.
- Waveshare runtime issues: verify SPI/device setup and install vendor dependencies on the Pi.
- `saferm` appears to do nothing: check that `/mnt/disk/BIN/ROOT` exists and has write permissions.
- `repo2text` generates no files: ensure `source_directory` points to an existing folder with `.py` files.
- `chatgpt-traffic` domain anomalies: review and clean the `domains` list in script before production use.

## Roadmap

- Keep this repository as a stable legacy archive with clear pointers to active projects.
- Improve dependency manifests for each runnable submodule.
- Add consistent i18n layout under `/i18n` in future revisions.
- Expand practical examples and reproducible setup guides for hardware and non-hardware flows.

## Contributing

Contributions are welcome.

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

You can also contribute by:

- Suggesting improvements to strategic laziness workflows.
- Reporting issues in scripts or documentation.
- Improving setup reproducibility for hardware/software paths.

## License

This repository is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE).

## Acknowledgments

Special thanks to contributors, the OpenAI team, and the Raspberry Pi / maker communities that support experimentation around low-friction learning systems.

## Connect

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
