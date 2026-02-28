[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> 注: このリポジトリは移行済みです。現在の開発は https://github.com/lachlanchen/the-art-of-lazying で継続されています。
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

AIエージェント、言語学習、Vlog を含む実践的なヒントと実利用例を通じて、よりシンプルで生産的な生活のための「戦略的怠け」を提案するリポジトリです。

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

`the-art-of-lazying-legacy` は、戦略的怠けを中心に据えたキュレーション型のアンブレラリポジトリです。

- 仕事や生活に「lazying」哲学を適用するための概念的コンテンツ。
- 電子ペーパー + GPT による語学学習（`code/EinkWordsGPT`）を含む実用的なコード資産。
- より安全なワークフローのためのユーティリティスクリプト（`scripts/lazy-care/SafeShell`）。
- Vlog 向けツールや自動化スニペット（`vlogs/`）。
- デモ資産とサンプル（`demos/`, `examples/`, `figs/`）。

| Snapshot | Value |
|---|---|
| Repository role | Legacy archive + idea map |
| Active development | https://github.com/lachlanchen/the-art-of-lazying |
| Multilingual README files | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n directory | `i18n/` (present) |

このリポジトリはレガシーアーカイブ兼アイデアマップとして引き続き有用であり、アクティブ開発は上記の移行先リポジトリで行われています。

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

このリポジトリには、ローカルで直接実行できる自動化ユーティリティが含まれています。

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

> 注: 上記の概念マップは、過去の README 版から意図的に保持しています。"Current Repository Structure" ブロックは、このレガシーリポジトリの実際の構成を反映しています。

## Introduction

The Art of Lazying は、エネルギー配分を最適化し本当に重要なことへ集中するための方法として、戦略的怠けを提示します。本リポジトリでは、意図的な怠けがどのように生産性・創造性・ウェルビーイングの向上につながるかを探求します。

## The Theory of Lazying

戦略的怠けの原則を包括的に紹介し、優先順位付け・委任・自動化によって生産性とウェルビーイングを最大化する方法に焦点を当てます。

中核となる原則は、パレートの 80/20 ルールを日常生活に適用し、望む成果の 80% を生む 20% の活動を見極めることです。

## Practical Tips and Tricks

仕事・人間関係・セルフケアに怠けの原則を適用するための、実行可能なアドバイス集です。

- 反復作業の自動化
- 時間管理におけるポモドーロ・テクニックの活用
- 意思決定疲れを減らす仕組みづくり
- 支援のための AI ツール活用

## Use Cases

怠けの原則が問題解決と効率向上にどう役立つかを示す、実例集です。

- 起業家が委任と自動化により事業成長へ集中する方法
- 研究者・学生が調査ワークフローを効率化する方法
- コンテンツ制作者が制作プロセスを最適化する方法

## AI Agents and Automation

作業を簡素化する AI エージェントと自動化ツールの開発を扱います。

- 個人アシスタントとしての ChatGPT 活用
- カスタム自動化ワークフローの構築
- パッシブ学習のための電子ペーパーディスプレイ作成

## Language Learning and Vlogs

効率的な語学学習のリソースと手法、そして lazying の歩みを記録した Vlog をまとめています。

- 間隔反復を使った個別最適化された語学学習
- 没入型学習テクニックの実装
- パッシブ学習を促進するプロジェクト構築

## Community Contributions

戦略的怠けに関するあなた自身の経験・コツ・アイデアを共有してください。

- 生産性ハックを交換するフォーラム
- 日常ルーティン向けツールとテンプレート
- 怠け効率を高める共同プロジェクト

## Prerequisites

このリポジトリには複数の独立したスクリプトが含まれるため、前提要件はモジュールごとに異なります。

共通ベースライン:

- Python 3.9+
- `pip`
- Git

ソースファイルから確認できるプロジェクト固有のシグナル:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (for e-paper hardware flows)
- `sqlite3` (standard library)

`EinkWordsGPT` をフルランタイムで動かすためのハードウェア要件:

- Raspberry Pi (project docs mention Raspberry Pi 5)
- Waveshare 7-color 7.3-inch e-ink panel

## Installation

ルートの依存マニフェストが存在しないため、実行したいモジュールごとに依存関係を手動インストールしてください。

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

オプション/ハードウェア依存:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell セットアップ:

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

`EinkWordsGPT` と更新スクリプトは公式 SDK の `OpenAI()` を使用し、認証情報が環境に設定されていることを前提とします。

想定（推奨）:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Database Location

`code/EinkWordsGPT/words_gpt.py` と `words_update.py` は以下を使用します:

- `db_path = 'words_phonetics.db'`

別ディレクトリから起動する場合は、`code/EinkWordsGPT` で実行するかパスを更新してください。

### SafeShell Trash Root

`saferm`/`unrm`/`removeitanyway` は現在、固定のベースパスを使用します:

- `/mnt/disk/BIN/ROOT`

`saferm` を利用する前に、このパスが存在し書き込み可能であることを確認してください。

### Repo2Text Paths

`vlogs/repo2text/convert-repo-to-merged-text.py` には現在ハードコードされたパスがあります:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

ローカルプロジェクトに合わせてこれらの定数を編集してください。

## Examples

### Example: E-ink learning card cycle

- スクリプトが単語詳細を選択（または取得）します。
- 画面は 5 分ごとに更新されます（`time.sleep(300)`）。

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

- これはレガシーリポジトリです。アクティブ開発は https://github.com/lachlanchen/the-art-of-lazying で行われています。
- トップレベルの内容はキュレーション中心で、多くの外部リポジトリへのリンクを含みます。
- `i18n/` は存在しますが現時点では空で、言語別 README は現在トップレベルにあります。
- ルートに `requirements.txt` や `pyproject.toml` はありません。

保持される互換性メモ:

- サブフォルダ内の旧ドキュメントでは、`saferm.sh`、`unrm.sh`、`removeitanyway.sh` に言及している場合がありますが、現在は `scripts/lazy-care/SafeShell/safeshell_functions.sh` に統合されています。

## Troubleshooting

- `ModuleNotFoundError`: [Prerequisites](#prerequisites) に記載の不足パッケージをインストールしてください。
- `openai` 認証エラー: シェルで `OPENAI_API_KEY` が export されているか確認してください。
- Waveshare 実行時の問題: Pi 側の SPI/デバイス設定とベンダー依存関係のインストールを確認してください。
- `saferm` が何もしていないように見える: `/mnt/disk/BIN/ROOT` の存在と書き込み権限を確認してください。
- `repo2text` がファイルを生成しない: `source_directory` が `.py` ファイルを含む既存フォルダを指しているか確認してください。
- `chatgpt-traffic` のドメイン異常: 本番利用前にスクリプト内の `domains` リストを確認し、クリーンアップしてください。

## Roadmap

- このリポジトリを、アクティブプロジェクトへの明確な導線を持つ安定したレガシーアーカイブとして維持する。
- 実行可能な各サブモジュールの依存マニフェストを改善する。
- 今後の改訂で `/i18n` 配下の i18n レイアウトを統一する。
- ハードウェア/非ハードウェア両方の実行フロー向けに、実践例と再現可能なセットアップガイドを拡充する。

## Contributing

コントリビューションを歓迎します。

1. このプロジェクトを Fork します。
2. 機能ブランチを作成します（`git checkout -b feature/AmazingFeature`）。
3. 変更をコミットします（`git commit -m 'Add some AmazingFeature'`）。
4. ブランチへ push します（`git push origin feature/AmazingFeature`）。
5. Pull Request を作成します。

次の形でも貢献できます:

- 戦略的怠けワークフローの改善提案
- スクリプトやドキュメントの問題報告
- ハードウェア/ソフトウェア構成のセットアップ再現性向上

## License

このリポジトリは GNU General Public License v3.0 のもとで提供されています。詳細は [LICENSE](LICENSE) を参照してください。

## Acknowledgments

低摩擦な学習システムの実験を支える、コントリビューターの皆さん、OpenAI チーム、そして Raspberry Pi / メイカーコミュニティに感謝します。

## Connect

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
