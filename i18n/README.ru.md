[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Note: This repository has been migrated. Active development continues at https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# Искусство лени

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

Репозиторий о стратегической лени для более простой и продуктивной жизни: AI-агенты, изучение языков и влоги с практическими советами и реальными кейсами.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Содержание

- [Обзор](#обзор)
- [Проекты](#проекты)
- [Инструменты автоматизации](#инструменты-автоматизации)
- [Структура папок](#структура-папок)
- [Введение](#введение)
- [Теория лени](#теория-лени)
- [Практические советы и трюки](#практические-советы-и-трюки)
- [Сценарии применения](#сценарии-применения)
- [AI-агенты и автоматизация](#ai-агенты-и-автоматизация)
- [Изучение языков и влоги](#изучение-языков-и-влоги)
- [Вклад сообщества](#вклад-сообщества)
- [Предварительные требования](#предварительные-требования)
- [Установка](#установка)
- [Использование](#использование)
- [Конфигурация](#конфигурация)
- [Примеры](#примеры)
- [Заметки по разработке](#заметки-по-разработке)
- [Устранение неполадок](#устранение-неполадок)
- [Дорожная карта](#дорожная-карта)
- [Вклад в проект](#вклад-в-проект)
- [Поддержка](#поддержка)
- [Лицензия](#лицензия)
- [Благодарности](#благодарности)
- [Контакты](#контакты)

## Быстрые ссылки

| Что нужно | Начать здесь |
|---|---|
| Перейти к главному содержимому | [Обзор](#обзор) |
| Установить зависимости | [Предварительные требования](#предварительные-требования) |
| Запустить примеры | [Использование](#использование) |
| Исправить частые проблемы | [Устранение неполадок](#устранение-неполадок) |
| Принять участие | [Вклад в проект](#вклад-в-проект) |

## Обзор

`the-art-of-lazying-legacy` — это курируемый единый репозиторий вокруг стратегии сознательной лени:

- Концептуальный материал о применении философии «lazying» к работе и жизни.
- Практичные кодовые артефакты, включая обучение языкам на e-ink и GPT (`code/EinkWordsGPT`).
- Полезные скрипты для более безопасных рабочих процессов (`scripts/lazy-care/SafeShell`).
- Инструменты для влогов и фрагменты автоматизации (`vlogs/`).
- Демо-материалы и примеры (`demos/`, `examples/`, `figs/`).

| Snapshot | Value |
|---|---|
| Роль репозитория | Архив-источник и карта идей |
| Активная разработка | https://github.com/lachlanchen/the-art-of-lazying |
| Файлы многоязычных README | `README.md`, `README_CN.md`, `README_EN.md` |
| Каталог i18n | `i18n/` (присутствует) |
| Изучение языков | Интервальные повторы + пайплайны с GPT |
| Фокус автоматизации | Скрипты, субтитры, публикация и аппаратные workflows |

Этот репозиторий остается полезным как архив-источник и карта идей, в то время как активная разработка ведется в перенесённом репозитории по ссылке выше.

---

## Проекты

### 🤖 Креативные инструменты на базе ИИ

| Проект | Описание | Демо |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | e-ink-устройство с обучением словарю на базе GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Анализ происхождения слов и визуализация в виде графа. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Инструменты для эффективного изучения языков с минимальными усилиями | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Автоматическое создание подписей к видео и изображениям с эмбеддингами OpenAI CLIP + декодером GPT | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Инструмент для субтитров: извлечение ключевых кадров с Katna/OpenCV и генерация подписей моделью ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Многоязычный пайплайн транскрипции с детекцией языка | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Устранение языковых барьеров для глобального творческого обмена | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Автоматическая генерация метаданных для видео | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI-инструмент для авторедактирования видео: транскрипция, авто-субтитры, выделение ключевых фрагментов, генерация метаданных | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Упрощение процесса публикации контента | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Автоматизированная система мониторинга, обработки и публикации видео на несколько платформ | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Продвинутые техники эффективной работы с AI-ассистентами | |

## Инструменты автоматизации

В репозитории есть локальные утилиты автоматизации, которые можно запускать сразу:

| Путь | Назначение |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Непрерывный цикл рендеринга карточек слов на e-ink (по умолчанию обновление каждые 300 секунд). |
| `code/EinkWordsGPT/words_update.py` | Пакетное и точечное обновление подробностей слов на основе логики с OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Тестирование e-paper hardware Waveshare 7.3". |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Shell-функции `saferm`, `unrm` и `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Разрешение доменов и дедупликация вывода IP. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Объединение `.py` файлов по подпапкам в `.txt`. |

## Структура папок

### Актуальная структура репозитория

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

### Сохраненная исходная концептуальная структура

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

> Примечание: концептуальная схема выше намеренно сохранена из ранних версий README. Блок «Актуальная структура репозитория» отражает реальную структуру этого legacy-репозитория.

## Введение

The Art of Lazying описывает стратегическую лень как способ экономить энергию и фокусироваться на действительно важном. Этот репозиторий исследует, как сознательная лень может повышать продуктивность, креативность и благополучие.

## Теория лени

Полное введение в принципы стратегической лени с акцентом на то, как повысить продуктивность и качество жизни за счёт приоритизации, делегирования и автоматизации задач.

Ключевой принцип — применение правила Парето 80/20 к повседневной жизни: выделение 20% действий, дающих 80% нужного результата.

## Практические советы и трюки

Набор практических рекомендаций по применению принципов лени в работе, отношениях и уходе за собой:

- Автоматизация повторяющихся задач
- Применение техники Pomodoro для тайм-менеджмента
- Построение систем, снижающих усталость от решений
- Использование AI-инструментов в качестве помощников

## Сценарии применения

Реальные примеры того, как принципы лени помогают решать задачи и повышают эффективность:

- Как предприниматели используют делегирование и автоматизацию для фокуса на росте бизнеса
- Как академики оптимизируют исследовательские процессы
- Как создатели контента улучшают производственный цикл

## AI-агенты и автоматизация

Исследуйте разработку AI-агентов и инструментов автоматизации, которые упрощают работу:

- Использование ChatGPT как личного помощника
- Построение пользовательских автоматизированных workflow
- Создание e-ink дисплеев для пассивного обучения

## Изучение языков и влоги

Материалы и техники для эффективного изучения языков, а также влоги, отражающие путь к «умной лени»:

- Персонализированное обучение с интервальными повторениями
- Реализация иммерсивных методов
- Проекты, поддерживающие пассивное обучение

## Вклад сообщества

Делитесь собственным опытом, советами и идеями по стратегической лени:

- Форум обмена практиками продуктивности
- Инструменты и шаблоны для повседневных рутин
- Совместные проекты для «ленивой» эффективности

## Предварительные требования

В репозитории есть несколько независимых скриптов, поэтому требования зависят от конкретного модуля.

Общий базовый набор:

- Python 3.9+
- `pip`
- Git

Проектные зависимости из исходников:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (для e-paper-процессов)
- `sqlite3` (стандартная библиотека)

Аппаратные требования для полного запуска `EinkWordsGPT`:

- Raspberry Pi (в документации упоминается Raspberry Pi 5)
- Цветной e-ink-панель Waveshare 7.3" (7 цветов)

## Установка

Поскольку единый манифест зависимостей отсутствует, зависимости устанавливаются вручную для того модуля, который вы собираетесь запускать.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Дополнительно/для аппаратной части:

```bash
# Требуется для скриптов EinkWordsGPT на поддерживаемом железе
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

### 2) Повторная проверка и обновление деталей слова

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Тест панели Waveshare 7.3"

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Разрешение доменов ChatGPT и вывод IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Объединение Python-файлов по папкам для AI-дружественных текстовых пакетов

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Безопасный рабочий процесс удаления файлов

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Конфигурация

### OpenAI Credentials

`EinkWordsGPT` и скрипты обновления используют `OpenAI()` из официального SDK и ожидают, что учётные данные настроены в окружении.

Рекомендуемое предположение:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Расположение базы данных

`code/EinkWordsGPT/words_gpt.py` и `words_update.py` используют:

- `db_path = 'words_phonetics.db'`

Запускайте скрипты из `code/EinkWordsGPT` или измените пути при запуске из другого места.

### Корень корзины SafeShell

`saferm`/`unrm`/`removeitanyway` пока используют фиксированный базовый путь:

- `/mnt/disk/BIN/ROOT`

Перед тем как использовать `saferm`, убедитесь, что этот путь существует и доступен для записи.

### Пути Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` сейчас использует жёстко заданные пути:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Отредактируйте эти константы под структуру вашего локального проекта.

## Примеры

### Пример: цикл учебной карточки на e-ink

- Скрипт выбирает (или получает) детали слова.
- На карточке отображаются фонетика, разбиение на слоги и подсказки японских синонимов.
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

## Заметки по разработке

- Это legacy-репозиторий; активная разработка ведётся в: https://github.com/lachlanchen/the-art-of-lazying
- Контент верхнего уровня носит кураторский характер и ссылается на множество внешних репозиториев.
- `i18n/` уже существует, но пока пуст; многоязычные README сейчас находятся в корне.
- В корне отсутствуют `requirements.txt` и `pyproject.toml`.

Сохраненная заметка о совместимости:

- Более ранние docs в подпапках могут упоминать скрипты (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`), которые сейчас сведены в `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Устранение неполадок

- `ModuleNotFoundError`: установите отсутствующие пакеты Python из раздела [Предварительные требования](#предварительные-требования).
- Ошибки аутентификации `openai`: проверьте, что `OPENAI_API_KEY` экспортирован в вашей оболочке.
- Проблемы выполнения Waveshare: проверьте настройку SPI/устройства и установите зависимости вендора на Raspberry Pi.
- `saferm` не работает как ожидается: проверьте, что `/mnt/disk/BIN/ROOT` существует и доступен для записи.
- `repo2text` не создаёт файеты: убедитесь, что `source_directory` указывает на существующую папку с `.py` файлами.
- Аномалии доменов в `chatgpt-traffic`: проверьте и почистите список `domains` в скрипте перед использованием в production.

## Дорожная карта

- Сохранить репозиторий как стабильный legacy-архив с понятными ссылками на актуальные проекты.
- Улучшить manifests зависимостей для каждого запускаемого подмодуля.
- Добавить единый i18n-лейаут в `/i18n` в будущих версиях.
- Расширить практические примеры и воспроизводимые руководства по настройке для hardware и non-hardware сценариев.

## Вклад в проект

Вклад приветствуется.

1. Сделайте fork проекта.
2. Создайте ветку для вашей фичи (`git checkout -b feature/AmazingFeature`).
3. Зафиксируйте изменения (`git commit -m 'Add some AmazingFeature'`).
4. Отправьте ветку (`git push origin feature/AmazingFeature`).
5. Откройте Pull Request.

Также можно внести вклад через:

- Предложение улучшений для стратегических workflows
- Сообщение о проблемах в скриптах или документации
- Улучшение воспроизводимости установки для железных и безжелезных сценариев

<a id="поддержка"></a>
## Лицензия

Этот репозиторий распространяется по лицензии GNU General Public License v3.0. См. [LICENSE](../LICENSE).

## Благодарности

Особая благодарность участникам, команде OpenAI и сообществам Raspberry Pi / maker, которые поддерживают эксперименты с низкопороговыми системами обучения.

## Контакты

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
