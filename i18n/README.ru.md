[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner — apps and four buddies](https://lazying.art/media/brand/lazyingart-intro.gif)](https://lazying.art)

# Искусство лени

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](../LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

Репозиторий, ориентированный на стратегическую лень для более простого и более эффективного образа жизни, охватывающий AI-агентов, изучение языков, практическую автоматизацию и рабочие процессы на основе влогов.

| Фокус | Что содержит этот README |
|---|---|
| 🤖 Автоматизация | Основные инструменты, скрипты и практические потоки, которые можно запускать локально |
| 🧠 Обучение | Языко-ориентированные проекты и примеры для эффективного обучения |
| 📚 Обмен | Многоязычная документация, ссылки на проекты и руководство по участию |

![Демо EinkWordsGPT](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Оглавление

- [Обзор](#обзор)
- [Проекты](#проекты)
- [Структура репозитория](#структура-репозитория)
- [Возможности](#возможности)
- [Требования](#требования)
- [Установка](#установка)
- [Использование](#использование)
- [Настройка](#настройка)
- [Примеры](#примеры)
- [Заметки по разработке](#заметки-по-разработке)
- [Устранение неполадок](#устранение-неполадок)
- [Дорожная карта](#дорожная-карта)
- [Введение](#введение)
- [Теория лени](#теория-лени)
- [Практические советы и приемы](#практические-советы-и-приемы)
- [Сценарии применения](#сценарии-применения)
- [AI-агенты и автоматизация](#ai-агенты-и-автоматизация)
- [Изучение языков и влоги](#изучение-языков-и-влоги)
- [Вклад сообщества](#вклад-сообщества)
- [❤️ Support](#-support)
- [Контакты](#контакты)
- [Участие](#участие)
- [Лицензия](#лицензия)

## Обзор

`the-art-of-lazying` — это репозиторий-центр практической стратегической лени: автоматизировать рутинную работу, улучшить рабочие процессы изучения языков и документировать реальные эксперименты через скрипты и влоги.

| Вкратце | Детали |
|---|---|
| 🎯 Основная тема | Стратегическая лень для продуктивности, обучения и творческого процесса |
| 🧩 Формат репозитория | Гибрид локальных инструментов и тщательно отобранных внешних проектов |
| 🛠️ Локальные акценты | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Документация | Корневой README + многоязычные варианты в `i18n/` |

В этом репозитории есть и то, и другое:
- Курируемые ссылки на связанные внешние проекты.
- Локальные инструменты и код, особенно:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + дисплей для запоминания слов с OpenAI).
  - `scripts/lazy-care/SafeShell` (безопасные shell-функции для удаления и восстановления).
  - `vlogs/chatgpt-traffic` и `vlogs/repo2text` (небольшие утилиты на Python).

## Проекты

### 🚀 AI-инструменты для творчества

| Проект | Описание | Демо |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Дисплей e-ink с обучением слов с GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Анализ происхождения слов и их представление в графе. | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Инструменты для эффективного изучения языков с минимальными усилиями | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Распознавание и описание видео и изображений с эмбеддингами OpenAI CLIP + GPT-декодер | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Инструмент для субтитров видео: извлечение ключевых кадров с Katna/OpenCV и генерация субтитров моделью ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Многоязычный конвейер транскрипции с детекцией языка с высокой детализацией | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Снятие языковых барьеров для глобального творческого обмена | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Автоматическая генерация метаданных для видео | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI-инструмент автоматического редактирования видео с транскрипцией, автосубтитрами, подсветкой и генерацией метаданных | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Оптимизация рабочих процессов публикации контента | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Автоматическая система мониторинга, обработки и публикации видео-контента на нескольких платформах | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Продвинутые техники эффективного использования AI-ассистентов | |

### ⚙️ Инструменты автоматизации (локально в этом репозитории)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: более безопасное удаление в shell (`saferm`), восстановление (`unrm`) и явное постоянное удаление (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: определение домена по IP и генератор дедуплицированных результатов.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: объединяет файлы Python по каталогам в текстовые наборы для анализа с помощью AI.

## Структура репозитория

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

Примечание: В старых версиях README упоминались более абстрактные структуры каталогов (например, `book/`, `code/ai-agents/`), которые не совсем совпадают с текущей структурой репозитория. Приведенная выше схема отражает текущее содержимое.

## Возможности

- Стратегическая модель лени для продуктивности, обучения и контентных процессов.
- Отобранный портфель AI-проектов, охватывающий транскрипцию, субтитрирование, перевод и автоматизацию публикации.
- Интеграция с оборудованием для изучения языков с выбором слов при помощи GPT (`EinkWordsGPT`).
- Практичные средства shell для безопасных операций удаления и восстановления.
- Утилиты в стиле «скрипт-первый» для DNS/проверок доменной маршрутизации и конвертации репозитория в текст.
- Многоязычная документация через `i18n/`.

## Требования

Общие:
- Git
- Python 3.9+ (рекомендуется)

Для `code/EinkWordsGPT`:
- Raspberry Pi (в документах проекта указана Raspberry Pi 5)
- Экран Waveshare e-ink 7,3 дюйма, 7-цветный, с поддержкой Python-драйвера (`waveshare_epd`)
- Python-пакеты, используемые в коде: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (используется стандартная библиотека Python `sqlite3`)
- Ключ OpenAI API, заданный в окружении (код напрямую инициализирует `OpenAI()`)

Для `vlogs/chatgpt-traffic`:
- `dnspython`

Для `scripts/lazy-care/SafeShell`:
- Bash или Zsh с доступом к `realpath`, `mv` и `/bin/rm`

## Установка

Клонируйте репозиторий:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Установите общие Python-зависимости (базовые для всего репозитория):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Примечание: в `code/EinkWordsGPT/README.md` упоминается `requirements.txt`, однако в текущем репозитории отсутствует `requirements.txt`. Установите зависимости вручную, как показано выше.

## Использование

### 1) EinkWordsGPT (локальный поток для аппаратной части)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # опциональная проверка оборудования/экрана
python words_gpt.py        # запуск цикла обновления экрана (примерно каждые 300 сек)
```

Скрипт для обслуживания базы данных (по желанию):

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (безопасный поток удаления)

Загрузите shell-функции:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # или ~/.zshrc
source ~/.bashrc                          # или source ~/.zshrc
```

Используйте команды:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Разрешение трафика ChatGPT

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Объединение репозитория в текст

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Примечание: `convert-repo-to-merged-text.py` сейчас использует жёстко заданные пути (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Измените эти константы перед запуском для другого репозитория.

## Настройка

### Конфигурация OpenAI (`code/EinkWordsGPT`)

Клиент создается так:

```python
client = OpenAI()
```

Поэтому настройте учетные данные API стандартным способом через переменные окружения OpenAI перед запуском скриптов.

### Путь к базе данных (`code/EinkWordsGPT`)

Значение по умолчанию в коде:

```python
db_path = 'words_phonetics.db'
```

Убедитесь, что `words_phonetics.db` существует в `code/EinkWordsGPT/` (сейчас файл уже включен в репозиторий).

### Расположение корзины SafeShell

`saferm`/`unrm`/`removeitanyway` используют фиксированный базовый путь:

```bash
/mnt/disk/BIN/ROOT
```

При необходимости измените этот путь в `scripts/lazy-care/SafeShell/safeshell_functions.sh` под свою среду.

## Примеры

- Демо карт слов на e-ink в `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Заметки и материалы по сборке ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Заметки по разработке

- Это репозиторий-сборник с несколькими проектами и сочетанием локального кода и ссылок на внешние проекты.
- На корне пока нет пакета/менеджера зависимостей или манифеста сборки (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` отсутствуют).
- Несколько сабредми файлов в репозитории выглядят как шаблоны и могут быть частично устаревшими по сравнению с текущей структурой файлов; команды в этом README согласованы с реально существующими путями и скриптами.
- `README_EN.md` и `README_CN.md` существуют как устаревшие версии; активная мультиязычная структура — `README.md` + `i18n/*`.

## Устранение неполадок

- `ModuleNotFoundError` для пакетов Python:
  - Переустановите зависимости командой `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` в `EinkWordsGPT`:
  - Установите драйвер/библиотеку e-paper Waveshare в среде Raspberry Pi.

- Ошибки аутентификации OpenAI:
  - Проверьте, что ключ API OpenAI задан в переменных окружения, прежде чем запускать `words_gpt.py` или `words_update.py`.

- `saferm`/`unrm` не найдены после настройки:
  - Убедитесь, что вы загрузили нужный rc-файл оболочки и успешно добавили `safeshell_functions.sh`.

- `unrm` не может восстановить файлы:
  - Проверьте, что путь восстановления соответствует структуре зеркала корзины SafeShell в `/mnt/disk/BIN/ROOT`.

- `repo2text` не выдает результат:
  - Измените `source_directory` в `convert-repo-to-merged-text.py` на существующий каталог.

## Дорожная карта

- Расширить совпадение основного README во всех i18n-файлах (сейчас в многих языках есть только краткие версии).
- Добавить документацию по настройке в зависимости от окружения для драйверов Waveshare e-ink.
- Добавить воспроизводимые манифесты зависимостей на уровне корня для локальных инструментов.
- Добавить скрипты валидации и тестирования для критичных утилит.
- Продолжать консолидацию ссылок на внешние проекты с более богатыми локальными демо.

## Введение

`The Art of Lazying` представляет стратегическую лень как способ оптимизировать расход энергии и сосредоточиться на действительно важном. Этот репозиторий исследует, как намеренная лень может приводить к более высокой продуктивности, креативности и благополучию.

## Теория лени

Полное введение в принципы стратегической лени, сосредоточенное на том, как повысить продуктивность и благополучие через приоритизацию, делегирование и автоматизацию задач.

Ключевой принцип — применение правила Парето 80/20 к повседневной жизни: выделение 20% активностей, которые дают 80% желаемого результата.

## Практические советы и приемы

Набор практических рекомендаций по применению принципов лени в работе, отношениях и заботе о себе:
- Автоматизация повторяющихся задач
- Метод Pomodoro для управления временем
- Построение систем, уменьшающих усталость от выбора
- Использование AI-инструментов для помощи

## Сценарии применения

Реальные примеры того, как принципы лени помогают решать задачи и повышать эффективность:
- Как предприниматели используют делегирование и автоматизацию для фокуса на росте бизнеса
- Как исследователи оптимизируют рабочие процессы
- Как создатели контента оптимизируют процесс производства

## AI-агенты и автоматизация

Здесь рассматривается разработка AI-агентов и инструментов автоматизации, которые упрощают задачи:
- Использование ChatGPT как личного помощника
- Создание собственных рабочих процессов автоматизации
- Создание e-ink дисплеев для пассивного обучения

## Изучение языков и влоги

Ресурсы и техники для эффективного изучения языков, а также влоги, документирующие путь в лени:
- Создание персонализированного изучения языков с интервальным повторением
- Применение техник погружения
- Создание проектов, поощряющих пассивное обучение

## Вклад сообщества

Делитесь своим опытом, советами и идеями по стратегической лени:
- Площадка для обмена трюками по продуктивности
- Инструменты и шаблоны для ежедневных рутинов
- Совместные проекты для «ленивой» эффективности

## Контакты

- Сайт: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

## Участие

Вклад приветствуется в коде, документации, примерах и переводах.

1. Сделайте fork репозитория.
2. Создайте ветку (`git checkout -b feature/your-feature`).
3. Вносим изменения с понятными сообщениями коммитов.
4. Откройте Pull Request с описанием мотивации и влияния.

Если не знаете, с чего начать:
- Улучшайте документацию по настройке локального инструмента.
- Добавляйте тесты или скрипты валидации для существующих утилит.
- Улучшайте полноту и качество `i18n/README.*.md`.

## Лицензия

В этом репозитории лежит текст лицензии GPLv3 в корне (`../LICENSE`) и в нескольких подпапках.

Примечание: В некоторых README подгрупп указана MIT. Пока лицензии каждого подпроекта не уточнены, считаете корневой репозиторий под GPLv3 и проверяйте лицензии субпроектов, если планируете самостоятельное распространение кода.


## ❤️ Support

<!-- support:start -->
[![GitHub Sponsors](https://img.shields.io/badge/GitHub-Sponsors-EA4AAA?style=for-the-badge&logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![LazyingArt Support](https://img.shields.io/badge/LazyingArt-Support-0EA5E9?style=for-the-badge)](https://chat.lazying.art/donate)
[![PayPal Support](https://img.shields.io/badge/PayPal-Support-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/RongzhouChen)
[![Stripe Support](https://img.shields.io/badge/Stripe-Support-635BFF?style=for-the-badge&logo=stripe&logoColor=white)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400)
<!-- support:end -->
