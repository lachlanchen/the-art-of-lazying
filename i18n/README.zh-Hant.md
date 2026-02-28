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

這是一個聚焦於「策略性偷懶（strategic laziness）」的儲存庫，目標是打造更簡單、槓桿更高的生活方式，涵蓋 AI 代理、語言學習、實用自動化，以及由 vlog 驅動的真實工作流程。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目錄

- [總覽](#總覽)
- [專案](#專案)
- [儲存庫結構](#儲存庫結構)
- [功能特色](#功能特色)
- [先決條件](#先決條件)
- [安裝](#安裝)
- [使用方式](#使用方式)
- [設定](#設定)
- [範例](#範例)
- [開發說明](#開發說明)
- [疑難排解](#疑難排解)
- [路線圖](#路線圖)
- [介紹](#介紹)
- [Lazying 理論](#lazying-理論)
- [實用技巧](#實用技巧)
- [使用案例](#使用案例)
- [AI 代理與自動化](#ai-代理與自動化)
- [語言學習與 Vlog](#語言學習與-vlog)
- [社群貢獻](#社群貢獻)
- [聯絡方式](#聯絡方式)
- [支持 / 捐助](#支持--捐助)
- [貢獻指南](#貢獻指南)
- [授權](#授權)

## 總覽

`the-art-of-lazying` 是一個聚焦「實作型策略性偷懶」的樞紐儲存庫：自動化重複工作、優化語言學習流程，並透過腳本與 vlog 記錄真實世界的實驗。

| 一覽 | 說明 |
|---|---|
| 🎯 核心主題 | 以策略性偷懶提升生產力、學習成效與創作輸出 |
| 🧩 儲存庫型態 | 本地工具 + 精選外部專案的混合模式 |
| 🛠️ 本地重點 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 文件 | 根目錄 README + 多語系 `i18n/` 版本 |

本儲存庫同時包含：
- 與主題相關的外部專案精選連結。
- 本地工具與程式碼，特別是：
  - `code/EinkWordsGPT`（Raspberry Pi + Waveshare e-ink + OpenAI 單字學習顯示）。
  - `scripts/lazy-care/SafeShell`（安全刪除/還原 shell 函式）。
  - `vlogs/chatgpt-traffic` 與 `vlogs/repo2text`（小型 Python 工具）。

## 專案

### 🚀 AI 驅動創作工具

| 專案 | 說明 | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 以 GPT 驅動單字學習的電子紙顯示器 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 單字詞源分析，並以圖形化方式呈現。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 以最小投入實現高效率語言學習的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 使用 OpenAI CLIP embeddings + GPT decoder 的影片與影像字幕工具 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 影片字幕工具：以 Katna/OpenCV 擷取關鍵影格，並以 ViT+GPT-2 模型生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 具細緻語言偵測能力的多語轉錄流程 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破語言隔閡，促進全球創作交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 影片自動中繼資料生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 驅動的自動影片剪輯工具，具備轉錄、自動字幕、重點提取與中繼資料生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 串流化內容發布工作流程 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 監控、處理並將影片內容發布到多平台的自動化系統 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 高效使用 AI 助手的進階技巧 | |

### ⚙️ 自動化工具（本儲存庫內）

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: 更安全的 shell 刪除（`saferm`）、還原（`unrm`），與明確永久刪除（`removeitanyway`）。
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: 網域到 IP 解析器，並產生去重後輸出。
- `vlogs/repo2text/convert-repo-to-merged-text.py`: 依目錄合併 Python 檔案為文字 bundle，便於 AI 輔助分析。

## 儲存庫結構

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

注意：舊版 README 的通用資料夾圖示曾引用較抽象路徑（例如 `book/`、`code/ai-agents/`），與目前儲存庫樹狀結構不完全一致。以上結構反映目前實際檔案狀態。

## 功能特色

- 用於生產力、學習與內容工作流程的策略性偷懶框架。
- 涵蓋轉錄、字幕、翻譯與發布自動化的 AI 專案精選組合。
- 結合硬體的語言學習方案，透過 GPT 輔助選詞（`EinkWordsGPT`）。
- 提供可逆刪除流程的實用 shell 安全工具。
- 以腳本為核心的 DNS/網域流量檢查與 repo-to-text 轉換工具。
- 透過 `i18n/` 提供多語系文件支持。

## 先決條件

一般需求：
- Git
- 建議 Python 3.9+

針對 `code/EinkWordsGPT`：
- Raspberry Pi（專案文件提及 Raspberry Pi 5）
- Waveshare 7.3 吋 7 色電子紙，且具 Python 驅動支援（`waveshare_epd`）
- 程式碼使用到的 Python 套件：`openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite（使用 Python 標準函式庫 `sqlite3`）
- 已在環境中設定 OpenAI API key（程式直接初始化 `OpenAI()`）

針對 `vlogs/chatgpt-traffic`：
- `dnspython`

針對 `scripts/lazy-care/SafeShell`：
- Bash 或 Zsh shell，且可使用 `realpath`、`mv` 與 `/bin/rm`

## 安裝

複製儲存庫：

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

安裝常用的 Python 依賴（儲存庫層級基線）：

```bash
pip install openai Pillow pytz pykakasi dnspython
```

注意：`code/EinkWordsGPT/README.md` 有提到 `requirements.txt`，但目前此儲存庫中並沒有 `requirements.txt`。請依上方方式手動安裝套件。

## 使用方式

### 1) EinkWordsGPT（本地硬體流程）

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

### 2) SafeShell（更安全的刪除流程）

載入 shell 函式：

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

使用指令：

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

### 4) Repo-to-text 合併工具

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

注意：`convert-repo-to-merged-text.py` 目前使用硬編碼路徑（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）。若要套用到其他 repo，執行前請先修改這些常數。

## 設定

### OpenAI 設定（`code/EinkWordsGPT`）

程式以以下方式建立 client：

```python
client = OpenAI()
```

因此在執行腳本前，請以 OpenAI 標準環境變數方式設定 API 憑證。

### 資料庫路徑（`code/EinkWordsGPT`）

程式中的預設值：

```python
db_path = 'words_phonetics.db'
```

請確認 `words_phonetics.db` 存在於 `code/EinkWordsGPT/`（目前此儲存庫已包含該檔案）。

### SafeShell 垃圾桶位置

`saferm`/`unrm`/`removeitanyway` 使用固定基底路徑：

```bash
/mnt/disk/BIN/ROOT
```

若你的環境不同，請修改 `scripts/lazy-care/SafeShell/safeshell_functions.sh` 中的此路徑。

## 範例

- `demos/` 中的電子紙單字卡示例：
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT 建置筆記/素材：
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 開發說明

- 這是一個多專案展示型儲存庫，包含本地程式碼與外部專案連結。
- 目前根目錄尚未提供統一套件管理或建置描述檔（根目錄不存在 `pyproject.toml`、`package.json`、`requirements.txt`、`Makefile`）。
- 部分子 README 具有模板性質，可能相較當前檔案布局略為過時；本 README 中的指令已對齊目前實際存在的路徑與腳本。
- `README_EN.md` 與 `README_CN.md` 為舊版變體；目前有效的多語架構是 `README.md` + `i18n/*`。

## 疑難排解

- Python 套件出現 `ModuleNotFoundError`：
  - 重新安裝依賴：`pip install openai Pillow pytz pykakasi dnspython`。

- `EinkWordsGPT` 出現 `ImportError: waveshare_epd`：
  - 請在 Raspberry Pi 環境安裝 Waveshare 電子紙 Python driver/library。

- OpenAI 驗證錯誤：
  - 執行 `words_gpt.py` 或 `words_update.py` 前，請確認環境變數已正確設定 OpenAI API key。

- 設定後找不到 `saferm`/`unrm`：
  - 確認你已 source 正確的 shell rc 檔，且 `safeshell_functions.sh` 已成功追加。

- `unrm` 無法還原檔案：
  - 確認還原路徑與 SafeShell 在 `/mnt/disk/BIN/ROOT` 下的鏡像垃圾桶布局一致。

- `repo2text` 腳本沒有輸出：
  - 將 `convert-repo-to-merged-text.py` 的 `source_directory` 改為實際存在的資料夾。

## 路線圖

- 擴充各 i18n 檔案與根 README 的內容一致性（目前多數語言仍偏摘要）。
- 補充 Waveshare e-ink driver 的環境化安裝說明。
- 為本地工具補齊根目錄可重現的依賴描述檔。
- 為關鍵工具補上驗證/測試腳本。
- 持續整理外部專案連結，並補充更完整的本地 demo。

## 介紹

The Art of Lazying 將策略性偷懶視為一種能量優化方式，幫助你把注意力聚焦在真正重要的事情。此儲存庫探索如何透過有意識的偷懶，提升生產力、創造力與整體生活品質。

## Lazying 理論

本章節完整介紹策略性偷懶的核心原則，重點在於透過優先排序、任務委派與自動化，最大化生產力與幸福感。

關鍵原則是把 Pareto 80/20 法則應用到日常生活：找出能產生 80% 目標成果的 20% 活動。

## 實用技巧

可直接落地的建議，協助把偷懶原則應用到工作、關係與自我照護：
- 自動化重複性任務
- 使用番茄鐘（Pomodoro Technique）管理時間
- 建立能降低決策疲勞的系統
- 善用 AI 工具輔助

## 使用案例

透過真實案例展示 lazying 原則如何解決問題並提升效率：
- 創業者如何利用委派與自動化，把重心放在業務成長
- 學術工作者如何精簡研究流程
- 內容創作者如何優化製作流程

## AI 代理與自動化

探索能簡化任務的 AI 代理與自動化工具開發：
- 把 ChatGPT 當作個人助理使用
- 建立客製化自動化工作流程
- 製作用於被動學習的電子紙顯示裝置

## 語言學習與 Vlog

提供高效率語言學習資源與方法，並透過 vlog 記錄 lazying 實踐歷程：
- 以間隔重複建立個人化語言學習流程
- 實作沉浸式學習技巧
- 打造促進被動學習的專案

## 社群貢獻

歡迎分享你在策略性偷懶上的經驗、技巧與想法：
- 交流生產力技巧的論壇
- 日常流程工具與模板
- 提升偷懶效率的協作專案

## 聯絡方式

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## 支持 / 捐助

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

來自 `.github/FUNDING.yml` 的其他資助連結：
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## 貢獻指南

歡迎在程式碼、文件、範例與翻譯等面向貢獻。

1. Fork 此儲存庫。
2. 建立分支（`git checkout -b feature/your-feature`）。
3. 以清楚的 commit 訊息進行修改。
4. 開啟 Pull Request，說明動機與影響。

如果你不確定從哪裡開始：
- 改善某個本地工具的 setup 文件。
- 為現有工具補上測試或驗證腳本。
- 改善某個 `i18n/README.*.md` 版本的一致性/品質。

## 授權

本儲存庫在根目錄（`LICENSE`）及多個子資料夾中包含 GPLv3 授權文本。

注意：某些子專案 README 有提到 MIT。在各子模組授權逐一釐清前，請將根儲存庫視為受 GPLv3 管理；若你計畫獨立散布子專案程式碼，請先逐一確認其授權。
