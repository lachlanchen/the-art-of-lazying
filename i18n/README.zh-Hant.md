[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> 注意：本倉庫已遷移，持續開發請前往 https://github.com/lachlanchen/the-art-of-lazying
> 本倉庫已遷移：請前往 https://github.com/lachlanchen/the-art-of-lazying 關注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

一個推廣「策略性懶惰」以實現更簡化且高效生活的倉庫，涵蓋 AI 代理、語言學習與 vlog，並提供實用技巧與真實使用情境。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目錄

- [概覽](#概覽)
- [專案](#專案)
- [自動化工具](#自動化工具)
- [資料夾結構](#資料夾結構)
- [介紹](#介紹)
- [Lazying 理論](#lazying-理論)
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
- [開發備註](#開發備註)
- [疑難排解](#疑難排解)
- [路線圖](#路線圖)
- [貢獻](#貢獻)
- [授權](#授權)
- [致謝](#致謝)
- [聯絡](#聯絡)

## 概覽

`the-art-of-lazying-legacy` 是一個圍繞「策略性懶惰」策展而成的傘狀倉庫：

- 關於如何將「lazying」哲學應用於工作與生活的概念內容。
- 實作程式產物，包含 e-ink + GPT 語言學習（`code/EinkWordsGPT`）。
- 更安全工作流的工具腳本（`scripts/lazy-care/SafeShell`）。
- vlog 相關工具與自動化片段（`vlogs/`）。
- 展示素材與範例（`demos/`、`examples/`、`figs/`）。

| 快照 | 值 |
|---|---|
| 倉庫角色 | 舊版封存 + 概念地圖 |
| 持續開發 | https://github.com/lachlanchen/the-art-of-lazying |
| 多語 README 檔案 | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n 目錄 | `i18n/`（已存在） |

此倉庫仍適合作為舊版封存與概念地圖；實際持續開發已移至上方連結的遷移倉庫。

## 專案

### 🤖 AI 驅動創作工具

| 專案 | 說明 | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 使用 GPT 驅動單字學習的電子紙顯示專案 | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 單字詞源分析並以圖形呈現。 | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 以最小投入達成高效率語言學習的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 使用 OpenAI CLIP embeddings + GPT decoder 的影片與圖片字幕生成 | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 影片字幕工具：以 Katna/OpenCV 擷取關鍵影格，並用 ViT+GPT-2 模型生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 具細粒度語言偵測的多語轉錄流程 | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破語言隔閡，促進全球創作交流 | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 影片中繼資料自動生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 驅動的自動影片剪輯工具，包含轉錄、自動字幕、重點擷取與中繼資料生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 簡化內容發布工作流 | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 用於監控、處理並發布影片至多平台的自動化系統 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 更有效運用 AI 助手的進階技巧 | |

## 自動化工具

本倉庫包含可直接在本機執行的自動化工具：

| 路徑 | 用途 |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 持續執行的電子紙單字卡渲染循環（預設每 300 秒刷新）。 |
| `code/EinkWordsGPT/words_update.py` | 透過 OpenAI 邏輯執行批次或指定單字細節更新。 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3 吋電子紙硬體測試。 |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`、`unrm` 與 `removeitanyway` shell 函式。 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 網域到 IP 解析，並輸出去重後結果。 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | 依子目錄合併 `.py` 檔為 `.txt` 檔。 |

## 資料夾結構

### 目前倉庫結構（準確）

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

> 注意：上方概念地圖刻意保留自早期 README 版本；「目前倉庫結構」區塊才是此 legacy 倉庫的實際檔案樹。

## 介紹

The Art of Lazying 將策略性懶惰視為一種優化精力分配、聚焦真正重要事物的方法。本倉庫探索如何透過有意識的懶惰，帶來更高的生產力、創造力與幸福感。

## Lazying 理論

這是一份對策略性懶惰原則的完整介紹，重點在於如何透過優先排序、委派與自動化任務，最大化生產力與生活品質。

核心原則是將帕累托 80/20 法則用於日常生活：找出能產生 80% 成果的 20% 關鍵活動。

## 實用技巧與訣竅

以下是可直接實踐於工作、人際與自我照顧的懶惰原則：

- 自動化重複性任務
- 使用番茄鐘（Pomodoro Technique）進行時間管理
- 建立可降低決策疲勞的系統
- 善用 AI 工具提供輔助

## 使用案例

真實案例示範 lazying 原則如何解決問題並提升效率：

- 創業者如何透過委派與自動化專注在業務成長
- 學術研究者如何精簡研究工作流
- 內容創作者如何優化產製流程

## AI 代理與自動化

探索可簡化任務的 AI 代理與自動化工具開發：

- 將 ChatGPT 作為個人助理
- 建置客製化自動化工作流
- 建立電子紙顯示器以支援被動學習

## 語言學習與 Vlog

提供高效率語言學習資源與方法，並透過 vlog 記錄 lazying 實踐歷程：

- 以間隔重複打造個人化語言學習流程
- 實作沉浸式學習技巧
- 打造能鼓勵被動學習的專案

## 社群貢獻

歡迎分享你在策略性懶惰上的經驗、技巧與想法：

- 交流生產力技巧的社群空間
- 每日流程可用的工具與模板
- 共同協作、提升懶惰效率的專案

## 前置需求

本倉庫包含多個彼此獨立的腳本，因此前置需求依模組而異。

常見基線環境：

- Python 3.9+
- `pip`
- Git

從原始碼可觀察到的專案依賴訊號：

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd`（電子紙硬體流程需要）
- `sqlite3`（標準函式庫）

完整執行 `EinkWordsGPT` 的硬體需求：

- Raspberry Pi（專案文件提及 Raspberry Pi 5）
- Waveshare 7 色 7.3 吋電子紙面板

## 安裝

由於根目錄沒有統一依賴清單，請依你要執行的模組手動安裝。

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

可選／硬體依賴：

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell 設定：

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## 使用方式

### 1) 執行 EinkWordsGPT 顯示循環

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) 重新檢查／更新單字細節

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) 測試 Waveshare 7.3 吋面板

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) 解析 ChatGPT 相關網域並輸出 IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) 依目錄合併 Python 檔供 AI 友善文本打包

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

`EinkWordsGPT` 與更新腳本使用官方 SDK 的 `OpenAI()`，並預期你已在環境中設定憑證。

假設（建議）：

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 資料庫位置

`code/EinkWordsGPT/words_gpt.py` 與 `words_update.py` 使用：

- `db_path = 'words_phonetics.db'`

請從 `code/EinkWordsGPT` 執行，或在從其他位置啟動時自行更新路徑。

### SafeShell 垃圾桶根路徑

`saferm`/`unrm`/`removeitanyway` 目前使用固定基底路徑：

- `/mnt/disk/BIN/ROOT`

在依賴 `saferm` 前，請確認該路徑存在且可寫入。

### Repo2Text 路徑

`vlogs/repo2text/convert-repo-to-merged-text.py` 目前包含硬編碼路徑：

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

請將這些常數改為符合你本機專案的值。

## 範例

### 範例：電子紙學習卡循環

- 腳本會選擇（或抓取）單字細節。
- 單字卡會渲染音標、音節切分，以及日文同義提示。
- 螢幕每 5 分鐘刷新一次（`time.sleep(300)`）。

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

## 開發備註

- 這是 legacy 倉庫；持續開發位於：https://github.com/lachlanchen/the-art-of-lazying
- 頂層內容偏策展性質，並連結到許多外部倉庫。
- `i18n/` 已存在，但目前為空；語言版 README 目前位於頂層。
- 根目錄不存在 `requirements.txt` 或 `pyproject.toml`。

保留的相容性說明：

- 子資料夾中的早期文件可能仍提到腳本（`saferm.sh`、`unrm.sh`、`removeitanyway.sh`）；目前已整併至 `scripts/lazy-care/SafeShell/safeshell_functions.sh`。

## 疑難排解

- `ModuleNotFoundError`：安裝 [前置需求](#前置需求) 中列出的缺少套件。
- `openai` 驗證錯誤：確認 `OPENAI_API_KEY` 已在 shell 中匯出。
- Waveshare 執行問題：確認 Pi 上的 SPI/裝置設定，並安裝廠商依賴。
- `saferm` 看似無作用：檢查 `/mnt/disk/BIN/ROOT` 是否存在且有寫入權限。
- `repo2text` 未產生檔案：確認 `source_directory` 指向含 `.py` 檔的既有資料夾。
- `chatgpt-traffic` 網域異常：在正式使用前先檢查並清理腳本中的 `domains` 清單。

## 路線圖

- 將本倉庫維持為穩定的 legacy 封存，並提供清楚的活躍專案指引。
- 為各可執行子模組補齊依賴清單。
- 後續版本在 `/i18n` 下建立一致的 i18n 佈局。
- 擴充實作範例與可重現的硬體/非硬體安裝指南。

## 貢獻

歡迎貢獻。

1. Fork 專案。
2. 建立功能分支（`git checkout -b feature/AmazingFeature`）。
3. 提交變更（`git commit -m 'Add some AmazingFeature'`）。
4. 推送分支（`git push origin feature/AmazingFeature`）。
5. 開啟 Pull Request。

你也可以透過以下方式貢獻：

- 提出策略性懶惰工作流的改進建議。
- 回報腳本或文件問題。
- 改善硬體／軟體路徑的安裝可重現性。

## 授權

本倉庫採用 GNU General Public License v3.0。詳見 [LICENSE](../LICENSE)。

## 致謝

特別感謝所有貢獻者、OpenAI 團隊，以及支持低摩擦學習系統實驗的 Raspberry Pi / maker 社群。

## 聯絡

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
