[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> 注意：本倉庫已遷移，持續更新請前往 https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

一個以「策略性偷懶」為核心的倉庫，目標是以更精簡的方式提升生活與工作的效率，內容涵蓋 AI 代理、語言學習與 Vlog，並提供可落地的技巧與真實應用案例。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目錄

- [總覽](#總覽)
- [專案](#專案)
- [自動化工具](#自動化工具)
- [資料夾結構](#資料夾結構)
- [簡介](#簡介)
- [懶惰理論](#懶惰理論)
- [實用技巧與訣竅](#實用技巧與訣竅)
- [使用案例](#使用案例)
- [AI 代理與自動化](#ai-代理與自動化)
- [語言學習與 Vlog](#語言學習與-vlog)
- [社群貢獻](#社群貢獻)
- [前置需求](#前置需求)
- [安裝](#安裝)
- [使用方式](#使用方式)
- [設定](#設定)
- [範例](#範例)
- [開發筆記](#開發筆記)
- [疑難排解](#疑難排解)
- [路線圖](#路線圖)
- [參與貢獻](#參與貢獻)
- [授權](#授權)
- [致謝](#致謝)
- [聯繫](#聯繫)

## 快速入口

| 場景 | 從這裡開始 |
|---|---|
| 瀏覽主內容地圖 | [總覽](#總覽) |
| 安裝前置套件 | [前置需求](#前置需求) |
| 運行範例 | [使用方式](#使用方式) |
| 處理常見問題 | [疑難排解](#疑難排解) |
| 參與專案 | [參與貢獻](#參與貢獻) |

## 總覽

`the-art-of-lazying-legacy` 是一個圍繞「策略性偷懶」建立的精選匯總型倉庫：

- 探討如何將「lazying」理念套用到工作與生活中的思考內容。
- 可直接使用或參考的程式成果，包含電子紙 + GPT 語言學習專案（`code/EinkWordsGPT`）。
- 提升安全性的工作流腳本（`scripts/lazy-care/SafeShell`）。
- 與 Vlog 相關的工具與自動化片段（`vlogs/`）。
- 示範素材與範例（`demos/`、`examples/`、`figs/`）。

| 摘要 | 說明 |
|---|---|
| 倉庫定位 | 遺留歸檔與思路地圖 |
| 活躍開發倉庫 | https://github.com/lachlanchen/the-art-of-lazying |
| 多語言 README 檔案 | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n 目錄 | `i18n/`（目前存在） |
| 語言學習 | 間隔重複 + GPT 工作流 |
| 自動化重點 | 腳本、字幕、發佈與硬體工作流 |

這個倉庫作為歷史歸檔與思路地圖繼續保留，同時活躍開發已移轉至上方連結的新倉庫。

---

## 專案

### 🤖 AI 驅動創意工具

| 專案 | 說明 | 示範 |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 使用 GPT 的電子紙詞彙學習方案 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 詞源分析並以圖譜方式展示。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 以最少投入實踐高效語言學習的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 結合 OpenAI CLIP embeddings 與 GPT decoder 的影音字幕工具 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 影片字幕工具：使用 Katna/OpenCV 擷取關鍵影格，並用 ViT+GPT-2 模型產生字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 具備細粒度語言識別的多語轉錄流程 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破語言壁壘，促進全球創作交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 自動生成影片中繼資料 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 驅動的自動化影音編輯工具，整合轉錄、自動字幕、重點標註與元資料生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 簡化內容發佈工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 自動監控、處理並將影音內容發佈到多平台的系統 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 使用 AI 助手的進階技巧 | |

## 自動化工具

本倉庫包含可直接在本機執行的自動化實用工具：

| 路徑 | 用途 |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 持續執行的電子紙單字卡渲染迴圈（預設每 300 秒重新整理） |
| `code/EinkWordsGPT/words_update.py` | 基於 OpenAI 後端邏輯的批次與目標式單字詳情刷新 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3 吋電子紙硬體測試 |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`、`unrm` 與 `removeitanyway` shell 函式 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 網域到 IP 解析與結果去重輸出 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | 依子目錄合併 `.py` 檔為 `.txt` |

## 資料夾結構

### 當前倉庫結構（精準）

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

### 原始概念結構（保留）

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

> 註：以上概念結構有意保留自早期 README；上方「當前倉庫結構」程式碼區塊才是本遺留倉庫的實際目錄樹。

## 簡介

The Art of Lazying 將「策略性偷懶」視為一種分配能量、專注於真正重要事務的方法。這個倉庫探討如何透過有意識地「偷懶」，達成更高的生產力、創造力與福祉。

## 懶惰理論

本節全面介紹策略性偷懶的核心原則，著重於透過優先排序、委外與自動化，最大化輸出與福祉。

核心原則在於將帕累托 80/20 法則套用到日常生活：找出 20% 的活動，卻能產生 80% 的預期成果。

## 實用技巧與訣竅

以下提供可直接採用的建議，將 lazying 理念應用到工作、人際關係與自我照護：

- 自動化重複性任務
- 用番茄鐘法做時間管理
- 建立減少決策疲勞的系統
- 善用 AI 工具作為協作助理

## 使用案例

以下是真實案例，展示 lazying 原則如何解決問題並提升效率：

- 創業者如何透過委外與自動化，更專注於業務成長
- 學術研究者如何精簡研究流程
- 內容創作者如何最佳化製作流程

## AI 代理與自動化

探索 AI 代理與自動化工具的開發，藉此簡化各種任務：

- 將 ChatGPT 當作個人助理使用
- 建立客製化的自動化流程
- 製作用於被動學習的電子紙顯示介面

## 語言學習與 Vlog

提供高效語言學習資源與技巧，並紀錄 lazying 實踐旅程的 Vlog：

- 用間隔重複法建立個人化學習流程
- 落實沉浸式學習技巧
- 建立鼓勵被動學習的專案

## 社群貢獻

歡迎分享你在策略性偷懶上的經驗、技巧與想法：

- 交換效率黑客的討論區
- 提供日常流程工具與模板
- 面向「以偷懶求效率」理念的協作專案

## 前置需求

本倉庫含有多個彼此獨立的腳本，前置需求會依模組不同而異。

一般基準：

- Python 3.9+
- `pip`
- Git

專案原始檔中可見的套件名稱：

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd`（用於電子紙硬體流程）
- `sqlite3`（標準函式庫）

啟用完整 `EinkWordsGPT` 運行所需硬體：

- Raspberry Pi（專案文件提到 Raspberry Pi 5）
- Waveshare 7.3 吋七彩電子紙螢幕

## 安裝

本倉庫未提供統一的依賴清單，請依你要執行的模組手動安裝相應套件。

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

可選／硬體相依套件：

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell 初始化：

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## 使用方式

### 1) 運行 EinkWordsGPT 顯示迴圈

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) 重新檢查並更新單字詳情

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) 測試 Waveshare 7.3 吋螢幕

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) 解析 ChatGPT 相關網域並輸出 IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) 依目錄合併 Python 檔並輸出 AI 友善文字包

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) 使用更安全的檔案刪除流程

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## 設定

### OpenAI 憑證

`EinkWordsGPT` 與更新腳本使用官方 SDK 的 `OpenAI()`，並要求在環境變數中設定憑證。

建議做法（推薦）：

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 資料庫位置

`code/EinkWordsGPT/words_gpt.py` 與 `words_update.py` 使用：

- `db_path = 'words_phonetics.db'`

請從 `code/EinkWordsGPT` 目錄執行這些腳本，或在其他目錄執行時同步調整路徑。

### SafeShell 回收桶根目錄

`saferm`、`unrm`、`removeitanyway` 目前使用固定的基礎路徑：

- `/mnt/disk/BIN/ROOT`

請確保在依賴 `saferm` 前先建立此路徑並設定可寫權限。

### Repo2Text 路徑

`vlogs/repo2text/convert-repo-to-merged-text.py` 目前使用硬編碼路徑：

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

請依你的本機專案調整這些常數。

## 範例

### 範例：電子紙學習卡循環

- 腳本會選取（或抓取）單字詳情。
- 詞卡會渲染音標、音節切分與日語同義提示。
- 畫面每 5 分鐘更新一次（`time.sleep(300)`）。

### 範例：安全刪除流程

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### 範例：網域/IP 輸出檔

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## 開發筆記

- 這是 legacy 倉庫；活躍開發可參考：https://github.com/lachlanchen/the-art-of-lazying
- 頂層內容主要為策展型，並連到多個外部倉庫。
- `i18n/` 已存在，但目前為空，語言 README 目前仍放在頂層。
- 倉庫根目錄沒有 `requirements.txt` 或 `pyproject.toml`。

相容性保留說明：

- 子目錄中的舊文件可能提到腳本（`saferm.sh`、`unrm.sh`、`removeitanyway.sh`），這些現在已整合到 `scripts/lazy-care/SafeShell/safeshell_functions.sh`。

## 疑難排解

- `ModuleNotFoundError`：安裝[前置需求](#前置需求)中缺少的 Python 套件。
- `openai` 認證錯誤：確認當前 shell 已匯出 `OPENAI_API_KEY`。
- Waveshare 執行問題：在樹莓派上確認 SPI/裝置設定，並安裝廠商相依套件。
- `saferm` 看起來沒反應：檢查 `/mnt/disk/BIN/ROOT` 是否存在且有寫入權限。
- `repo2text` 沒有產生檔案：確認 `source_directory` 指向存在且含有 `.py` 檔案的目錄。
- `chatgpt-traffic` 出現網域異常：上線前先檢查並清理腳本中的 `domains` 清單。

## 路線圖

- 維持本倉庫作為穩定歷史歸檔，並清楚導向活躍專案。
- 為每個可執行子模組補齊完整依賴清單。
- 在未來版本中，為 `/i18n` 建立一致的多語言版面。
- 擴充更多實務範例，補齊硬體與非硬體流程的可重現設定教學。

## 參與貢獻

歡迎貢獻。

1. Fork 本專案。
2. 建立你的功能分支（`git checkout -b feature/AmazingFeature`）。
3. 提交修改（`git commit -m 'Add some AmazingFeature'`）。
4. 推送到你的分支（`git push origin feature/AmazingFeature`）。
5. 發起 Pull Request。

你也可以從以下方式參與：

- 提出策略性偷懶工作流的改進建議。
- 回報腳本或文件問題。
- 提升軟硬體流程的環境可重現性。

## 授權

本倉庫依 GNU General Public License v3.0 授權，詳見 [LICENSE](LICENSE)。

## 致謝

特別感謝貢獻者、OpenAI 團隊，以及支援低摩擦學習系統實驗的 Raspberry Pi 與創客社群。

## 聯繫

- 網站：[lazying.art](https://lazying.art)
- GitHub：[lachlanchen](https://github.com/lachlanchen)
- Email：lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
