[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> 说明：本仓库已迁移。活跃开发请见 https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

一个倡导“战略性偷懒”的仓库，聚焦以更简化且高产的方式生活与工作，涵盖 AI Agent、语言学习与 vlog，并提供实用技巧和真实使用案例。

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 目录

- [概览](#概览)
- [项目](#项目)
- [自动化工具](#自动化工具)
- [文件夹结构](#文件夹结构)
- [简介](#简介)
- [Lazying 理论](#lazying-理论)
- [实用技巧](#实用技巧)
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

## 概览

`the-art-of-lazying-legacy` 是一个围绕“战略性偷懒”主题整理的总览型仓库：

- 关于如何将 “lazying” 理念应用到工作与生活的概念内容。
- 可直接参考和运行的代码资产，包括电子墨水屏 + GPT 语言学习项目（`code/EinkWordsGPT`）。
- 更安全工作流的实用脚本（`scripts/lazy-care/SafeShell`）。
- 与 vlog 相关的工具与自动化片段（`vlogs/`）。
- 演示素材与示例（`demos/`, `examples/`, `figs/`）。

| 快照 | 值 |
|---|---|
| 仓库定位 | 旧版归档 + 思路地图 |
| 活跃开发仓库 | https://github.com/lachlanchen/the-art-of-lazying |
| 多语言 README 文件 | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n 目录 | `i18n/`（已存在） |

该仓库作为历史归档和思路地图仍然有价值；活跃开发已迁移到上方链接的仓库。

## 项目

### 🤖 AI 驱动的创意工具

| 项目 | 描述 | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | 使用 GPT 驱动词汇学习的电子墨水屏项目 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 词源分析并以图谱形式展示。 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 以最少投入实现高效语言学习的工具 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | 基于 OpenAI CLIP embeddings + GPT decoder 的视频与图像字幕生成 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 视频字幕工具：用 Katna/OpenCV 提取关键帧，并使用 ViT+GPT-2 模型生成字幕 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 细粒度语言检测的多语言转写流水线 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 打破语言边界，促进全球创作交流 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 视频元数据自动生成 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI 自动视频编辑工具，支持转写、自动字幕、重点高亮与元数据生成 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 简化内容发布工作流 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 面向多平台的视频内容监控、处理与发布自动化系统 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | 高效使用 AI 助手的进阶方法 | |

## 自动化工具

仓库包含可直接在本地运行的自动化工具：

| 路径 | 用途 |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 持续运行的电子墨水词卡渲染循环（默认每 300 秒刷新）。 |
| `code/EinkWordsGPT/words_update.py` | 基于 OpenAI 逻辑进行批量或定向词条详情更新。 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3 英寸电子纸硬件测试。 |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, `removeitanyway` shell 函数。 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 域名到 IP 解析并输出去重结果。 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | 按子目录合并 `.py` 文件为 `.txt` 文件。 |

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

> 说明：上方概念结构图刻意保留自更早版本 README；“当前仓库结构”代码块反映的是本 legacy 仓库中的实际目录树。

## 简介

The Art of Lazying 将“战略性偷懒”作为优化精力分配、聚焦真正重要事项的方法。本仓库探讨了如何通过有意识的“偷懒”获得更高生产力、创造力与幸福感。

## Lazying 理论

这里对“战略性偷懒”原则进行系统介绍，核心是通过优先级管理、委派与自动化来最大化产出与身心收益。

关键原则是将帕累托 80/20 法则应用到日常生活中：识别能带来 80% 结果的 20% 关键活动。

## 实用技巧

以下是将 lazying 原则应用到工作、人际关系和自我照护中的可执行建议：

- 自动化重复任务
- 使用番茄工作法进行时间管理
- 建立系统以减少决策疲劳
- 借助 AI 工具进行辅助

## 使用场景

这些真实案例展示了 lazying 原则如何解决问题并提升效率：

- 创业者如何通过委派与自动化专注业务增长
- 学术工作者如何精简研究流程
- 内容创作者如何优化生产过程

## AI Agents 与自动化

探索如何开发 AI Agents 与自动化工具来简化任务：

- 把 ChatGPT 用作个人助手
- 构建自定义自动化工作流
- 打造用于被动学习的电子墨水屏设备

## 语言学习与 Vlog

包含高效语言学习资源与方法，以及记录 lazying 实践过程的 vlog：

- 通过间隔重复构建个性化语言学习
- 实施沉浸式学习策略
- 构建鼓励被动学习的项目

## 社区贡献

欢迎分享你在战略性偷懒方面的经验、技巧和想法：

- 交流效率技巧的社区空间
- 用于日常流程的工具与模板
- 面向“偷懒式高效”的协作项目

## 前置要求

本仓库包含多个相互独立的脚本，因此前置依赖会因模块而异。

常见基础环境：

- Python 3.9+
- `pip`
- Git

根据源码可见的项目依赖信号：

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd`（用于电子纸硬件流程）
- `sqlite3`（标准库）

完整运行 `EinkWordsGPT` 所需硬件：

- Raspberry Pi（项目文档提到 Raspberry Pi 5）
- Waveshare 7 色 7.3 英寸电子墨水屏

## 安装

由于仓库根目录没有统一依赖清单，请按要运行的模块手动安装依赖。

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

### 2) 重新检查/更新词条详情

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) 测试 Waveshare 7.3 英寸面板

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) 解析 ChatGPT 相关域名并输出 IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) 按目录合并 Python 文件，生成更适合 AI 处理的文本包

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

`EinkWordsGPT` 与更新脚本使用官方 SDK 的 `OpenAI()`，并期望你已在环境中配置凭据。

推荐做法（假设）：

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 数据库位置

`code/EinkWordsGPT/words_gpt.py` 与 `words_update.py` 使用：

- `db_path = 'words_phonetics.db'`

如果在 `code/EinkWordsGPT` 以外的目录启动脚本，请对应调整路径。

### SafeShell 回收站根目录

`saferm`/`unrm`/`removeitanyway` 目前使用固定基础路径：

- `/mnt/disk/BIN/ROOT`

在依赖 `saferm` 前，请确认此路径存在且可写。

### Repo2Text 路径

`vlogs/repo2text/convert-repo-to-merged-text.py` 目前包含硬编码路径：

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

请将这些常量改为你的本地项目路径。

## 示例

### 示例：电子墨水学习卡循环

- 脚本会选择（或获取）词条详情。
- 词卡渲染包含音标、音节切分与日语近义提示。
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

- 这是一个 legacy 仓库；活跃开发地址为：https://github.com/lachlanchen/the-art-of-lazying
- 顶层内容偏策展性质，并链接到多个外部仓库。
- `i18n/` 已存在，并用于存放多语言 README。
- 根目录不存在统一的 `requirements.txt` 或 `pyproject.toml`。

保留的兼容性说明：

- 子目录中更早的文档可能提到脚本（`saferm.sh`, `unrm.sh`, `removeitanyway.sh`）；这些已整合到 `scripts/lazy-care/SafeShell/safeshell_functions.sh`。

## 故障排查

- `ModuleNotFoundError`：安装[前置要求](#前置要求)中列出的缺失 Python 包。
- `openai` 认证错误：确认已在 shell 中导出 `OPENAI_API_KEY`。
- Waveshare 运行时问题：在 Pi 上确认 SPI/设备配置，并安装厂商依赖。
- `saferm` 看起来没有效果：检查 `/mnt/disk/BIN/ROOT` 是否存在且有写权限。
- `repo2text` 未生成文件：确认 `source_directory` 指向包含 `.py` 文件的现有目录。
- `chatgpt-traffic` 域名异常：在生产使用前检查并清理脚本中的 `domains` 列表。

## 路线图

- 将本仓库保持为稳定的历史归档，并清晰指向活跃项目。
- 为各可运行子模块补齐更完善的依赖清单。
- 在后续修订中继续完善 `/i18n` 下的一致化多语言布局。
- 扩展更多实用示例与可复现的软硬件环境搭建指南。

## 贡献指南

欢迎贡献。

1. Fork 本项目。
2. 创建功能分支（`git checkout -b feature/AmazingFeature`）。
3. 提交修改（`git commit -m 'Add some AmazingFeature'`）。
4. 推送分支（`git push origin feature/AmazingFeature`）。
5. 发起 Pull Request。

你也可以通过以下方式参与：

- 提出战略性偷懒工作流的改进建议。
- 报告脚本或文档问题。
- 改进软硬件路径下的环境可复现性。

## 许可证

本仓库采用 GNU General Public License v3.0 许可。详见 [LICENSE](LICENSE)。

## 致谢

特别感谢所有贡献者、OpenAI 团队，以及持续支持低摩擦学习系统实验的 Raspberry Pi / maker 社区。

## 联系

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
