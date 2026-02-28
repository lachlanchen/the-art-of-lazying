[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> Примечание: этот репозиторий был перенесен. Активная разработка продолжается в https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# Искусство лениться с умом

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

Репозиторий, посвященный стратегической лени ради более простой и продуктивной жизни: AI-агенты, изучение языков и влоги с практическими советами и примерами из реальной жизни.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Содержание

- [Обзор](#обзор)
- [Проекты](#проекты)
- [Инструменты автоматизации](#инструменты-автоматизации)
- [Структура папок](#структура-папок)
- [Введение](#введение)
- [Теория lazying](#теория-lazying)
- [Практические советы и приемы](#практические-советы-и-приемы)
- [Сценарии использования](#сценарии-использования)
- [AI-агенты и автоматизация](#ai-агенты-и-автоматизация)
- [Изучение языков и влоги](#изучение-языков-и-влоги)
- [Вклад сообщества](#вклад-сообщества)
- [Предварительные требования](#предварительные-требования)
- [Установка](#установка)
- [Использование](#использование)
- [Конфигурация](#конфигурация)
- [Примеры](#примеры)
- [Заметки для разработки](#заметки-для-разработки)
- [Устранение неполадок](#устранение-неполадок)
- [Дорожная карта](#дорожная-карта)
- [Как внести вклад](#как-внести-вклад)
- [Лицензия](#лицензия)
- [Благодарности](#благодарности)
- [Контакты](#контакты)

## Обзор

`the-art-of-lazying-legacy` — это курируемый umbrella-репозиторий вокруг концепции стратегической лени:

- Концептуальные материалы о применении философии «lazying» в работе и жизни.
- Практические кодовые артефакты, включая e-ink + GPT для изучения языков (`code/EinkWordsGPT`).
- Утилитарные скрипты для более безопасных рабочих процессов (`scripts/lazy-care/SafeShell`).
- Инструменты и фрагменты автоматизации для влогов (`vlogs/`).
- Демонстрационные ассеты и примеры (`demos/`, `examples/`, `figs/`).

| Snapshot | Value |
|---|---|
| Repository role | Legacy archive + idea map |
| Active development | https://github.com/lachlanchen/the-art-of-lazying |
| Multilingual README files | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n directory | `i18n/` (present) |

Этот репозиторий по-прежнему полезен как архив и карта идей, тогда как активная разработка перенесена в репозиторий по ссылке выше.

## Проекты

### 🤖 Креативные инструменты на базе ИИ

| Project | Description | Demo |
|---|---|---|
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

## Инструменты автоматизации

Репозиторий включает локальные утилиты автоматизации, которые можно запускать напрямую:

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Continuous e-ink word-card rendering loop (default refresh every 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch and targeted word detail refresh against OpenAI-backed logic. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3" e-paper hardware test. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, and `removeitanyway` shell functions. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Domain-to-IP resolution + deduplicated output. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Merge `.py` files by subdirectory into `.txt` files. |

## Структура папок

### Текущая структура репозитория (актуальная)

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

### Изначальная концептуальная структура (сохранена)

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

> Примечание: концептуальная карта выше намеренно сохранена из более ранних версий README. Блок «Текущая структура репозитория» отражает фактическое дерево этого legacy-репозитория.

## Введение

The Art of Lazying представляет стратегическую лень как способ оптимизировать расход энергии и сосредоточиться на действительно важном. Этот репозиторий показывает, как осознанная лень может приводить к более высокой продуктивности, креативности и благополучию.

## Теория lazying

Подробное введение в принципы стратегической лени с акцентом на то, как максимизировать продуктивность и качество жизни через приоритизацию, делегирование и автоматизацию задач.

Ключевой принцип — применение правила Парето 80/20 к повседневной жизни: определение 20% действий, которые дают 80% желаемых результатов.

## Практические советы и приемы

Подборка практических рекомендаций по применению принципов lazying в работе, отношениях и заботе о себе:

- Автоматизация повторяющихся задач
- Использование техники Pomodoro для управления временем
- Создание систем, снижающих усталость от принятия решений
- Использование AI-инструментов для помощи

## Сценарии использования

Примеры из реальной жизни, показывающие, как принципы lazying решают задачи и повышают эффективность:

- Как предприниматели используют делегирование и автоматизацию, чтобы сосредоточиться на росте бизнеса
- Как исследователи и академики упрощают рабочие процессы исследований
- Как создатели контента оптимизируют процесс производства

## AI-агенты и автоматизация

Изучайте разработку AI-агентов и инструментов автоматизации, которые упрощают задачи:

- Использование ChatGPT как личного ассистента
- Построение кастомных автоматизированных workflow
- Создание e-ink дисплеев для пассивного обучения

## Изучение языков и влоги

Ресурсы и техники для эффективного изучения языков, а также влоги, документирующие путь lazying:

- Создание персонализированного изучения языков с интервальным повторением
- Внедрение техник иммерсивного обучения
- Создание проектов, поощряющих пассивное обучение

## Вклад сообщества

Делитесь собственным опытом, советами и идеями о стратегической лени:

- Площадка для обмена хаками продуктивности
- Инструменты и шаблоны для ежедневных рутин
- Совместные проекты для ленивой эффективности

## Предварительные требования

Репозиторий содержит несколько независимых скриптов, поэтому требования зависят от конкретного модуля.

Общий базовый набор:

- Python 3.9+
- `pip`
- Git

Сигналы о проектно-специфичных зависимостях из исходных файлов:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (for e-paper hardware flows)
- `sqlite3` (standard library)

Требования к железу для полноценного запуска `EinkWordsGPT`:

- Raspberry Pi (в документации проекта упоминается Raspberry Pi 5)
- 7-цветная 7,3-дюймовая e-ink-панель Waveshare

## Установка

Поскольку в корне нет единого манифеста зависимостей, устанавливайте зависимости вручную для того модуля, который хотите запустить.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Необязательная/аппаратная зависимость:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

Настройка SafeShell:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Использование

### 1) Запуск цикла отображения EinkWordsGPT

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Повторная проверка/обновление сведений о словах

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Тест панели Waveshare 7.3-inch

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Разрешение доменов, связанных с ChatGPT, и вывод IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Объединение Python-файлов по директориям в текстовые наборы для AI

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Использование более безопасного workflow удаления файлов

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Конфигурация

### Учетные данные OpenAI

`EinkWordsGPT` и скрипты обновления используют `OpenAI()` из официального SDK и ожидают, что учетные данные настроены в вашем окружении.

Предполагаемый (рекомендуемый) вариант:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Расположение базы данных

`code/EinkWordsGPT/words_gpt.py` и `words_update.py` используют:

- `db_path = 'words_phonetics.db'`

Запускайте скрипты из `code/EinkWordsGPT` или скорректируйте пути при запуске из другого места.

### Корневой путь корзины SafeShell

`saferm`/`unrm`/`removeitanyway` в текущем виде используют фиксированный базовый путь:

- `/mnt/disk/BIN/ROOT`

Перед использованием `saferm` убедитесь, что этот путь существует и доступен для записи.

### Пути Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` сейчас содержит жестко заданные пути:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Отредактируйте эти константы под ваш локальный проект.

## Примеры

### Пример: цикл карточек обучения на e-ink

- Скрипт выбирает (или получает) детали слова.
- Карточка слова отображает фонетику, деление на слоги и подсказки с японскими синонимами.
- Экран обновляется каждые 5 минут (`time.sleep(300)`).

### Пример: безопасный workflow удаления

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Пример: файл вывода доменов/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Заметки для разработки

- Это legacy-репозиторий; активная разработка ведется в: https://github.com/lachlanchen/the-art-of-lazying
- Контент на верхнем уровне носит курирующий характер и ссылается на множество внешних репозиториев.
- `i18n/` существует, но сейчас пуст; языковые README на данный момент расположены в корне.
- В корне отсутствуют `requirements.txt` и `pyproject.toml`.

Сохраненная заметка о совместимости:

- В более ранней документации в подпапках могут упоминаться скрипты (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`), которые теперь объединены в `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Устранение неполадок

- `ModuleNotFoundError`: установите отсутствующие пакеты Python из раздела [Предварительные требования](#предварительные-требования).
- Ошибки аутентификации `openai`: проверьте, что `OPENAI_API_KEY` экспортирован в вашей оболочке.
- Проблемы выполнения Waveshare: проверьте настройку SPI/устройств и установите зависимости вендора на Pi.
- `saferm` как будто ничего не делает: проверьте, что `/mnt/disk/BIN/ROOT` существует и имеет права на запись.
- `repo2text` не создает файлы: убедитесь, что `source_directory` указывает на существующую папку с `.py` файлами.
- Аномалии доменов в `chatgpt-traffic`: перед продуктивным использованием проверьте и очистите список `domains` в скрипте.

## Дорожная карта

- Сохранить этот репозиторий как стабильный legacy-архив с понятными ссылками на активные проекты.
- Улучшить манифесты зависимостей для каждого запускаемого подмодуля.
- Добавить согласованную i18n-структуру в `/i18n` в будущих ревизиях.
- Расширить практические примеры и воспроизводимые гайды по настройке для аппаратных и неаппаратных сценариев.

## Как внести вклад

Вклад приветствуется.

1. Сделайте fork проекта.
2. Создайте ветку для вашей фичи (`git checkout -b feature/AmazingFeature`).
3. Закоммитьте изменения (`git commit -m 'Add some AmazingFeature'`).
4. Отправьте ветку (`git push origin feature/AmazingFeature`).
5. Откройте Pull Request.

Также можно помочь так:

- Предлагать улучшения для workflow стратегической лени.
- Сообщать о проблемах в скриптах или документации.
- Улучшать воспроизводимость установки для аппаратных/программных сценариев.

## Лицензия

Этот репозиторий распространяется по лицензии GNU General Public License v3.0. См. [LICENSE](../LICENSE).

## Благодарности

Особая благодарность участникам, команде OpenAI и сообществам Raspberry Pi / maker, которые поддерживают эксперименты вокруг низкопороговых систем обучения.

## Контакты

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
