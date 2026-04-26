[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Note: このリポジトリは移行されています。現在の開発は https://github.com/lachlanchen/the-art-of-lazying で継続されています。

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

AIエージェント、語学学習、Vlogを軸に、実践的なコツや実生活での活用例をまとめ、よりシンプルで生産的な暮らしを実現するための「戦略的な怠け」を提案するリポジトリです。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Table of Contents

- [概要](#overview)
- [プロジェクト](#projects)
- [自動化ツール](#automation-tools)
- [フォルダ構成](#folder-structure)
- [紹介](#introduction)
- [怠けの理論](#the-theory-of-lazying)
- [実践的なヒント・コツ](#practical-tips-and-tricks)
- [ユースケース](#use-cases)
- [AIエージェントと自動化](#ai-agents-and-automation)
- [語学学習とVlog](#language-learning-and-vlogs)
- [コミュニティ投稿](#community-contributions)
- [前提条件](#prerequisites)
- [インストール](#installation)
- [使用方法](#usage)
- [設定](#configuration)
- [例](#examples)
- [開発ノート](#development-notes)
- [トラブルシューティング](#troubleshooting)
- [ロードマップ](#roadmap)
- [コントリビューション](#contributing)
- [支援](#❤️-support)
- [ライセンス](#license)
- [謝辞](#acknowledgments)
- [接続情報](#connect)

## Quick Links

| 必要 | まず見る場所 |
|---|---|
| コンテンツの全体像を把握する | [Overview](#overview) |
| 依存関係をインストールする | [Prerequisites](#prerequisites) |
| 例を実行する | [Usage](#usage) |
| よくある問題を解決する | [Troubleshooting](#troubleshooting) |
| 参加・協力する | [Contributing](#contributing) |

## Overview

`the-art-of-lazying-legacy` は、戦略的な「怠け」を軸にしたキュレーション型アンブレラリポジトリです。

- 仕事や生活における「lazying（戦略的怠け）」の考え方を実践するための概念情報。
- `code/EinkWordsGPT` を含む実用的なコード資産（e-ink + GPTによる語学学習）。
- より安全な運用を支えるユーティリティスクリプト（`scripts/lazy-care/SafeShell`）。
- Vlog向けツールや自動化スニペット（`vlogs/`）。
- デモ素材と例（`demos/`, `examples/`, `figs/`）。

| Snapshot | Value |
|---|---|
| リポジトリの役割 | レガシーアーカイブ + アイデアマップ |
| 開発先 | https://github.com/lachlanchen/the-art-of-lazying |
| 多言語README | `README.md`, `README_CN.md`, `README_EN.md` |
| i18nディレクトリ | `i18n/`（存在） |
| 語学学習 | 間隔反復 + GPTワークフロー |
| 自動化の焦点 | スクリプト、字幕、公開、ハードウェア連携 |

このリポジトリは、レガシーアーカイブとして参照価値があり、継続的な開発は上記の移行先リポジトリで進められています。

---

## Projects

### 🤖 AI-Powered Creative Tools

| Project | Description | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT活用の単語学習を行うE-ink表示デバイス | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 単語の語源解析をグラフで提示する | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 少ない労力で効率的に語学学習するためのツール | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP埋め込みとGPTデコーダを用いた動画・画像キャプション生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Katna/OpenCVでキーフレーム抽出し、ViT+GPT-2で字幕生成するツール | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 細粒度言語判定付きの多言語文字起こしパイプライン | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 世界中の創作をつなぐ言語障壁の解消 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 動画向けメタデータの自動生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 字幕生成、ハイライト、メタデータ生成を含むAI搭載の自動動画編集ツール | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | コンテンツ公開フローの効率化 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 複数プラットフォーム向けに動画を監視・処理・公開する自動化システム | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AIアシスタントを効果的に活用する高度なテクニック | |

## Automation Tools

このリポジトリには、ローカルで直接実行可能な自動化ユーティリティが含まれます。

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 継続的なe-ink単語カード表示ループ（デフォルトは300秒ごとに更新） |
| `code/EinkWordsGPT/words_update.py` | OpenAIに基づく一括/個別の単語詳細更新 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3インチ電子ペーパのハードウェアテスト |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`、`unrm`、`removeitanyway` の各シェル関数 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | ドメイン名からIPを解決し重複排除する処理 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | `.py` ファイルをサブディレクトリ単位で `.txt` に統合 |

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

> Note: 上記の概念マップは過去の README 版から意図的に保持されています。`Current Repository Structure` ブロックは、このレガシーリポジトリの実体構成を示しています。

## Introduction

The Art of Lazying は、エネルギー配分を最適化し、本当に重要なことに集中するための方法として戦略的な怠けを提示します。本リポジトリは、意図的に怠けることで生産性、創造性、ウェルビーイングがいかに高まるかを探ります。

## The Theory of Lazying

戦略的怠けの原則を包括的に紹介し、優先順位付け・委任・自動化を通して生産性とウェルビーイングを最大化することに焦点を当てます。

核となる考え方は、パレートの80/20の法則を日常生活に適用し、結果の80%を生む20%の活動を見極めることです。

## Practical Tips and Tricks

仕事、対人関係、セルフケアに怠けの考え方を適用するための実践的アドバイスです。

- 反復作業の自動化
- ポモドーロ・テクニックの活用
- 意思決定疲れを減らす仕組みを作る
- AIツールを補助として使う

## Use Cases

怠けの原則がどのように問題を解決し効率を上げるかを示す実例です。

- 起業家が事業成長に集中するために委任と自動化を使う方法
- 研究者が調査ワークフローを合理化する方法
- コンテンツクリエイターが制作工程を最適化する方法

## AI Agents and Automation

作業をシンプル化する AI エージェントと自動化ツールの開発を扱っています。

- ChatGPTを個人アシスタントとして使う
- カスタム自動化ワークフローを構築する
- 受動的学習のためのe-ink表示を作る

## Language Learning and Vlogs

効率的な語学学習のためのリソースと手法、そして「lazing」の実践を追うVlogの集約です。

- 間隔反復を使った個別化された語学学習の作成
- 没入型学習手法の実装
- 受動学習を促進するプロジェクト構築

## Community Contributions

戦略的怠けに関するあなたの経験、コツ、アイデアを共有してください。

- 生産性ハックを交換するフォーラム
- 日常ルーティン向けのツールとテンプレート
- 協調して怠け効率を高める共同プロジェクト

## Prerequisites

このリポジトリには複数の独立したスクリプトが含まれるため、前提条件はモジュールごとに異なります。

共通ベースライン:

- Python 3.9+
- `pip`
- Git

ソースファイルから確認できる、プロジェクト固有の要件:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd`（e-paper ハードウェアフロー用）
- `sqlite3`（標準ライブラリ）

`EinkWordsGPT` をフル運用するためのハードウェア要件:

- Raspberry Pi（プロジェクト文書では Raspberry Pi 5）
- Waveshare 7色 7.3インチe-inkパネル

## Installation

ルートに統合された依存関係マニフェストがないため、実行したいモジュール単位で依存関係を手動でインストールしてください。

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

`EinkWordsGPT` と更新スクリプトは公式SDKの `OpenAI()` を利用し、認証情報が環境変数として設定されている前提です。

推奨設定:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Database Location

`code/EinkWordsGPT/words_gpt.py` と `words_update.py` は以下を使用します:

- `db_path = 'words_phonetics.db'`

`code/EinkWordsGPT` から実行するか、別ディレクトリから起動する場合はパスを更新してください。

### SafeShell Trash Root

`saferm`/`unrm`/`removeitanyway` は現在、固定ルートを使用します:

- `/mnt/disk/BIN/ROOT`

`saferm` を使う前に、このパスが存在し、書き込み可能であることを確認してください。

### Repo2Text Paths

`vlogs/repo2text/convert-repo-to-merged-text.py` には現在ハードコードされたパスがあります:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

これらの値は、ローカル環境に合わせて変更してください。

## Examples

### Example: E-ink learning card cycle

- スクリプトが単語詳細を選択（または取得）します。
- 画面は5分ごと（`time.sleep(300)`）に更新されます。

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

- これはレガシーリポジトリです。アクティブ開発は以下で行われています: https://github.com/lachlanchen/the-art-of-lazying
- トップレベルの内容はキュレーション中心で、外部リポジトリへのリンクが多数含まれます。
- `i18n/` は存在しますが、現在は空です。言語別 README はトップレベルにあります。
- ルートには `requirements.txt` あるいは `pyproject.toml` はありません。

保持される互換性メモ:

- サブフォルダ内の旧ドキュメントで `saferm.sh`、`unrm.sh`、`removeitanyway.sh` に言及されている場合がありますが、現在は `scripts/lazy-care/SafeShell/safeshell_functions.sh` に統合されています。

## Troubleshooting

- `ModuleNotFoundError`: [Prerequisites](#prerequisites) に記載された不足パッケージをインストールします。
- `openai` 認証エラー: `OPENAI_API_KEY` がシェルでエクスポートされているか確認します。
- Waveshare実行時の問題: Raspberry Pi 側のSPI/デバイス設定を確認し、ベンダー依存のパッケージをインストールしてください。
- `saferm` が何も動作しない: `/mnt/disk/BIN/ROOT` が存在し、書き込み権限があるか確認してください。
- `repo2text` がファイルを生成しない: `source_directory` が既存の `.py` ファイルを含むフォルダを指しているか確認してください。
- `chatgpt-traffic` のドメイン異常: 本番利用前にスクリプト内の `domains` リストを確認し、整理してください。

## Roadmap

- このリポジトリを、アクティブなプロジェクトへの導線を明確にする安定したレガシーアーカイブとして維持する。
- 実行可能な各サブモジュールの依存関係マニフェストを改善する。
- 将来の改訂で `/i18n` 配下の i18n レイアウトを統一する。
- ハードウェア系/非ハードウェア系の両方に対し、実践例と再現可能なセットアップガイドを拡充する。

## Contributing

コントリビューションは歓迎します。

1. このプロジェクトを Fork します。
2. フィーチャーブランチを作成します（`git checkout -b feature/AmazingFeature`）。
3. 変更をコミットします（`git commit -m 'Add some AmazingFeature'`）。
4. ブランチへ push します（`git push origin feature/AmazingFeature`）。
5. プルリクエストを作成します。

以下の形でも貢献できます:

- 戦略的怠けワークフローの改善提案
- スクリプトやドキュメントの問題報告
- ハードウェア/ソフトウェアのセットアップ再現性を高める改善

## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |

## License

このリポジトリは GNU General Public License v3.0 のもとで提供されています。詳細は [LICENSE](LICENSE) を参照してください。

## Acknowledgments

低摩擦な学習システム実験を支えてくれるコントリビューター、OpenAIチーム、Raspberry Pi / メイカーコミュニティに感謝します。

## Connect

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
