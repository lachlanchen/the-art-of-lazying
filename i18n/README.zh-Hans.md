[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# 懒惰的艺术

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

这是一个专注于战略性“偷懒”的仓库，旨在用更简单、更高杠杆的方式生活：围绕 AI 智能体、语言学习、实用自动化和以 vlog 驱动的真实工作流展开。

| 聚焦 | 本 README 包含内容 |
|---|---|
| 🤖 自动化 | 可本地运行的核心工具、脚本与实操流程 |
| 🧠 学习 | 面向高效学习的语言优先项目与示例 |
| 📚 共享 | 多语言文档、项目链接与贡献指引 |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目录

- [概览](#概览)
- [项目](#项目)
- [仓库结构](#仓库结构)
- [特性](#特性)
- [先决条件](#先决条件)
- [安装](#安装)
- [使用方法](#使用方法)
- [配置](#配置)
- [示例](#示例)
- [开发说明](#开发说明)
- [故障排查](#故障排查)
- [路线图](#路线图)
- [引言](#引言)
- [懒惰理论](#懒惰理论)
- [实用技巧](#实用技巧)
- [应用场景](#应用场景)
- [AI 智能体与自动化](#ai-智能体与自动化)
- [语言学习与 Vlog](#语言学习与-vlog)
- [社区贡献](#社区贡献)
- [❤️ Support](#-support)
- [联系](#联系)
- [参与贡献](#参与贡献)
- [许可证](#许可证)

## 概览

`the-art-of-lazying` 是一个面向实用战略性懒惰的核心仓库：自动化重复性工作、优化语言学习流程，并通过脚本和 vlog 记录真实世界的实验。

| 一览 | 细节 |
|---|---|
| 🎯 核心主题 | 用于生产力、学习与创作输出的战略性懒惰 | 
| 🧩 仓库风格 | 本地工具与精选外部项目的混合模式 |
| 🛠️ 本地重点 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 文档 | 根 README + 多语言 `i18n/` 版本 |

本仓库包含两类内容：
- 相关外部项目的精选链接。
- 本地工具和代码，尤其是：
  - `code/EinkWordsGPT`（树莓派 + Waveshare 墨水屏 + OpenAI 单词学习显示）。
  - `scripts/lazy-care/SafeShell`（安全的删除/恢复 shell 函数）。
  - `vlogs/chatgpt-traffic` 与 `vlogs/repo2text`（轻量 Python 工具）。

## 项目

### 🚀 AI 驱动的创作工具

| 项目 | 描述 | 示例 |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 驱动的电子墨水屏单词学习工具 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 词源分析与图谱化呈现。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 用最小付出实现高效语言学习的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 结合 OpenAI CLIP embedding 与 GPT 解码器进行视频和图像字幕生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 视频字幕工具：用 Katna/OpenCV 抽取关键帧，再用 ViT+GPT-2 生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 支持细粒度语言识别的多语言转写流水线 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破语言壁垒，推动全球创作交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 视频元数据自动生成功能 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 自动视频编辑工具，包含转录、自动字幕、重点高亮与元数据生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 简化内容发布工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 自动监控、处理并发布视频内容到多平台的系统 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AI 助手高效使用的进阶技巧 | |

### ⚙️ 自动化工具（仓库内本地）

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`：更安全的 shell 删除（`saferm`）、恢复（`unrm`）以及明确的永久删除（`removeitanyway`）。
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`：域名到 IP 的解析器与去重输出生成器。
- `vlogs/repo2text/convert-repo-to-merged-text.py`：按目录将 Python 文件合并为文本包，便于 AI 辅助分析。

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

说明：旧版 README 的通用目录图曾出现抽象路径（例如 `book/`、`code/ai-agents/`），与当前仓库树并不完全一致。上面结构反映的是当前文件布局。

## 特性

- 针对生产力、学习和内容工作流的战略性懒惰框架。
- 覆盖转录、字幕、翻译与发布自动化的 AI 项目组合。
- 结合硬件的语言学习：`EinkWordsGPT` 的 GPT 辅助选词显示。
- 实用 shell 安全工具，支持可逆删除流程。
- 脚本优先的实用工具，包含 DNS/域名流量检查与仓库转文本。
- 通过 `i18n/` 提供多语言文档支持。

## 先决条件

通用：
- Git
- 推荐 Python 3.9+

针对 `code/EinkWordsGPT`：
- Raspberry Pi（项目文档提及 Raspberry Pi 5）
- Waveshare 7.3 英寸七色电子纸屏（需支持 `waveshare_epd` 的 Python 驱动）
- 代码中使用的 Python 包：`openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite（使用 Python 标准库 `sqlite3`）
- 在环境变量中配置 OpenAI API Key（代码直接使用 `OpenAI()` 初始化）

针对 `vlogs/chatgpt-traffic`：
- `dnspython`

针对 `scripts/lazy-care/SafeShell`：
- 支持 `realpath`、`mv` 和 `/bin/rm` 的 Bash 或 Zsh

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

说明：`code/EinkWordsGPT/README.md` 提到了 `requirements.txt`，但当前仓库中尚无 `requirements.txt`。请按上方命令手动安装。

## 使用方法

### 1) EinkWordsGPT（本地硬件流程）

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

可选的数据库维护脚本：

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

执行命令：

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

说明：`convert-repo-to-merged-text.py` 目前使用了硬编码路径（`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`）。在运行其他仓库前请先修改这些常量。

## 配置

### OpenAI 配置（`code/EinkWordsGPT`）

代码创建客户端方式如下：

```python
client = OpenAI()
```

因此请在运行脚本前按 OpenAI 标准方式配置环境变量中的 API 凭据。

### 数据库路径（`code/EinkWordsGPT`）

代码默认值：

```python
db_path = 'words_phonetics.db'
```

确保 `code/EinkWordsGPT/` 中存在 `words_phonetics.db`（仓库当前已包含该文件）。

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
- ChachaGPT 的构建说明与素材：
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 开发说明

- 这是一个多项目展示型仓库，既包含本地代码也包含外部项目链接。
- 根目录目前未提供统一的包管理或构建清单（`pyproject.toml`、`package.json`、`requirements.txt`、`Makefile` 均未存在）。
- 部分子级 README 偏模板化，可能与当前文件布局有一定延迟；本 README 中的命令以当前实际路径和脚本为准。
- `README_EN.md` 与 `README_CN.md` 为历史版本；当前多语言结构以 `README.md` + `i18n/*` 为主。

## 故障排查

- `ModuleNotFoundError`（Python 包缺失）：
  - 使用 `pip install openai Pillow pytz pykakasi dnspython` 重新安装。

- `EinkWordsGPT` 中出现 `ImportError: waveshare_epd`：
  - 在树莓派环境中安装 Waveshare 电子纸 Python 驱动/库。

- OpenAI 认证报错：
  - 在运行 `words_gpt.py` 或 `words_update.py` 前确认环境变量中已设置 OpenAI API Key。

- 安装后找不到 `saferm`/`unrm`：
  - 确认已正确 `source` 所用的 shell rc 文件，并且 `safeshell_functions.sh` 已成功追加。

- `unrm` 无法恢复文件：
  - 检查恢复路径是否与 SafeShell 在 `/mnt/disk/BIN/ROOT` 下的镜像回收布局一致。

- `repo2text` 脚本无输出：
  - 修改 `convert-repo-to-merged-text.py` 中的 `source_directory` 为一个存在的目录。

## 路线图

- 扩展根 README 在所有 i18n 文件中的一致性（当前多数语言仍为摘要版）。
- 补充 Waveshare 电子墨水屏驱动在不同环境下的配置说明。
- 为本地工具补充根目录级可复现依赖清单。
- 为关键工具添加验证/测试脚本。
- 继续整合外部项目链接，并补充更丰富的本地演示。

## 引言

The Art of Lazying 将“战略性懒惰”视为一种优化精力分配、聚焦真正重要事项的方法。本仓库探索了有意识地“偷懒”如何带来更高的生产力、创造力与身心状态。

## 懒惰理论

这是对战略性懒惰原则的系统介绍，核心是通过优先级排序、任务委派和自动化，在提升产能与幸福感的同时，降低无效消耗。

关键原则是将帕累托法则（80/20）应用到日常生活：识别那 20% 的行为，却能带来 80% 想要的结果。

## 实用技巧

一组可直接执行的建议，帮助你将懒惰原则应用到工作、关系与自我管理：
- 自动化重复任务
- 使用番茄工作法进行时间管理
- 构建减少决策疲劳的系统
- 善用 AI 工具进行辅助

## 应用场景

通过真实案例展示懒惰原则如何解决问题并提升效率：
- 创业者如何通过委派和自动化专注业务增长
- 学术研究者如何精简研究流程
- 内容创作者如何优化其制作链路

## AI 智能体与自动化

探索用于简化任务的 AI 智能体与自动化工具：
- 把 ChatGPT 用作个人助理
- 构建自定义自动化工作流
- 创建用于被动学习的电子纸显示装置

## 语言学习与 Vlogs

提供高效语言学习资源和方法，并通过 vlog 记录懒惰实践：
- 用间隔重复法搭建个性化学习系统
- 落地沉浸式学习技巧
- 构建鼓励被动学习的项目

## 社区贡献

欢迎分享你关于战略性懒惰的经验、技巧与想法：
- 交流生产力技巧的讨论空间
- 日常流程工具与模板
- 围绕“高效懒惰”的协作项目

## 联系

- 网站：[lazying.art](https://lazying.art)
- GitHub：[lachlanchen](https://github.com/lachlanchen)
- 邮箱：lach@lazying.art

## 参与贡献

欢迎对代码、文档、示例和翻译进行贡献。

1. Fork 仓库。
2. 创建分支（`git checkout -b feature/your-feature`）。
3. 用清晰的提交说明提交更改。
4. 提交 Pull Request，说明动机与影响。

如果你不确定从何开始：
- 改进某个本地工具的安装文档。
- 为现有工具补充测试或校验脚本。
- 提升某个 `i18n/README.*.md` 版本的一致性与质量。

## 许可证

本仓库在根目录的 `LICENSE` 及多个子目录中包含 GPLv3 的许可证文本。

说明：部分子项目 README 提到 MIT。直到每个子项目的许可证状态明确前，请按根仓库 GPLv3 进行处理；若要单独再分发某个子项目代码，请先逐个核对其许可证。


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
