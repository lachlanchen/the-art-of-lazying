[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> ملاحظة: تم ترحيل هذا المستودع. لا يزال التطوير النشط مستمراً في https://github.com/lachlanchen/the-art-of-lazying

# فن الكسل الذكي

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

مستودع يروّج لفلسفة الكسل الاستراتيجي بهدف تبسيط الحياة وزيادة الإنتاجية، ويمتد ليغطي وكلاء الذكاء الاصطناعي وتعلم اللغات والفيديو اليومي عبر نصائح عملية وحالات استخدام واقعية.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## جدول المحتويات

- [نظرة عامة](#overview)
- [المشاريع](#projects)
- [أدوات الأتمتة](#automation-tools)
- [هيكل المجلدات](#folder-structure)
- [مقدمة](#introduction)
- [نظرية الكسل](#the-theory-of-lazying)
- [نصائح وحيل عملية](#practical-tips-and-tricks)
- [حالات الاستخدام](#use-cases)
- [وكلاء الذكاء الاصطناعي والأتمتة](#ai-agents-and-automation)
- [تعلم اللغات والفيديوهات](#language-learning-and-vlogs)
- [مساهمات المجتمع](#community-contributions)
- [المتطلبات الأساسية](#prerequisites)
- [التثبيت](#installation)
- [الاستخدام](#usage)
- [الإعداد](#configuration)
- [أمثلة](#examples)
- [ملاحظات التطوير](#development-notes)
- [استكشاف الأخطاء](#troubleshooting)
- [خريطة الطريق](#roadmap)
- [المساهمة](#contributing)
- [الترخيص](#license)
- [شكر وتقدير](#acknowledgments)
- [التواصل](#connect)

## روابط سريعة

| الحاجة | ابدأ هنا |
|---|---|
| تصفح خريطة المحتوى الأساسية | [نظرة عامة](#overview) |
| تثبيت المتطلبات | [المتطلبات الأساسية](#prerequisites) |
| تشغيل الأمثلة | [الاستخدام](#usage) |
| حل المشاكل الشائعة | [استكشاف الأخطاء](#troubleshooting) |
| المساهمة | [المساهمة](#contributing) |

<a id="overview"></a>
## نظرة عامة

`the-art-of-lazying-legacy` هو مستودع توسيعي منظم حول الكسل الاستراتيجي:

- محتوى مفاهيمي حول تطبيق فلسفة "الكسل" على العمل والحياة.
- عناصر برمجية عملية، بما في ذلك تعلم الكلمات بلغة e-ink + GPT (`code/EinkWordsGPT`).
- سكربتات أدوات لسيناريوهات عمل أكثر أمانًا (`scripts/lazy-care/SafeShell`).
- أدوات جانبية لإنتاج الفيديوهات الآلية والمقتطفات الخاصة بالڤلوجات (`vlogs/`).
- عناصر عرض وتجارب (`demos/`، `examples/`، `figs/`).

| Snapshot | القيمة |
|---|---|
| دور المستودع | أرشيف تراثي + خريطة أفكار |
| التطوير النشط | https://github.com/lachlanchen/the-art-of-lazying |
| ملفات README متعددة اللغات | `README.md`, `README_CN.md`, `README_EN.md` |
| دليل i18n | `i18n/` (موجود) |
| تعلم اللغات | التكرار المتباعد + تدفقات عمل GPT |
| تركيز الأتمتة | السكربتات، الترجمة التلقائية، النشر، وسير عمل العتاد |

يظل هذا المستودع مفيدًا كأرشيف تراثي وخريطة أفكار، بينما نُقل التطوير النشط إلى المستودع المهاجر المذكور أعلاه.

---

<a id="projects"></a>
## المشاريع

### 🤖 أدوات إبداعية مدعومة بالذكاء الاصطناعي

| المشروع | الوصف | العرض |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | شاشة e-ink مع تعلم كلمات مدعوم بـ GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | تحليل أصول الكلمات وعرضها في شكل رسومي. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | أدوات لتعلم لغة فعّال بأقل جهد | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | توليد التسميات التوضيحية للصورة والفيديو باستخدام تمثيلات OpenAI CLIP + فك شفرة GPT | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | أداة تفريغ فيديو: استخراج الإطارات الأساسية باستخدام Katna/OpenCV وتوليد التسميات بتجميع ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | خط أنابيب تفريغ متعدد اللغات مع كشف دقيق للغة | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | كسر حواجز اللغة لتبادل إبداعي عالمي | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | توليد أوتوماتيكي لبيانات وصفية للفيديوهات | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | أداة تحرير فيديو ذكية مع التفريغ، الترجمة التلقائية، إبراز المقاطع، وتوليد البيانات الوصفية | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | تبسيط سير نشر المحتوى | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | نظام آلي لمراقبة ومعالجة ونشر المحتوى المرئي عبر منصات متعددة | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | تقنيات متقدمة لاستخدام المساعدات الذكية بفعالية | |

<a id="automation-tools"></a>
## أدوات الأتمتة

المستودع يحتوي على أدوات أتمتة قابلة للتشغيل محليًا مباشرة:

| المسار | الهدف |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | حلقة مستمرة لعرض بطاقات الكلمات على e-ink (تحديث افتراضي كل 300 ثانية). |
| `code/EinkWordsGPT/words_update.py` | تحديث دفعي أو مستهدف لتفاصيل الكلمات اعتمادًا على منطق مدعوم بـ OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | اختبار عتاد e-paper من Waveshare بحجم 7.3 بوصة. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | دوال Shell: `saferm`، `unrm`، و`removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | حل أسماء النطاق إلى IP مع مخرجات مكررة إزالة التكرار. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | دمج ملفات `.py` حسب المجلد الفرعي إلى ملفات `.txt`. |

<a id="folder-structure"></a>
## هيكل المجلدات

### البنية الحالية للمستودع (دقيقة)

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
├── i18n/                      # موجود الآن
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

> ملاحظة: الخريطة المفاهيمية أعلاه محفوظة عمدًا من إصدارات README السابقة. ويعكس قسم "البنية الحالية للمستودع" الشجرة الفعلية لهذا المستودع القديم.

<a id="introduction"></a>
## المقدمة

يرى "فن الكسل" الكسل الاستراتيجي كطريقة لتحسين استخدام الطاقة والتركيز على ما يهم فعلاً. يستكشف هذا المستودع كيف يمكن أن يقود الكسل المقصود إلى إنتاجية أعلى وإبداع ورفاهية أفضل.

<a id="the-theory-of-lazying"></a>
## نظرية الكسل

مقدمة شاملة لمبادئ الكسل الاستراتيجي، تركز على كيفية رفع الإنتاجية والرفاهية عبر الأولويات، التفويض، والأتمتة.

المبدأ الأساسي هو تطبيق قاعدة باريتو 80/20 على الحياة اليومية—تحديد 20% من الأنشطة التي توفر 80% من النتائج المطلوبة.

<a id="practical-tips-and-tricks"></a>
## النصائح والحيل العملية

مجموعة من النصائح القابلة للتطبيق لتطبيق مبادئ الكسل على العمل والعلاقات والعناية الذاتية:

- أتمتة المهام المتكررة
- استخدام تقنية بومودورو لإدارة الوقت
- إنشاء أنظمة تقلل من إرهاق اتخاذ القرار
- استخدام أدوات الذكاء الاصطناعي للمساعدة

<a id="use-cases"></a>
## حالات الاستخدام

أمثلة من الحياة الواقعية تُظهر كيف تحل مبادئ الكسل المشكلات وترفع الكفاءة:

- كيف يستخدم رواد الأعمال التفويض والأتمتة للتركيز على نمو الأعمال
- كيف تُبسّط الأوساط الأكاديمية سيرات البحث
- كيف يحسّن صناع المحتوى سير إنتاجهم

<a id="ai-agents-and-automation"></a>
## وكلاء الذكاء الاصطناعي والأتمتة

استكشاف تطوير وكلاء الذكاء الاصطناعي وأدوات الأتمتة التي تُبسّط المهام:

- استخدام ChatGPT كمساعد شخصي
- بناء سير عمل أتمتة مخصصة
- إنشاء شاشات e-ink للتعلم الخفي

<a id="language-learning-and-vlogs"></a>
## تعلم اللغات والفيديوهات

الموارد والتقنيات لتعلم اللغات بكفاءة، مع فيديوهات توثّق رحلة "الكسل الذكي":

- إنشاء تعلم لغة شخصي باستخدام التكرار المتباعد
- تنفيذ تقنيات تعلم غامر
- بناء مشاريع تشجع التعلم الخفي

<a id="community-contributions"></a>
## مساهمات المجتمع

شارك تجاربك ونصائحك وأفكارك حول الكسل الاستراتيجي:

- منتدى لتبادل حيل الإنتاجية
- أدوات ونماذج لقوالب الروتين اليومي
- مشاريع تعاونية لكفاءة أقل جهد

<a id="prerequisites"></a>
## المتطلبات الأساسية

يحوي المستودع عدة سكربتات مستقلة، لذلك تختلف المتطلبات حسب الوحدة.

الأساس المشترك:

- Python 3.9+
- `pip`
- Git

إشارات المتطلبات حسب الوحدة من الملفات المصدر:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (لسلاسل عمل أجهزة e-paper)
- `sqlite3` (مكتبة معيارية)

متطلبات العتاد لتشغيل `EinkWordsGPT` الكامل:

- Raspberry Pi (تذكر وثائق المشروع Raspberry Pi 5)
- لوحة e-ink ملونة 7 ألوان بحجم 7.3 بوصة من Waveshare

<a id="installation"></a>
## التثبيت

لعدم وجود ملف تبعيات جذري، ثبّت الاعتماديات يدويًا للوحدة التي تريد تشغيلها.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

اعتمادية اختيارية/عتاد:

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

### 3) اختبار لوحة Waveshare مقاس 7.3 بوصة

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) حل نطاقات ChatGPT وإخراج IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) دمج ملفات Python حسب المجلد لإنتاج حزم نصية صديقة للـAI

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) استخدام سير حذف الملفات بشكل آمن

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

<a id="configuration"></a>
## الإعداد

### بيانات اعتماد OpenAI

تستخدم `EinkWordsGPT` وسكربتات التحديث `OpenAI()` من مكتبة SDK الرسمية، وتفترض إعدادات بيانات اعتماد صحيحة في بيئة التشغيل.

الافتراض (موصى به):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### موقع قاعدة البيانات

تستخدم `code/EinkWordsGPT/words_gpt.py` و`words_update.py`:

- `db_path = 'words_phonetics.db'`

شغّل السكربتات من `code/EinkWordsGPT` أو حدّث المسارات إذا شغّلتها من مكان آخر.

### جذر سلة SafeShell

تستخدم `saferm`/`unrm`/`removeitanyway` حاليًا مسارًا أساسيًا ثابتًا:

- `/mnt/disk/BIN/ROOT`

تأكد أن هذا المسار موجود وقابل للكتابة قبل الاعتماد على `saferm`.

### مسارات Repo2Text

يحمل `vlogs/repo2text/convert-repo-to-merged-text.py` حالياً مسارات ثابتة:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

عدّل هذه القيم الثابتة لتطابق مشروعك المحلي.

<a id="examples"></a>
## الأمثلة

### مثال: دورة بطاقة تعلم بـ e-ink

- يختار السكربت تفاصيل الكلمة (أو يجلبها).
- تعرض البطاقة الصوتيات وتقسيم المقاطع وتلميحات مرادفات يابانية.
- يتم تحديث الشاشة كل 5 دقائق (`time.sleep(300)`).

### مثال: سير حذف آمن

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### مثال: ملف إخراج نطاق/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

<a id="development-notes"></a>
## ملاحظات التطوير

- هذا مستودع قديم؛ التطوير النشط موجود في: https://github.com/lachlanchen/the-art-of-lazying
- محتوى المستوى الأعلى هنا تنظيمي ويربط إلى مستودعات خارجية كثيرة.
- `i18n/` موجود حاليًا لكنه كان فارغًا؛ ملفات README متعددة اللغات كانت موجودة عادة في المستوى الأعلى.
- لا يوجد `requirements.txt` أو `pyproject.toml` في الجذر.

ملاحظة توافق محفوظة:

- قد تذكر الوثائق القديمة في المجلدات الفرعية سكربتات (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) تم دمجها الآن داخل `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

<a id="troubleshooting"></a>
## استكشاف الأخطاء

- `ModuleNotFoundError`: ثبّت حزم Python المفقودة المذكورة في [المتطلبات الأساسية](#prerequisites).
- أخطاء صلاحية `openai`: تأكد أن `OPENAI_API_KEY` مصدّر في الجلسة (`shell`).
- مشكلات تشغيل Waveshare: تحقق من إعداد SPI/الجهاز وثبّت اعتماديات البائع على Raspberry Pi.
- يبدو أن `saferm` لا يعمل: افحص وجود `/mnt/disk/BIN/ROOT` وصلاحيات الكتابة.
- `repo2text` لا ينتج ملفات: تأكد أن `source_directory` يشير لمجلد موجود يحتوي ملفات `.py`.
- سلوكات غير طبيعية في `chatgpt-traffic` للنطاقات: راجع وقم بتنظيف قائمة `domains` في السكربت قبل استخدامه في الإنتاج.

<a id="roadmap"></a>
## خريطة الطريق

- الحفاظ على هذا المستودع كأرشيف قديم مستقر مع روابط واضحة لمشاريع نشطة.
- تحسين ملفات الاعتماديات لكل وحدة قابلة للتشغيل.
- إضافة ترتيب i18n متناسق ضمن `/i18n` في الإصدارات اللاحقة.
- توسيع الأمثلة العملية وأدلة الإعداد القابلة للتكرار لسير عمل العتاد وغير العتاد.

<a id="contributing"></a>
## المساهمة

المساهمات مرحب بها.

1. اعمل Fork للمشروع.
2. أنشئ فرع المميزات الخاص بك (`git checkout -b feature/AmazingFeature`).
3. أجرِ الالتزام (`git commit -m 'Add some AmazingFeature'`).
4. ادفع الفرع (`git push origin feature/AmazingFeature`).
5. افتح طلب سحب (Pull Request).

يمكنك أيضًا المساهمة عبر:

- اقتراح تحسينات على مسارات الكسل الاستراتيجي.
- الإبلاغ عن مشاكل في السكربتات أو التوثيق.
- تحسين قابلية إعادة إنتاج الإعدادات لمسارات العتاد والبرمجيات.

## الترخيص

هذا المستودع مرخّص بموجب GNU General Public License v3.0. راجع [LICENSE](LICENSE).

<a id="acknowledgments"></a>
## الشكر والتقدير

شكر خاص للمساهمين وفريق OpenAI ومجتمعات Raspberry Pi و Makers التي تدعم التجارب حول أنظمة التعلم منخفضة الاحتكاك.

<a id="connect"></a>
## التواصل

- الموقع: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- البريد الإلكتروني: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
