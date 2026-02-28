[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# 懶惰的藝術

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

這是一個以「戰略性懶惰」為核心的倉庫，透過更簡單且更有槓桿的方式，涵蓋 AI 代理、語言學習、實用自動化，以及以 vlog 驅動的真實工作流程。

| 聚焦 | 本 README 的內容 |
|---|---|
| 🤖 自動化 | 可在本地執行的核心工具、腳本與實務流程 |
| 🧠 學習 | 以語言為先的專案與範例，建立高效的學習習慣 |
| 📚 分享 | 多語系文件、專案連結與貢獻指南 |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目錄

- [概覽](#概覽)
- [專案](#專案)
- [倉庫結構](#倉庫結構)
- [功能](#功能)
- [先決條件](#先決條件)
- [安裝](#安裝)
- [使用方式](#使用方式)
- [設定](#設定)
- [範例](#範例)
- [開發說明](#開發說明)
- [故障排除](#故障排除)
- [路線圖](#路線圖)
- [引言](#引言)
- [懶惰理論](#懶惰理論)
- [實用技巧](#實用技巧)
- [應用情境](#應用情境)
- [AI 代理與自動化](#ai-代理與自動化)
- [語言學習與 Vlog](#語言學習與-vlog)
- [社群貢獻](#社群貢獻)
- [❤️ Support](#-support)
- [聯繫](#聯繫)
- [參與貢獻](#參與貢獻)
- [授權](#授權)

## 概覽

`the-art-of-lazying` 是一個專注於實務導向「戰略性懶惰」的核心倉庫：自動化重複性的工作、優化語言學習流程，並透過腳本與 vlog 記錄真實世界中的實驗。

| 一覽 | 細節 |
|---|---|
| 🎯 核心主題 | 提升生產力、學習與創作輸出的戰略性懶惰思維 |
| 🧩 倉庫風格 | 本地工具與精選外部專案的混合模型 |
| 🛠️ 本地重點 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 文件 | 根 README + 多語系 `i18n/` 版本 |

本倉庫包含兩類內容：
- 外部關聯專案的精選連結。
- 本地工具與程式碼，尤其是：
  - `code/EinkWordsGPT`（Raspberry Pi + Waveshare 墨水屏 + OpenAI 單字學習展示）。
  - `scripts/lazy-care/SafeShell`（安全刪除/復原的 shell 函式）。
  - `vlogs/chatgpt-traffic` 與 `vlogs/repo2text`（輕量 Python 工具）。

## 專案

### 🚀 AI 驅動的創作工具

| 專案 | 描述 | 示範 |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 驅動的電子紙單字學習顯示器 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 詞源分析與圖譜化呈現 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 用最小投入實現高效語言學習的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 結合 OpenAI CLIP embedding 與 GPT 解碼器的影片與影像字幕工具 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 影片字幕工具：使用 Katna/OpenCV 擷取關鍵影格，並以 ViT+GPT-2 生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 支援精細語言偵測的多語轉寫流程 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破語言隔閡，促進跨語言創意交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 影片中繼資料自動生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 自動化影片編輯工具，含逐字稿、字幕自動生成、重點標註與中繼資料製作 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 簡化內容發佈工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 自動監控、處理並將影片內容發布到多個平台的系統 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 更有效率使用 AI 助理的進階技巧 | |

### ⚙️ 自動化工具（本倉庫本地）

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`：較安全的 shell 刪除（`saferm`）、還原（`unrm`）與明確的永久刪除（`removeitanyway`）。
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`：網域到 IP 的解析器與去重輸出產生器。
- `vlogs/repo2text/convert-repo-to-merged-text.py`：依目錄將 Python 檔案合併為文字包，便於 AI 輔助分析。

## 倉庫結構

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

說明：先前 README 版本中的通用目錄圖曾使用抽象路徑（例如 `book/`, `code/ai-agents/`），與目前的倉庫樹不完全一致。上方結構反映目前實際檔案佈局。

## 功能

- 以戰略性懶惰作為生產力、學習與內容工作流的核心框架。
- 精選 AI 專案組合，橫跨轉錄、字幕、翻譯與發佈自動化。
- 硬體整合式語言學習：`EinkWordsGPT` 搭配 GPT 輔助選詞與顯示。
- 實用 shell 安全工具，支援可逆刪除流程。
- 腳本優先的實用工具，包含 DNS/網域流量檢查與 repo-to-text 轉換。
- 透過 `i18n/` 提供多語言文件支援。

## 先決條件

共通：
- Git
- 建議 Python 3.9+

對 `code/EinkWordsGPT`：
- Raspberry Pi（專案文件提及 Raspberry Pi 5）
- Waveshare 7.3 吋七色電子紙螢幕（需支援 `waveshare_epd` 的 Python 驅動）
- 程式碼中使用的 Python 套件：`openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite（使用 Python 標準函式庫 `sqlite3`）
- 在環境變數中設定 OpenAI API key（程式碼直接使用 `OpenAI()` 初始化）

對 `vlogs/chatgpt-traffic`：
- `dnspython`

對 `scripts/lazy-care/SafeShell`：
- 可使用 `realpath`, `mv`, `/bin/rm` 的 Bash 或 Zsh 環境

## 安裝

克隆倉庫：

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

安裝常用 Python 依賴（倉庫全域基線）：

```bash
pip install openai Pillow pytz pykakasi dnspython
```

說明：`code/EinkWordsGPT/README.md` 提到 `requirements.txt`，但目前此倉庫根目錄並未提供 `requirements.txt`。請依上方指令手動安裝。

## 使用方式

### 1) EinkWordsGPT（本機硬體流程）

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

可選的資料庫維護腳本：

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell（安全刪除流程）

載入 shell 函式：

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

執行指令：

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) ChatGPT Traffic 解析器

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text 合併器

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

說明：`convert-repo-to-merged-text.py` 目前使用硬編碼路徑（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）。請在使用其他倉庫前先修改這些常數。

## 設定

### OpenAI 設定（`code/EinkWordsGPT`）

程式碼建立客戶端的方式如下：

```python
client = OpenAI()
```

因此請在執行腳本前，按照 OpenAI 標準方式，在環境變數中設定 API 憑證。

### 資料庫路徑（`code/EinkWordsGPT`）

程式碼預設值：

```python
db_path = 'words_phonetics.db'
```

確認 `code/EinkWordsGPT/` 中存在 `words_phonetics.db`（目前倉庫已包含此檔案）。

### SafeShell 回收站位置

`saferm`/`unrm`/`removeitanyway` 使用固定基底路徑：

```bash
/mnt/disk/BIN/ROOT
```

若你的環境不同，請在 `scripts/lazy-care/SafeShell/safeshell_functions.sh` 中調整這個路徑。

## 範例

- `demos/` 中的電子紙單字卡示範：
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT 的建置說明與素材：
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 開發說明

- 這是個多專案展示型倉庫，結合本地程式碼與外部專案連結。
- 根目錄目前沒有提供統一的套件管理或建構清單（`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` 目前不存在）。
- 部分子目錄 README 呈現模板化，可能與目前實際檔案結構略有不同；本 README 的指令以目前實際存在的路徑／腳本為準。
- `README_EN.md` 與 `README_CN.md` 為歷史版本；目前以 `README.md` + `i18n/*` 作為主要多語系結構。

## 故障排除

- `ModuleNotFoundError`（Python 套件缺少）：
  - 使用 `pip install openai Pillow pytz pykakasi dnspython` 重新安裝。

- `ImportError: waveshare_epd`（出現在 `EinkWordsGPT`）：
  - 在 Raspberry Pi 環境安裝 Waveshare 電子紙 Python 驅動程式/函式庫。

- OpenAI 驗證錯誤：
  - 在執行 `words_gpt.py` 或 `words_update.py` 前，先確認環境變數已設定 OpenAI API key。

- 設定後找不到 `saferm`/`unrm`：
  - 確認已正確載入 shell rc 檔，且成功將 `safeshell_functions.sh` 追加到設定檔。

- `unrm` 無法還原檔案：
  - 確認還原路徑與 SafeShell 在 `/mnt/disk/BIN/ROOT` 下的鏡像回收桶配置一致。

- `repo2text` 腳本沒有輸出：
  - 將 `convert-repo-to-merged-text.py` 中的 `source_directory` 調整為現有資料夾。

## 路線圖

- 擴展根 README 與所有 i18n 檔案之間的內容一致性（目前多數語言仍偏摘要）。
- 補充 Waveshare 電子紙驅動在不同環境下的設定文件。
- 為本地工具補齊根目錄可複現的依賴清單。
- 為關鍵工具加入驗證／測試腳本。
- 持續整合外部專案連結，補上更豐富的本地示範。

## 引言

`The Art of Lazying` 將「戰略性懶惰」視為優化精力配置、聚焦真正重要事務的一種方式。本倉庫探討了有意識的「偷懶」如何帶來更高的生產力、創造力與身心健康。

## 懶惰理論

這是一篇關於戰略性懶惰原則的完整介紹，核心在於透過優先排序、委派與自動化，在提升產能與幸福感的同時降低無效消耗。

核心原則是將帕雷托 80/20 法則應用於日常生活：找出那 20% 的行為，卻能產生 80% 想要的結果。

## 實用技巧

一組可直接執行的建議，協助你把懶惰原則應用到工作、人際關係與自我照顧：
- 自動化重複性任務
- 使用番茄鐘法則（Pomodoro）進行時間管理
- 建立能減少決策疲勞的系統
- 善用 AI 工具輔助工作

## 應用情境

透過真實案例展示懶惰原則如何解決問題並提升效率：
- 創業者如何透過委派與自動化專注於事業成長
- 學術研究者如何簡化研究流程
- 內容創作者如何優化其製作流程

## AI 代理與自動化

探索可簡化任務的 AI 代理與自動化工具：
- 將 ChatGPT 當作個人助理使用
- 建立自訂自動化工作流
- 建置被動學習用的電子紙顯示器

## 語言學習與 Vlog

提供高效語言學習資源與方法，並以 vlog 記錄懶惰實踐：
- 建立個人化、使用間隔重複法的語言學習系統
- 落實沉浸式學習技巧
- 打造鼓勵被動學習的專案

## 社群貢獻

歡迎分享你在戰略性懶惰上的經驗、技巧與想法：
- 交流生產力技巧的討論空間
- 日常流程工具與範本
- 围繞「高效懶惰」的協作專案

## 聯繫

- 網站：[lazying.art](https://lazying.art)
- GitHub：[lachlanchen](https://github.com/lachlanchen)
- 電子郵件：lach@lazying.art

## 參與貢獻

歡迎在程式碼、文件、範例與翻譯上作出貢獻。

1. Fork 這個倉庫。
2. 建立分支（`git checkout -b feature/your-feature`）。
3. 用清楚的提交訊息提交變更。
4. 開啟一個 Pull Request，說明動機與影響。

如果你不確定從哪裡開始：
- 改善某個本地工具的安裝文件。
- 為現有工具補上測試或驗證腳本。
- 提升某個 `i18n/README.*.md` 版本的一致性與品質。

## 授權

本倉庫在根目錄的 `LICENSE` 以及多個子目錄中包含 GPLv3 授權條款。

說明：部分子專案的 README 提及 MIT。直到每個子專案的授權狀態確認前，請以根倉庫 GPLv3 為準；若要單獨再分發某個子專案程式碼，請先逐一核對對應授權。


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
