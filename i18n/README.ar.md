[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> ملاحظة: تم ترحيل هذا المستودع. التطوير النشط مستمر على https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# فن الكسلنة

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

مستودع يروّج لفلسفة الكسل الاستراتيجي من أجل حياة أبسط وأكثر إنتاجية، ويغطي وكلاء الذكاء الاصطناعي، وتعلّم اللغات، وفلوغات تتضمن نصائح عملية وحالات استخدام واقعية.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## فهرس المحتويات

- [نظرة عامة](#overview)
- [المشاريع](#projects)
- [أدوات الأتمتة](#automation-tools)
- [بنية المجلدات](#folder-structure)
- [مقدمة](#introduction)
- [نظرية الكسلنة](#the-theory-of-lazying)
- [نصائح وحيل عملية](#practical-tips-and-tricks)
- [حالات الاستخدام](#use-cases)
- [وكلاء الذكاء الاصطناعي والأتمتة](#ai-agents-and-automation)
- [تعلّم اللغات والفلوغات](#language-learning-and-vlogs)
- [مساهمات المجتمع](#community-contributions)
- [المتطلبات المسبقة](#prerequisites)
- [التثبيت](#installation)
- [الاستخدام](#usage)
- [الإعداد](#configuration)
- [أمثلة](#examples)
- [ملاحظات التطوير](#development-notes)
- [استكشاف الأخطاء وإصلاحها](#troubleshooting)
- [خارطة الطريق](#roadmap)
- [المساهمة](#contributing)
- [الترخيص](#license)
- [الشكر والتقدير](#acknowledgments)
- [التواصل](#connect)

<a id="overview"></a>

## نظرة عامة

`the-art-of-lazying-legacy` هو مستودع شمولي مُنتقى حول مفهوم الكسل الاستراتيجي:

- محتوى مفاهيمي حول تطبيق فلسفة "lazying" في العمل والحياة.
- مكونات برمجية عملية، تشمل تعلّم اللغات عبر الحبر الإلكتروني + GPT (`code/EinkWordsGPT`).
- سكربتات أدوات لسير عمل أكثر أمانًا (`scripts/lazy-care/SafeShell`).
- أدوات ومقتطفات أتمتة خاصة بالفلوغات (`vlogs/`).
- مواد عرض وأمثلة (`demos/`, `examples/`, `figs/`).

| لقطة سريعة | القيمة |
|---|---|
| دور المستودع | أرشيف قديم + خريطة أفكار |
| التطوير النشط | https://github.com/lachlanchen/the-art-of-lazying |
| ملفات README متعددة اللغات | `README.md`, `README_CN.md`, `README_EN.md` |
| مجلد i18n | `i18n/` (موجود) |

لا يزال هذا المستودع مفيدًا كأرشيف قديم وخريطة أفكار، بينما انتقل التطوير النشط إلى المستودع المُرحّل المشار إليه أعلاه.

<a id="projects"></a>

## المشاريع

### 🤖 أدوات إبداعية مدعومة بالذكاء الاصطناعي

| المشروع | الوصف | العرض |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | شاشة حبر إلكتروني لتعلّم الكلمات مدعومة بـ GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | تحليل أصول الكلمات وعرضها على شكل رسم بياني. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | أدوات لتعلّم اللغات بكفاءة وبأقل مجهود | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | عنونة الفيديو والصور باستخدام OpenAI CLIP embeddings + GPT decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | أداة لوصف الفيديو: استخراج الإطارات الأساسية عبر Katna/OpenCV وتوليد الأوصاف بنموذج ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | خط معالجة تفريغ صوتي متعدد اللغات مع كشف لغوي دقيق | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | كسر حواجز اللغة للتبادل الإبداعي العالمي | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | توليد تلقائي للبيانات الوصفية للفيديوهات | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | أداة تحرير فيديو تلقائي مدعومة بالذكاء الاصطناعي مع التفريغ، والترجمة النصية التلقائية، وإبراز المقاطع، وتوليد البيانات الوصفية | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | تبسيط سير عمل نشر المحتوى | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | نظام آلي لمراقبة ومعالجة ونشر محتوى الفيديو على منصات متعددة | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | تقنيات متقدمة للاستخدام الفعّال لمساعدي الذكاء الاصطناعي | |

<a id="automation-tools"></a>

## أدوات الأتمتة

يتضمن المستودع أدوات أتمتة محلية قابلة للتشغيل مباشرة:

| المسار | الغرض |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | حلقة مستمرة لعرض بطاقات الكلمات على شاشة الحبر الإلكتروني (التحديث الافتراضي كل 300 ثانية). |
| `code/EinkWordsGPT/words_update.py` | تحديث دفعي وموجّه لتفاصيل الكلمات باستخدام منطق مدعوم بـ OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | اختبار عتاد شاشة Waveshare قياس 7.3 بوصة. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | دوال shell: `saferm` و`unrm` و`removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | تحليل نطاقات إلى عناوين IP مع إزالة التكرار في المخرجات. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | دمج ملفات `.py` حسب المجلد الفرعي في ملفات `.txt`. |

<a id="folder-structure"></a>

## بنية المجلدات

### بنية المستودع الحالية (دقيقة)

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

### البنية المفاهيمية الأصلية (محفوظة)

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

> ملاحظة: الخريطة المفاهيمية أعلاه محفوظة عمدًا من إصدارات README السابقة. كتلة "بنية المستودع الحالية" تعكس الشجرة الفعلية في هذا المستودع القديم.

<a id="introduction"></a>

## مقدمة

يقدّم "فن الكسلنة" الكسل الاستراتيجي كأسلوب لتحسين استهلاك الطاقة والتركيز على ما يهم فعلًا. يستكشف هذا المستودع كيف يمكن للكسل المقصود أن يؤدي إلى إنتاجية أعلى، وإبداع أكبر، ورفاه أفضل.

<a id="the-theory-of-lazying"></a>

## نظرية الكسلنة

مقدمة شاملة لمبادئ الكسل الاستراتيجي، مع تركيز على تعظيم الإنتاجية والرفاه عبر ترتيب الأولويات، والتفويض، وأتمتة المهام.

المبدأ الأساسي هو تطبيق قاعدة باريتو 80/20 على الحياة اليومية: تحديد 20% من الأنشطة التي تنتج 80% من النتائج المطلوبة.

<a id="practical-tips-and-tricks"></a>

## نصائح وحيل عملية

مجموعة من النصائح القابلة للتطبيق حول توظيف مبادئ الكسلنة في العمل والعلاقات والعناية الذاتية:

- أتمتة المهام المتكررة
- استخدام تقنية بومودورو لإدارة الوقت
- بناء أنظمة تقلل إرهاق اتخاذ القرار
- الاستفادة من أدوات الذكاء الاصطناعي للمساعدة

<a id="use-cases"></a>

## حالات الاستخدام

أمثلة واقعية توضّح كيف تحل مبادئ الكسلنة المشكلات وتحسّن الكفاءة:

- كيف يستخدم رواد الأعمال التفويض والأتمتة للتركيز على نمو الأعمال
- كيف يبسّط الأكاديميون سير عمل البحث
- كيف يحسّن صناع المحتوى عملية الإنتاج لديهم

<a id="ai-agents-and-automation"></a>

## وكلاء الذكاء الاصطناعي والأتمتة

استكشف تطوير وكلاء الذكاء الاصطناعي وأدوات الأتمتة التي تبسّط المهام:

- استخدام ChatGPT كمساعد شخصي
- بناء سير عمل أتمتة مخصص
- إنشاء شاشات حبر إلكتروني للتعلّم السلبي

<a id="language-learning-and-vlogs"></a>

## تعلّم اللغات والفلوغات

موارد وتقنيات لتعلّم لغات بكفاءة، إضافة إلى فلوغات توثّق رحلة الكسلنة:

- إنشاء تعلّم لغوي مخصص باستخدام التكرار المتباعد
- تطبيق تقنيات التعلّم الغامر
- بناء مشاريع تشجع التعلّم السلبي

<a id="community-contributions"></a>

## مساهمات المجتمع

شارك تجاربك ونصائحك وأفكارك حول الكسل الاستراتيجي:

- مساحة لتبادل حيل الإنتاجية
- أدوات وقوالب للروتين اليومي
- مشاريع تعاونية لكفاءة أعلى بجهد أقل

<a id="prerequisites"></a>

## المتطلبات المسبقة

يحتوي المستودع على عدة سكربتات مستقلة، لذلك تختلف المتطلبات حسب كل وحدة.

خط أساس شائع:

- Python 3.9+
- `pip`
- Git

إشارات خاصة بكل مشروع من ملفات المصدر:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (لتدفقات عتاد الحبر الإلكتروني)
- `sqlite3` (مكتبة قياسية)

متطلبات العتاد لتشغيل `EinkWordsGPT` كاملًا:

- Raspberry Pi (توثيق المشروع يذكر Raspberry Pi 5)
- لوحة Waveshare حبر إلكتروني 7 ألوان بمقاس 7.3 بوصة

<a id="installation"></a>

## التثبيت

نظرًا لعدم وجود ملف تبعيات موحّد في الجذر، ثبّت التبعيات يدويًا للوحدة التي تريد تشغيلها.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

اعتماد اختياري/خاص بالعتاد:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

إعداد SafeShell:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

<a id="usage"></a>

## الاستخدام

### 1) تشغيل حلقة عرض EinkWordsGPT

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) إعادة فحص/تحديث تفاصيل الكلمات

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) اختبار لوحة Waveshare قياس 7.3 بوصة

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) تحليل نطاقات مرتبطة بـ ChatGPT وإخراج عناوين IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) دمج ملفات Python حسب المجلد لإنتاج حزم نصية مناسبة للذكاء الاصطناعي

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) استخدام سير عمل أكثر أمانًا لحذف الملفات

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

<a id="configuration"></a>

## الإعداد

### بيانات اعتماد OpenAI

تستخدم `EinkWordsGPT` وسكربتات التحديث `OpenAI()` من الحزمة الرسمية، وتتوقع ضبط بيانات الاعتماد في البيئة لديك.

افتراض (موصى به):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### موقع قاعدة البيانات

تستخدم `code/EinkWordsGPT/words_gpt.py` و`words_update.py`:

- `db_path = 'words_phonetics.db'`

شغّل السكربتات من `code/EinkWordsGPT` أو حدّث المسارات إذا كنت ستشغّلها من مكان آخر.

### مسار سلة المهملات الأساسي لـ SafeShell

تستخدم `saferm`/`unrm`/`removeitanyway` حاليًا مسارًا أساسيًا ثابتًا:

- `/mnt/disk/BIN/ROOT`

تأكد من وجود هذا المسار وإمكانية الكتابة إليه قبل الاعتماد على `saferm`.

### مسارات Repo2Text

يحتوي `vlogs/repo2text/convert-repo-to-merged-text.py` حاليًا على مسارات مُضمّنة بشكل ثابت:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

عدّل هذه الثوابت بما يناسب مشروعك المحلي.

<a id="examples"></a>

## أمثلة

### مثال: دورة بطاقة تعلّم على شاشة الحبر الإلكتروني

- يختار السكربت تفاصيل الكلمة (أو يجلبها).
- تُعرض البطاقة مع النطق، وتجزئة المقاطع، وتلميحات مرادفات يابانية.
- تتحدّث الشاشة كل 5 دقائق (`time.sleep(300)`).

### مثال: سير عمل حذف آمن

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### مثال: ملف مخرجات النطاق/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

<a id="development-notes"></a>

## ملاحظات التطوير

- هذا مستودع قديم (legacy)؛ التطوير النشط هنا: https://github.com/lachlanchen/the-art-of-lazying
- المحتوى في المستوى الأعلى تجميعي ويشير إلى مستودعات خارجية عديدة.
- المجلد `i18n/` موجود لكنه فارغ حاليًا؛ ملفات README متعددة اللغات موجودة حاليًا في المستوى الأعلى.
- لا يوجد `requirements.txt` أو `pyproject.toml` في الجذر.

ملاحظة توافق محفوظة:

- قد تشير وثائق أقدم داخل المجلدات الفرعية إلى سكربتات (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) جرى دمجها الآن في `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

<a id="troubleshooting"></a>

## استكشاف الأخطاء وإصلاحها

- `ModuleNotFoundError`: ثبّت حزم Python الناقصة المذكورة في [المتطلبات المسبقة](#prerequisites).
- أخطاء توثيق `openai`: تأكد من تصدير `OPENAI_API_KEY` في بيئة shell.
- مشاكل تشغيل Waveshare: تحقق من إعداد SPI/الجهاز وثبّت تبعيات المورّد على Raspberry Pi.
- إذا بدا أن `saferm` لا يفعل شيئًا: افحص أن `/mnt/disk/BIN/ROOT` موجود ويملك صلاحيات كتابة.
- إذا لم يُنشئ `repo2text` ملفات: تأكد أن `source_directory` يشير إلى مجلد موجود يحتوي ملفات `.py`.
- شذوذات نطاقات `chatgpt-traffic`: راجع ونظّف قائمة `domains` في السكربت قبل الاستخدام الإنتاجي.

<a id="roadmap"></a>

## خارطة الطريق

- الإبقاء على هذا المستودع كأرشيف legacy مستقر مع مؤشرات واضحة إلى المشاريع النشطة.
- تحسين ملفات إدارة التبعيات لكل وحدة فرعية قابلة للتشغيل.
- إضافة تنظيم i18n متسق تحت `/i18n` في المراجعات القادمة.
- توسيع الأمثلة العملية وأدلة الإعداد القابلة لإعادة الإنتاج لسيناريوهات العتاد وغير العتاد.

<a id="contributing"></a>

## المساهمة

المساهمات مرحب بها.

1. اعمل Fork للمشروع.
2. أنشئ فرع الميزة (`git checkout -b feature/AmazingFeature`).
3. نفّذ commit لتغييراتك (`git commit -m 'Add some AmazingFeature'`).
4. ادفع الفرع إلى remote (`git push origin feature/AmazingFeature`).
5. افتح Pull Request.

يمكنك أيضًا المساهمة عبر:

- اقتراح تحسينات لسير عمل الكسل الاستراتيجي.
- الإبلاغ عن المشكلات في السكربتات أو التوثيق.
- تحسين قابلية إعادة إنتاج الإعداد لمسارات العتاد والبرمجيات.

<a id="license"></a>

## الترخيص

هذا المستودع مرخّص بموجب GNU General Public License v3.0. راجع [LICENSE](LICENSE).

<a id="acknowledgments"></a>

## الشكر والتقدير

شكر خاص للمساهمين، وفريق OpenAI، ومجتمعات Raspberry Pi والمطورين الصنّاع التي تدعم التجريب في أنظمة التعلّم منخفضة الاحتكاك.

<a id="connect"></a>

## التواصل

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
