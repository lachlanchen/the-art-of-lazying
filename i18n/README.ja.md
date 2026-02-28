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

このリポジトリは、よりシンプルでレバレッジの高い生活を目指す「戦略的な怠け方」に焦点を当て、AIエージェント、言語学習、実用的な自動化、そしてVlog主導の実践ワークフローを扱います。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目次

- [概要](#概要)
- [プロジェクト](#プロジェクト)
- [リポジトリ構成](#リポジトリ構成)
- [特徴](#特徴)
- [前提条件](#前提条件)
- [インストール](#インストール)
- [使い方](#使い方)
- [設定](#設定)
- [例](#例)
- [開発メモ](#開発メモ)
- [トラブルシューティング](#トラブルシューティング)
- [ロードマップ](#ロードマップ)
- [はじめに](#はじめに)
- [Lazying の理論](#lazying-の理論)
- [実践的なヒントとコツ](#実践的なヒントとコツ)
- [ユースケース](#ユースケース)
- [AI エージェントと自動化](#ai-エージェントと自動化)
- [言語学習と Vlog](#言語学習と-vlog)
- [コミュニティ貢献](#コミュニティ貢献)
- [連絡先](#連絡先)
- [サポート / 寄付](#サポート--寄付)
- [コントリビューション](#コントリビューション)
- [ライセンス](#ライセンス)

## 概要

`the-art-of-lazying` は、実践的な「戦略的な怠け方」のハブとなるリポジトリです。反復作業の自動化、言語学習ワークフローの改善、そしてスクリプトやVlogを通じた現場実験の記録を行います。

| ひと目でわかるポイント | 詳細 |
|---|---|
| 🎯 中核テーマ | 生産性・学習・創作アウトプットのための戦略的怠惰 |
| 🧩 リポジトリの性質 | ローカルツール + 厳選した外部プロジェクトのハイブリッド |
| 🛠️ ローカルの見どころ | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 ドキュメント | ルート README + 多言語 `i18n/` バリアント |

このリポジトリには次の両方が含まれます。
- 関連する外部プロジェクトへの厳選リンク。
- ローカルツールとコード（特に以下）。
  - `code/EinkWordsGPT`（Raspberry Pi + Waveshare e-ink + OpenAI による単語学習ディスプレイ）。
  - `scripts/lazy-care/SafeShell`（安全な削除/復元のシェル関数）。
  - `vlogs/chatgpt-traffic` と `vlogs/repo2text`（小規模な Python ユーティリティ）。

## プロジェクト

### 🚀 AI 搭載クリエイティブツール

| Project | Description | Demo |
|---------|-------------|------|
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

### ⚙️ 自動化ツール（このリポジトリ内のローカル）

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: より安全なシェル削除（`saferm`）、復元（`unrm`）、明示的な完全削除（`removeitanyway`）。
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: ドメインからIPへの解決と重複除去済み出力の生成。
- `vlogs/repo2text/convert-repo-to-merged-text.py`: ディレクトリ単位で Python ファイルをテキスト束に統合し、AI支援分析をしやすくします。

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

注: 以前の README バリアントにあった古い汎用フォルダ図（例: `book/`, `code/ai-agents/`）は、現在のリポジトリツリーと完全には一致しません。上記の構成は現在のファイル構成を反映しています。

## 特徴

- 生産性・学習・コンテンツワークフローのための戦略的怠惰フレームワーク。
- 文字起こし、キャプション生成、翻訳、公開自動化までを網羅する厳選AIプロジェクト群。
- GPT支援の単語選定による、ハードウェア統合型の言語学習（`EinkWordsGPT`）。
- 可逆削除ワークフローを実現する実用的なシェル安全ツール。
- DNS/ドメイントラフィック確認とリポジトリ→テキスト変換のスクリプト中心ユーティリティ。
- `i18n/` による多言語ドキュメント対応。

## 前提条件

General:
- Git
- Python 3.9+ recommended

For `code/EinkWordsGPT`:
- Raspberry Pi (project docs mention Raspberry Pi 5)
- Waveshare 7.3-inch 7-color e-ink display with Python driver support (`waveshare_epd`)
- Python packages used in code: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (Python stdlib `sqlite3` is used)
- OpenAI API key configured in environment (the code initializes `OpenAI()` directly)

For `vlogs/chatgpt-traffic`:
- `dnspython`

For `scripts/lazy-care/SafeShell`:
- Bash or Zsh shell with access to `realpath`, `mv`, and `/bin/rm`

## インストール

リポジトリをクローンします。

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

よく使う Python 依存関係（リポジトリ全体のベースライン）をインストールします。

```bash
pip install openai Pillow pytz pykakasi dnspython
```

注: `code/EinkWordsGPT/README.md` では `requirements.txt` に言及がありますが、このリポジトリには現在 `requirements.txt` は存在しません。上記のように手動でパッケージをインストールしてください。

## 使い方

### 1) EinkWordsGPT（ローカルハードウェアフロー）

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

任意のデータベースメンテナンススクリプト:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell（安全な削除ワークフロー）

シェル関数を読み込みます。

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

コマンドを使用します。

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

### 4) Repo-to-text merger

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

注: `convert-repo-to-merged-text.py` は現在ハードコードされたパス（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）を使用しています。別のリポジトリに対して実行する前に、これらの定数を編集してください。

## 設定

### OpenAI 設定（`code/EinkWordsGPT`）

コード内では次の形でクライアントを作成しています。

```python
client = OpenAI()
```

そのため、スクリプト実行前に標準的な OpenAI 環境変数の方法で API 認証情報を設定してください。

### データベースパス（`code/EinkWordsGPT`）

コード内のデフォルト:

```python
db_path = 'words_phonetics.db'
```

`words_phonetics.db` が `code/EinkWordsGPT/` に存在することを確認してください（現在このリポジトリに同梱されています）。

### SafeShell のゴミ箱保存先

`saferm`/`unrm`/`removeitanyway` は固定のベースパスを使用します。

```bash
/mnt/disk/BIN/ROOT
```

環境が異なる場合は `scripts/lazy-care/SafeShell/safeshell_functions.sh` 内のこのパスを調整してください。

## 例

- `demos/` にある E-ink 単語カードのデモ:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT の構築ノート/資料:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 開発メモ

- このリポジトリは、ローカルコードと外部プロジェクトリンクを併せ持つマルチプロジェクト紹介型リポジトリです。
- 現在、ルートレベルのパッケージマネージャー/ビルドマニフェストはありません（`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` はルートに存在しません）。
- いくつかのサブREADMEはテンプレート的で、現在のファイル配置に対して一部古い可能性があります。本READMEのコマンドは、現在存在するパス/スクリプトに合わせています。
- `README_EN.md` と `README_CN.md` は旧来バリアントとして存在し、現在有効な多言語構成は `README.md` + `i18n/*` です。

## トラブルシューティング

- Python パッケージの `ModuleNotFoundError`:
  - `pip install openai Pillow pytz pykakasi dnspython` で依存関係を再インストールしてください。

- `EinkWordsGPT` で `ImportError: waveshare_epd`:
  - Raspberry Pi 環境に Waveshare e-paper の Python ドライバ/ライブラリをインストールしてください。

- OpenAI 認証エラー:
  - `words_gpt.py` または `words_update.py` 実行前に、OpenAI API キーが環境変数に設定されていることを確認してください。

- セットアップ後に `saferm`/`unrm` が見つからない:
  - 正しいシェル rc ファイルを `source` し、`safeshell_functions.sh` の追記が成功しているか確認してください。

- `unrm` でファイルを復元できない:
  - `/mnt/disk/BIN/ROOT` 配下の SafeShell ミラーごみ箱レイアウトと復元パスが一致しているか確認してください。

- `repo2text` スクリプトで出力が作成されない:
  - `convert-repo-to-merged-text.py` の `source_directory` を既存フォルダに更新してください。

## ロードマップ

- すべての i18n ファイルでルート README と同等性を拡張（現状、多くの言語版は要約中心）。
- Waveshare e-ink ドライバ向けの環境別セットアップ文書を追加。
- ローカルツール向けに再現可能な依存関係マニフェストをルートへ追加。
- 重要ユーティリティ向けの検証/テストスクリプトを追加。
- 外部プロジェクトリンクをより豊富なローカルデモとともに整理統合。

## はじめに

The Art of Lazying は、エネルギーの使い方を最適化し、本当に重要なことに集中するための方法として「戦略的な怠け方」を提案します。このリポジトリでは、意図的な怠惰が生産性・創造性・ウェルビーイングを高める仕組みを探ります。

## Lazying の理論

優先順位付け、委任、自動化を通じて、生産性とウェルビーイングを最大化するための「戦略的怠惰」の原則を体系的に紹介します。

中核となる考え方は、パレートの 80/20 ルールを日常に適用し、望む成果の 80% を生む 20% の活動を見極めることです。

## 実践的なヒントとコツ

仕事・人間関係・セルフケアに怠惰の原則を適用するための実践的アドバイス集:
- 反復タスクの自動化
- 時間管理のためのポモドーロ・テクニック活用
- 意思決定疲れを減らす仕組みづくり
- 補助としての AI ツール活用

## ユースケース

怠け方の原則が課題解決と効率向上にどう効くかを示す実例:
- 起業家が委任と自動化を使って事業成長に集中する方法
- 研究者・学生が調査ワークフローを効率化する方法
- コンテンツ制作者が制作プロセスを最適化する方法

## AI エージェントと自動化

作業を簡素化する AI エージェントと自動化ツールの開発を紹介します:
- ChatGPT を個人アシスタントとして活用
- カスタム自動化ワークフローの構築
- 受動学習のための E-ink ディスプレイ作成

## 言語学習と Vlog

効率的な言語学習のためのリソースと手法、そして lazying の歩みを記録する Vlog:
- 間隔反復に基づく個別最適な言語学習の設計
- 没入型学習テクニックの実装
- 受動学習を促進するプロジェクトの構築

## コミュニティ貢献

戦略的な怠け方に関するあなたの経験、コツ、アイデアを共有してください:
- 生産性ハックを交換するフォーラム
- 日常ルーティン向けツールとテンプレート
- 怠惰効率を高める共同プロジェクト

## 連絡先

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## サポート / 寄付

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

`.github/FUNDING.yml` にある追加支援リンク:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## コントリビューション

コード、ドキュメント、例、翻訳など、あらゆる貢献を歓迎します。

1. リポジトリを Fork します。
2. ブランチを作成します（`git checkout -b feature/your-feature`）。
3. 変更を加え、明確なコミットメッセージを付けます。
4. 動機と影響を説明した Pull Request を作成します。

どこから始めるか迷う場合:
- ローカルツールのセットアップドキュメントを改善する。
- 既存ユーティリティ向けにテストや検証スクリプトを追加する。
- `i18n/README.*.md` のいずれか1言語版の整合性/品質を改善する。

## ライセンス

このリポジトリには、ルート（`LICENSE`）および複数のサブフォルダに GPLv3 ライセンステキストが含まれています。

注: 一部のサブプロジェクト README には MIT 表記があります。各サブモジュールの扱いが明確になるまでは、ルートリポジトリは GPLv3 準拠として扱い、コードを個別再配布する場合はサブプロジェクトごとのライセンスも確認してください。
