[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt 横幅" />
</p>

# The Art of Lazying

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

这是一个聚焦“战略性偷懒”的仓库，目标是用更省力的方式获得更高杠杆的生活与工作效果，内容涵盖 AI Agents、语言学习、实用自动化，以及由 vlog 驱动的真实工作流实践。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目录

- [概览](#概览)
- [项目](#项目)
- [仓库结构](#仓库结构)
- [特性](#特性)
- [前置要求](#前置要求)
- [安装](#安装)
- [使用方法](#使用方法)
- [配置](#配置)
- [示例](#示例)
- [开发说明](#开发说明)
- [故障排查](#故障排查)
- [路线图](#路线图)
- [引言](#引言)
- [Lazying 理论](#lazying-理论)
- [实用技巧](#实用技巧)
- [应用场景](#应用场景)
- [AI Agents 与自动化](#ai-agents-与自动化)
- [语言学习与 Vlog](#语言学习与-vlog)
- [社区贡献](#社区贡献)
- [联系](#联系)
- [支持 / 捐助](#支持--捐助)
- [参与贡献](#参与贡献)
- [许可证](#许可证)

## 概览

`the-art-of-lazying` 是一个面向“实用战略性偷懒”的枢纽仓库：自动化重复工作、优化语言学习流程，并通过脚本与 vlog 记录真实世界实验。

| 一览 | 详情 |
|---|---|
| 🎯 核心主题 | 面向生产力、学习与创作输出的战略性偷懒 |
| 🧩 仓库风格 | 本地工具 + 精选外部项目的混合形态 |
| 🛠️ 本地重点 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 文档 | 根 README + 多语言 `i18n/` 版本 |

本仓库同时包含：
- 指向相关外部项目的精选链接。
- 本地工具与代码，尤其是：
  - `code/EinkWordsGPT`（Raspberry Pi + Waveshare 电子墨水屏 + OpenAI 的单词学习显示系统）。
  - `scripts/lazy-care/SafeShell`（安全删除/恢复的 shell 函数）。
  - `vlogs/chatgpt-traffic` 和 `vlogs/repo2text`（小型 Python 工具）。

## 项目

### 🚀 AI 驱动的创作工具

| 项目 | 描述 | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 基于 GPT 的电子墨水屏单词学习工具 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 词源分析并以图谱方式展示 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 低投入高效率的语言学习工具集 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 使用 OpenAI CLIP embeddings + GPT decoder 的视频/图像字幕生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 视频字幕工具：用 Katna/OpenCV 抽关键帧，并用 ViT+GPT-2 模型生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 支持细粒度语言检测的多语种转录流水线 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破语言壁垒，促进全球创作交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 视频元数据自动生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 自动视频编辑工具，包含转录、自动字幕、高亮片段和元数据生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 简化内容发布工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 面向多平台视频内容监控、处理和发布的自动化系统 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 高效使用 AI 助手的进阶方法 | |

### ⚙️ 自动化工具（本仓库本地）

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: 更安全的 shell 删除（`saferm`）、恢复（`unrm`）和显式永久删除（`removeitanyway`）。
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: 域名到 IP 解析器与去重输出生成工具。
- `vlogs/repo2text/convert-repo-to-merged-text.py`: 按目录合并 Python 文件为文本包，便于 AI 辅助分析。

## 仓库结构

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

说明：旧版 README 中的通用目录图有时会引用抽象路径（如 `book/`、`code/ai-agents/`），与当前仓库树并不完全一致。以上结构反映的是当前文件状态。

## 特性

- 面向生产力、学习和内容工作流的战略性偷懒框架。
- 覆盖转录、字幕、翻译与发布自动化的 AI 项目组合。
- 结合硬件的语言学习方案，支持 GPT 辅助选词（`EinkWordsGPT`）。
- 面向可恢复删除流程的实用 shell 安全工具。
- 以脚本为核心的 DNS/域名流量检查与仓库转文本工具。
- 通过 `i18n/` 提供多语言文档支持。

## 前置要求

通用：
- Git
- 建议 Python 3.9+

对于 `code/EinkWordsGPT`：
- Raspberry Pi（项目文档提到 Raspberry Pi 5）
- Waveshare 7.3 英寸 7 色电子墨水屏，且支持 Python 驱动（`waveshare_epd`）
- 代码中使用的 Python 包：`openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite（使用 Python 标准库 `sqlite3`）
- 在环境中配置 OpenAI API key（代码直接初始化 `OpenAI()`）

对于 `vlogs/chatgpt-traffic`：
- `dnspython`

对于 `scripts/lazy-care/SafeShell`：
- Bash 或 Zsh，且可访问 `realpath`、`mv` 和 `/bin/rm`

## 安装

克隆仓库：

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

安装常用 Python 依赖（仓库级基础）：

```bash
pip install openai Pillow pytz pykakasi dnspython
```

说明：`code/EinkWordsGPT/README.md` 提到了 `requirements.txt`，但当前仓库中并不存在 `requirements.txt`。请按上面方式手动安装。

## 使用方法

### 1) EinkWordsGPT（本地硬件流程）

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

可选数据库维护脚本：

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell（更安全的删除流程）

加载 shell 函数：

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

使用命令：

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

### 4) Repo-to-text 合并器

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

说明：`convert-repo-to-merged-text.py` 目前使用硬编码路径（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）。在用于其他仓库前请先修改这些常量。

## 配置

### OpenAI 配置（`code/EinkWordsGPT`）

代码中客户端创建方式：

```python
client = OpenAI()
```

因此，请在运行脚本前按 OpenAI 标准环境变量方式配置 API 凭据。

### 数据库路径（`code/EinkWordsGPT`）

代码默认值：

```python
db_path = 'words_phonetics.db'
```

请确保 `code/EinkWordsGPT/` 中存在 `words_phonetics.db`（当前仓库已包含该文件）。

### SafeShell 回收站位置

`saferm`/`unrm`/`removeitanyway` 使用固定基础路径：

```bash
/mnt/disk/BIN/ROOT
```

如果你的环境不同，请在 `scripts/lazy-care/SafeShell/safeshell_functions.sh` 中调整该路径。

## 示例

- `demos/` 中的电子墨水单词卡演示：
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT 的构建说明/材料：
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 开发说明

- 这是一个多项目展示型仓库，既包含本地代码，也包含外部项目链接。
- 根目录当前未提供统一包管理或构建清单（根目录没有 `pyproject.toml`、`package.json`、`requirements.txt`、`Makefile`）。
- 若干子 README 更像模板，可能相对当前文件布局有部分过时；本 README 中的命令已对齐当前实际存在的路径/脚本。
- `README_EN.md` 和 `README_CN.md` 属于历史版本；当前有效的多语言结构是 `README.md` + `i18n/*`。

## 故障排查

- Python 包报 `ModuleNotFoundError`：
  - 重新安装依赖：`pip install openai Pillow pytz pykakasi dnspython`。

- `EinkWordsGPT` 中报 `ImportError: waveshare_epd`：
  - 在 Raspberry Pi 环境中安装 Waveshare 电子纸 Python 驱动/库。

- OpenAI 认证错误：
  - 在运行 `words_gpt.py` 或 `words_update.py` 之前，确认环境变量中的 OpenAI API key 已正确设置。

- 安装后找不到 `saferm`/`unrm`：
  - 确认你已 source 正确的 shell rc 文件，且 `safeshell_functions.sh` 已成功追加。

- `unrm` 无法恢复文件：
  - 检查恢复路径是否与 SafeShell 在 `/mnt/disk/BIN/ROOT` 下的镜像回收结构一致。

- `repo2text` 脚本没有输出：
  - 将 `convert-repo-to-merged-text.py` 中的 `source_directory` 改为一个实际存在的目录。

## 路线图

- 提升所有 i18n 文件与根 README 的一致性（目前许多语言版本仍为摘要）。
- 增加面向不同环境的 Waveshare 电子墨水屏驱动安装文档。
- 为本地工具补充根级可复现实验依赖清单。
- 为关键工具补充校验/测试脚本。
- 持续整合外部项目链接，并补充更丰富的本地 demo。

## 引言

The Art of Lazying 将“战略性偷懒”视为一种优化精力分配、聚焦真正重要事项的方法。这个仓库探索了有意识地“偷懒”如何带来更高的生产力、创造力与幸福感。

## Lazying 理论

本节系统介绍战略性偷懒的原则，核心是通过优先级排序、任务委派和自动化，在提升效率的同时改善生活质量。

其中关键原则是把帕累托 80/20 法则应用到日常生活：识别出那 20% 能带来 80% 结果的活动。

## 实用技巧

围绕工作、关系与自我照护，给出可落地的偷懒实践建议：
- 自动化重复任务
- 使用番茄工作法进行时间管理
- 构建能减少决策疲劳的系统
- 借助 AI 工具完成辅助工作

## 应用场景

通过真实案例展示 lazying 原则如何解决问题并提升效率：
- 创业者如何通过委派与自动化聚焦业务增长
- 学术研究者如何精简研究工作流
- 内容创作者如何优化制作流程

## AI Agents 与自动化

探索用于简化任务的 AI Agents 与自动化工具开发：
- 把 ChatGPT 作为个人助理
- 搭建自定义自动化工作流
- 构建用于被动学习的电子墨水屏项目

## 语言学习与 Vlog

提供高效语言学习资源与方法，并通过 vlog 记录 lazying 实践：
- 利用间隔重复构建个性化语言学习系统
- 实施沉浸式学习方法
- 构建鼓励被动学习的项目

## 社区贡献

欢迎分享你在战略性偷懒方面的经验、技巧和想法：
- 交流生产力技巧的讨论空间
- 日常流程工具与模板
- 围绕“高效偷懒”的协作项目

## 联系

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

来自 `.github/FUNDING.yml` 的其他资助链接：
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## 参与贡献

欢迎在代码、文档、示例和翻译方面贡献内容。

1. Fork 仓库。
2. 创建分支（`git checkout -b feature/your-feature`）。
3. 使用清晰的 commit message 进行修改。
4. 提交 Pull Request，说明动机与影响。

如果你不确定从哪里开始：
- 改进某个本地工具的安装文档。
- 为现有工具添加测试或校验脚本。
- 提升某个 `i18n/README.*.md` 版本的一致性/质量。

## 许可证

本仓库在根目录（`LICENSE`）及多个子目录中提供 GPLv3 许可证文本。

说明：部分子项目 README 提到 MIT。在每个子模块许可证完全澄清前，请将根仓库视为受 GPLv3 约束；若要单独再分发某个子项目代码，请先逐个核对其许可证。
