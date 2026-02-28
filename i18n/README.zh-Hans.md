[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> 注意：本仓库已迁移，持续更新在 https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

一个围绕“战略性懒惰”理念的仓库，旨在以更简化的方式提升生活和工作效率，内容覆盖 AI Agent、语言学习与 vlog，并提供可落地的技巧与真实使用案例。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目录

- [概览](#概览)
- [项目](#项目)
- [自动化工具](#自动化工具)
- [文件夹结构](#文件夹结构)
- [简介](#简介)
- [懒惰理论](#懒惰理论)
- [实用技巧与窍门](#实用技巧与窍门)
- [使用场景](#使用场景)
- [AI Agents 与自动化](#ai-agents-与自动化)
- [语言学习与 Vlog](#语言学习与-vlog)
- [社区贡献](#社区贡献)
- [前置要求](#前置要求)
- [安装](#安装)
- [使用](#使用)
- [配置](#配置)
- [示例](#示例)
- [开发说明](#开发说明)
- [故障排查](#故障排查)
- [路线图](#路线图)
- [贡献指南](#贡献指南)
- [许可证](#许可证)
- [致谢](#致谢)
- [联系](#联系)

## 快速入口

| 场景 | 从这里开始 |
|---|---|
| 浏览主内容地图 | [概览](#概览) |
| 安装依赖 | [前置要求](#前置要求) |
| 运行示例 | [使用](#使用) |
| 处理常见问题 | [故障排查](#故障排查) |
| 参与贡献 | [贡献指南](#贡献指南) |

## 概览

`the-art-of-lazying-legacy` 是一个围绕“战略性懒惰”构建的精选汇总型仓库：

- 探索如何将“lazying”理念应用于工作与生活的思考内容。
- 可直接运行/参考的代码成果，包括电子纸 + GPT 语言学习项目（`code/EinkWordsGPT`）。
- 提升安全性的工作流脚本（`scripts/lazy-care/SafeShell`）。
- 与 vlog 相关的工具与自动化片段（`vlogs/`）。
- 演示素材与示例（`demos/`、`examples/`、`figs/`）。

| 快照 | 说明 |
|---|---|
| 仓库定位 | 旧版本归档与思想地图 |
| 活跃开发仓库 | https://github.com/lachlanchen/the-art-of-lazying |
| 多语言 README 文件 | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n 目录 | `i18n/`（已存在） |
| 语言学习 | 间隔复习 + GPT 工作流 |
| 自动化侧重 | 脚本、字幕、发布与硬件工作流 |

该仓库仍作为历史归档和思路地图保留，同时活跃开发已迁移到上方链接中的新仓库。

---

## 项目

### 🤖 AI 驱动的创意工具

| 项目 | 描述 | 示例 |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 使用 GPT 的电子墨水词汇学习项目 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 词源分析并以图谱形式展示。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 用最小投入实现高效语言学习的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 使用 OpenAI CLIP embeddings + GPT decoder 的视频与图像字幕生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 视频字幕工具：用 Katna/OpenCV 提取关键帧并用 ViT+GPT-2 模型生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 具备细粒度语言识别的多语种转写流水线 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破语言屏障，推动全球化创作协作 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 自动生成视频元数据 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 驱动的自动化视频编辑工具，支持转写、自动字幕、重点标注与元数据生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 精简内容发布工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 自动监控、处理并发布多平台视频内容的系统 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 高效使用 AI 助手的进阶技巧 | |

## 自动化工具

仓库中包含可直接本地运行的自动化实用工具：

| 路径 | 用途 |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 持续运行的电子纸词卡渲染循环（默认每 300 秒刷新） |
| `code/EinkWordsGPT/words_update.py` | 基于 OpenAI 后端的批量/定向词条详情刷新 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3 英寸电子纸硬件测试 |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`、`unrm` 与 `removeitanyway` shell 函数 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 域名解析到 IP，并去重输出 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | 按子目录合并 `.py` 文件为 `.txt` |

## 文件夹结构

### 当前仓库结构（准确）

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

### 原始概念结构（保留）

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

> 说明：上方概念结构图有意保留自早期 README；“当前仓库结构”代码块则展示本 legacy 仓库的实际目录树。

## 简介

The Art of Lazying 将“战略性懒惰”视为一种分配精力、聚焦真正重要事项的方法。本仓库探讨如何通过有意识地“偷懒”，获得更高的生产力、创造力和幸福感。

## 懒惰理论

全面介绍战略性懒惰的核心原则：通过优先级管理、委派与自动化，把生活中的产出与身心福利做最大化。

关键原则是把帕累托 80/20 法则应用到日常生活：识别那 20% 的活动，它们带来 80% 的期望结果。

## 实用技巧与窍门

以下内容提供了将 lazying 原则应用到工作、人际关系和自我照护中的可执行建议：

- 自动化重复性任务
- 使用番茄工作法进行时间管理
- 建立系统以降低决策疲劳
- 利用 AI 工具提供辅助

## 使用场景

以下是真实案例，展示了 lazying 原则如何解决问题并提升效率：

- 创业者如何通过委派与自动化更专注于业务增长
- 学术研究者如何精简研究流程
- 内容创作者如何优化制作过程

## AI Agents 与自动化

探索 AI Agents 与自动化工具的开发，它们可以简化工作：

- 将 ChatGPT 作为个人助理使用
- 构建定制化自动化工作流
- 为被动学习制作电子纸显示设备

## 语言学习与 Vlog

提供高效语言学习资源和方法，同时记录 lazying 实践过程的 vlog：

- 用间隔重复法打造个性化学习计划
- 实施沉浸式学习策略
- 构建鼓励被动学习的项目

## 社区贡献

欢迎分享你在战略性懒惰方面的经验、技巧和想法：

- 交流效率黑客的社区讨论区
- 为日常流程提供工具与模板
- 面向“以懒求效”理念的协作项目

## 前置要求

仓库包含多个彼此独立的脚本，因此前置依赖因模块不同而异。

常见基础：

- Python 3.9+
- `pip`
- Git

基于源码看到的项目依赖信号：

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd`（用于电子纸硬件流程）
- `sqlite3`（标准库）

运行 `EinkWordsGPT` 全功能所需硬件：

- Raspberry Pi（项目文档提到 Raspberry Pi 5）
- Waveshare 7.3 英寸 7 色电子纸屏幕

## 安装

仓库未提供统一依赖清单，请按需安装你要运行模块的依赖。

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

可选/硬件相关依赖：

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell 初始化：

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## 使用

### 1) 运行 EinkWordsGPT 显示循环

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) 重新检查并更新词条详情

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) 测试 Waveshare 7.3 英寸屏幕

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) 解析 ChatGPT 相关域名并输出 IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) 按目录合并 Python 文件，生成适配 AI 的文本包

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) 使用更安全的文件删除流程

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## 配置

### OpenAI 凭据

`EinkWordsGPT` 与更新脚本使用官方 SDK 的 `OpenAI()`，并要求在环境变量中配置凭据。

建议方式（推荐）：

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 数据库位置

`code/EinkWordsGPT/words_gpt.py` 与 `words_update.py` 使用：

- `db_path = 'words_phonetics.db'`

请从 `code/EinkWordsGPT` 目录运行脚本，或在其他目录执行时同步调整路径。

### SafeShell 回收站根目录

`saferm`、`unrm`、`removeitanyway` 当前使用固定基准路径：

- `/mnt/disk/BIN/ROOT`

请在依赖 `saferm` 前确认该路径存在且可写。

### Repo2Text 路径

`vlogs/repo2text/convert-repo-to-merged-text.py` 当前使用了硬编码路径：

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

请根据你的本地项目修改这些常量。

## 示例

### 示例：电子墨水学习卡循环

- 脚本会选择（或抓取）词条详情。
- 词卡会渲染音标、音节切分和日语近义提示。
- 屏幕每 5 分钟刷新一次（`time.sleep(300)`）。

### 示例：安全删除流程

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### 示例：域名/IP 输出文件

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## 开发说明

- 这是一个 legacy 仓库，活跃开发请关注：https://github.com/lachlanchen/the-art-of-lazying
- 顶层内容为策展型，并链接到多个外部仓库。
- `i18n/` 已存在，语言 README 已收纳在该目录。
- 仓库根目录未提供统一 `requirements.txt` 或 `pyproject.toml`。

兼容性保留说明：

- 子目录中的旧文档可能提到脚本（`saferm.sh`、`unrm.sh`、`removeitanyway.sh`），这些现已整合到 `scripts/lazy-care/SafeShell/safeshell_functions.sh`。

## 故障排查

- `ModuleNotFoundError`：安装[前置要求](#前置要求)中缺失的 Python 包。
- `openai` 身份验证错误：确认已在当前 shell 中导出 `OPENAI_API_KEY`。
- Waveshare 运行问题：在树莓派上确认 SPI/设备配置并安装厂商依赖。
- `saferm` 看起来没有任何动作：检查 `/mnt/disk/BIN/ROOT` 是否存在且有写权限。
- `repo2text` 未生成文件：确认 `source_directory` 指向实际存在并包含 `.py` 文件的目录。
- `chatgpt-traffic` 出现域名异常：上线前检查并清理脚本中的 `domains` 列表。

## 路线图

- 维持仓库作为稳定历史归档，并清晰引导至活跃项目。
- 为各个可运行子模块补齐更完整的依赖清单。
- 在后续修订中完善 `/i18n` 下一致化的多语言布局。
- 扩展更多实操示例，补全硬件与非硬件场景的可复现指南。

## 贡献指南

欢迎贡献。

1. Fork 本项目。
2. 创建特性分支（`git checkout -b feature/AmazingFeature`）。
3. 提交你的修改（`git commit -m 'Add some AmazingFeature'`）。
4. 推送分支（`git push origin feature/AmazingFeature`）。
5. 发起 Pull Request。

你还可以通过以下方式贡献：

- 提出战略性懒惰工作流的改进建议。
- 汇报脚本或文档中的问题。
- 改进软硬件路径下的环境复现性。

## 许可证

该仓库遵循 GNU General Public License v3.0。详见 [LICENSE](LICENSE)。

## 致谢

特别感谢贡献者、OpenAI 团队，以及支持低摩擦学习系统实验的 Raspberry Pi / maker 社区。

## 联系

- 网站: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- 邮箱: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
