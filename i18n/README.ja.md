[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# The Art of Lazying

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

よりシンプルで、効果の高い生活を目指す戦略的な「怠惰」を中心に、AIエージェント、語学学習、実用的な自動化、Vlog主導の実務ワークフローを扱うリポジトリです。

| フォーカス | このREADMEに含まれる内容 |
|---|---|
| 🤖 自動化 | ローカルで実行できる主要ツール、スクリプト、実務ワークフロー |
| 🧠 学習 | 効率的な学習習慣を支える語学中心のプロジェクトとサンプル |
| 📚 共有 | 多言語ドキュメント、プロジェクトリンク、コントリビューションガイド |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目次

- [概要](#概要)
- [プロジェクト](#プロジェクト)
- [リポジトリ構成](#リポジトリ構成)
- [機能](#機能)
- [前提条件](#前提条件)
- [インストール](#インストール)
- [使用方法](#使用方法)
- [設定](#設定)
- [例](#例)
- [開発ノート](#開発ノート)
- [トラブルシューティング](#トラブルシューティング)
- [ロードマップ](#ロードマップ)
- [はじめに](#はじめに)
- [Lazying の理論](#lazying-の理論)
- [実践的なヒントとコツ](#実践的なヒントとコツ)
- [ユースケース](#ユースケース)
- [AIエージェントと自動化](#aiエージェントと自動化)
- [語学学習とVlog](#語学学習とvlog)
- [コミュニティへの貢献](#コミュニティへの貢献)
- [❤️ Support](#-support)
- [連絡先](#連絡先)
- [コントリビューション](#コントリビューション)
- [ライセンス](#ライセンス)

## 概要

`the-art-of-lazying` は、反復作業を自動化して生産性を上げ、語学学習の流れを改善し、スクリプトとVlogで現場実験を記録する、実践的な戦略的怠惰のハブです。

| 一目で見る | 詳細 |
|---|---|
| 🎯 中核テーマ | 生産性、学習、コンテンツ制作のための戦略的怠惰 |
| 🧩 リポジトリの構成 | ローカルツール + 厳選した外部プロジェクトのハイブリッド |
| 🛠️ ローカルの注目点 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 ドキュメント | ルートREADME + 多言語の `i18n/` バリアント |

このリポジトリには次の両方が含まれます。
- 関連する外部プロジェクトへの厳選リンク。
- ローカルのツールやコード、特に:
  - `code/EinkWordsGPT`（Raspberry Pi + Waveshare e-ink + OpenAIによる語彙学習表示）
  - `scripts/lazy-care/SafeShell`（安全な削除・復元のシェル関数）
  - `vlogs/chatgpt-traffic` と `vlogs/repo2text`（小規模なPythonユーティリティ）

## プロジェクト

### 🚀 AIを活用したクリエイティブツール

| プロジェクト | 説明 | デモ |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT対応のe-inkディスプレイによる語彙学習 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 単語の語源分析とグラフ表示。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 最小の手間で効率的に学べる語学学習ツール | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP埋め込み＋GPTデコーダによる動画・画像キャプション生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 動画キャプション生成ツール。Katna/OpenCVでキーフレーム抽出し、ViT+GPT-2モデルで字幕を生成 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 言語自動判定付きの多言語文字起こしパイプライン | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | グローバルな創作交流の言語壁を低減 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 動画向けの自動メタデータ生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 文字起こし・自動字幕・ハイライト・メタデータ生成を統合したAI搭載動画編集ツール | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | コンテンツ公開ワークフローを効率化 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 複数プラットフォームへ動画を監視・処理・公開する自動システム | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AIアシスタントを効果的に活用する高度な技法 | |

### ⚙️ 本リポジトリ内の自動化ツール

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: 安全なシェル削除（`saferm`）、復元（`unrm`）、明示的な完全削除（`removeitanyway`）
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: ドメイン→IP解決と重複排除された出力を作成
- `vlogs/repo2text/convert-repo-to-merged-text.py`: Pythonファイルをディレクトリ単位でテキスト束に統合し、AI支援分析をしやすくする

## リポジトリ構成

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

注: 過去のREADME系の汎用ツリーダイアグラムでは `book/`, `code/ai-agents/` のような抽象パスが使われていましたが、現時点で実際のリポジトリ構成と完全には一致しません。上記は現在のファイル構成です。

## 機能

- 生産性、学習、コンテンツワークフローを高めるための戦略的怠惰フレームワーク。
- 文字起こし、字幕生成、翻訳、公開自動化までを網羅する厳選AIプロジェクト群。
- GPT支援の語彙選定によるハードウェア統合型語学学習（`EinkWordsGPT`）。
- 可逆的に削除ワークフローを行える実用的なシェル安全ツール。
- DNS/ドメイントラフィックチェックとリポジトリ→テキスト変換を行うスクリプト中心のユーティリティ。
- `i18n/` による多言語ドキュメント対応。

## 前提条件

全般:
- Git
- Python 3.9+ 推奨

`code/EinkWordsGPT` 向け:
- Raspberry Pi（プロジェクト仕様では Raspberry Pi 5 を想定）
- Pythonドライバサポート付き Waveshare 7.3インチ7色e-paperディスプレイ (`waveshare_epd`)
- コード内で使用されているPythonパッケージ: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite（Python標準ライブラリの `sqlite3` を使用）
- 環境に設定されたOpenAI APIキー（コード内で `OpenAI()` を直接初期化）

`vlogs/chatgpt-traffic` 向け:
- `dnspython`

`scripts/lazy-care/SafeShell` 向け:
- `realpath`, `mv`, `/bin/rm` にアクセスできる Bash / Zsh 環境

## インストール

リポジトリをクローンします:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

リポジトリ全体でよく使うPython依存関係をインストールします（ベースライン）:

```bash
pip install openai Pillow pytz pykakasi dnspython
```

注: `code/EinkWordsGPT/README.md` では `requirements.txt` を参照していますが、このリポジトリには現在 `requirements.txt` がありません。上記のように手動でパッケージをインストールしてください。

## 使用方法

### 1) EinkWordsGPT（ローカルハードウェアフロー）

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

オプションのデータベース保守スクリプト:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell（より安全な削除フロー）

シェル関数を読み込みます:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

次のコマンドを使用します:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) ChatGPT Traffic resolver

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text converter

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

注: `convert-repo-to-merged-text.py` は現在、ハードコードされたパス（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）を使用しています。別リポジトリで実行する場合はこれらの定数を編集してください。

## 設定

### OpenAI 設定（`code/EinkWordsGPT`）

コードでは次のようにクライアントを作成します:

```python
client = OpenAI()
```

そのため、スクリプト実行前にOpenAIの標準的な環境変数方式でAPI認証情報を設定してください。

### データベースパス（`code/EinkWordsGPT`）

コード内のデフォルト:

```python
db_path = 'words_phonetics.db'
```

`code/EinkWordsGPT/` に `words_phonetics.db` が存在することを確認してください（このリポジトリに含まれています）。

### SafeShell のゴミ箱保存先

`saferm` / `unrm` / `removeitanyway` は固定ベースパスを使用します:

```bash
/mnt/disk/BIN/ROOT
```

環境が異なる場合は、`scripts/lazy-care/SafeShell/safeshell_functions.sh` 内でこのパスを調整してください。

## 例

- `demos/` 内のE-ink単語カードデモ:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPTの構築ノート/素材:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 開発ノート

- このリポジトリは、ローカルコードと外部プロジェクトのリンクを併せ持つ、マルチプロジェクトのショーケースです。
- 現在、ルートレベルにはパッケージマネージャーやビルド用マニフェスト（`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile`）がありません。
- 一部のサブREADMEはテンプレート的で、現在のファイル配置に対して古くなっている可能性があります。本READMEのコマンドは現在存在するパスとスクリプトに合わせてあります。
- `README_EN.md` と `README_CN.md` は旧版です。現行の多言語構成は `README.md` と `i18n/*` です。

## トラブルシューティング

- Pythonパッケージの `ModuleNotFoundError`:
  - `pip install openai Pillow pytz pykakasi dnspython` で再インストールします。

- `EinkWordsGPT` の `ImportError: waveshare_epd`:
  - Raspberry Pi環境に Waveshare e-paper の Python ドライバ/ライブラリをインストールします。

- OpenAI 認証エラー:
  - `words_gpt.py` または `words_update.py` 実行前に環境変数へOpenAI APIキーが設定されているか確認してください。

- 設定後に `saferm` / `unrm` が見つからない:
  - シェルの rc ファイルを正しく `source` したか、`safeshell_functions.sh` の追記が成功したかを確認してください。

- `unrm` でファイルを復元できない:
  - `/mnt/disk/BIN/ROOT` 以下の SafeShell ミラーごみ箱レイアウトと復元パスが一致しているか確認してください。

- `repo2text` スクリプトが出力を作らない:
  - `convert-repo-to-merged-text.py` の `source_directory` を既存のフォルダに更新してください。

## ロードマップ

- すべての `i18n` ファイルでルートREADMEとの整合を拡大する（現在、多くの言語版は要約中心）
- Waveshare e-ink ドライバ向けに環境別のセットアップ文書を追加する
- ローカルツール向けに再現可能な依存関係マニフェストをルートに追加する
- 重要ユーティリティ向けの検証/テストスクリプトを追加する
- 外部プロジェクトリンクをより豊富なローカルデモとともに統合していく

## はじめに

The Art of Lazying は、エネルギー配分を最適化し、本当に重要なことに集中するための方法として「戦略的な怠惰」を提示します。このリポジトリでは、意図的な怠惰がどのように生産性、創造性、ウェルビーイングを高めるかを探ります。

## Lazying の理論

優先順位付け、委任、自動化を通して生産性とウェルビーイングを最大化するための、戦略的な怠惰の原則を体系的に説明します。

中核となる考え方は、パレートの80/20ルールを日常に適用し、望ましい成果の80%を生み出す20%の活動を見つけ出すことです。

## 実践的なヒントとコツ

仕事、人間関係、セルフケアに怠惰の原則を適用するための実践的アドバイスです。
- 反復タスクを自動化する
- ポモドーロ・テクニックを使って時間管理を行う
- 意思決定疲労を減らす仕組みを作る
- 補助としてAIツールを活用する

## ユースケース

怠惰の原則が問題解決と効率向上をどう支えるかを示す実例です。
- 起業家が委任と自動化で事業成長に集中する
- 研究者がリサーチワークフローを効率化する
- コンテンツクリエイターが制作プロセスを最適化する

## AIエージェントと自動化

タスクを簡素化するAIエージェントと自動化ツールの開発を扱います。
- ChatGPTを個人アシスタントとして使う
- カスタム自動化ワークフローを構築する
- 受動的学習向けのe-ink表示を作成する

## 語学学習とVlog

効率的な語学学習のためのリソースと手法、そして怠惰実践の軌跡を記録したvlog:
- 間隔反復を用いた個別最適化された学習設計
- 没入型学習テクニックの導入
- 受動学習を促進するプロジェクト構築

## コミュニティへの貢献

戦略的怠惰について、あなたの経験・コツ・アイデアを共有してください。
- 生産性ハックを交換するためのフォーラム
- 日常ルーチン用のツールとテンプレート
- 怠惰効率化を目的とした共同プロジェクト

## 連絡先

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

## コントリビューション

コード、ドキュメント、例、翻訳を含む幅広い貢献を歓迎します。

1. リポジトリを Fork します。
2. ブランチを作成します（`git checkout -b feature/your-feature`）。
3. 変更内容をわかりやすいコミットメッセージで記録します。
4. 方針と影響を説明した Pull Request を作成します。

始める場所が分からない場合:
- ローカルツールのセットアップガイドを改善する。
- 既存ユーティリティ向けにテストや検証スクリプトを追加する。
- 1つの `i18n/README.*.md` の整合性/品質を高める。

## ライセンス

このリポジトリには、ルート (`LICENSE`) と複数のサブフォルダに GPLv3 のライセンス本文が含まれています。

注: 一部のサブプロジェクトREADMEは MIT を記載している場合があります。各サブプロジェクトの方針が明確になるまで、ルートリポジトリは GPLv3 準拠とみなし、コードを個別に再配布する場合は各サブプロジェクトのライセンスを事前に確認してください。


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
