[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# 게으름의 예술

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

AI 에이전트, 언어 학습, 실용적 자동화, 브이로그 기반의 실제 워크플로우를 다루는, 더 단순하고 효율적인 삶을 위한 전략적 게으름에 초점을 둔 저장소입니다.

| 항목 | 이 README에 담긴 내용 |
|---|---|
| 🤖 자동화 | 로컬에서 바로 실행할 수 있는 핵심 도구, 스크립트, 실전 워크플로우 |
| 🧠 학습 | 효율적인 학습 습관을 위한 언어 우선 프로젝트와 예시 |
| 📚 공유 | 다국어 문서, 프로젝트 링크, 기여 가이드 |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 목차

- [개요](#overview)
- [프로젝트](#projects)
- [저장소 구조](#repository-structure)
- [기능](#features)
- [필수 조건](#prerequisites)
- [설치](#installation)
- [사용법](#usage)
- [설정](#configuration)
- [예시](#examples)
- [개발 메모](#development-notes)
- [문제 해결](#troubleshooting)
- [로드맵](#roadmap)
- [소개](#introduction)
- [게으름의 이론](#the-theory-of-lazying)
- [실전 팁과 요령](#practical-tips-and-tricks)
- [사용 사례](#use-cases)
- [AI 에이전트와 자동화](#ai-agents-and-automation)
- [언어 학습과 브이로그](#language-learning-and-vlogs)
- [커뮤니티 기여](#community-contributions)
- [❤️ 지원](#-support)
- [연결](#connect)
- [기여하기](#contributing)
- [라이선스](#license)

<a id="overview"></a>
## 개요

`the-art-of-lazying`는 실전적인 전략적 게으름을 위한 허브 저장소입니다. 반복 작업을 자동화하고 언어 학습 워크플로우를 개선하며, 스크립트와 브이로그를 통해 현실의 실험을 문서화합니다.

| 한눈에 보기 | 상세 |
|---|---|
| 🎯 핵심 주제 | 생산성, 학습, 창의적 산출물을 위한 전략적 게으름 |
| 🧩 저장소 성격 | 로컬 도구 + 선별된 외부 프로젝트의 하이브리드 |
| 🛠️ 로컬 하이라이트 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 문서 | 루트 README + 다국어 `i18n/` 변형 |

이 저장소에는 다음이 모두 포함됩니다:
- 관련 외부 프로젝트 링크 모음
- 로컬 도구와 코드, 특히 다음 항목:
  - `code/EinkWordsGPT` (라즈베리파이 + Waveshare 전자잉크 + OpenAI 단어 학습 디스플레이)
  - `scripts/lazy-care/SafeShell` (안전한 삭제/복원 쉘 함수)
  - `vlogs/chatgpt-traffic`와 `vlogs/repo2text` (작은 Python 유틸리티)

<a id="projects"></a>
## 프로젝트

### 🚀 AI 기반 창작 도구

| 프로젝트 | 설명 | 데모 |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 기반 단어 학습 기능을 갖춘 전자잉크 디스플레이 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 단어의 기원 분석과 그래프 기반 시각화 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 최소한의 노력으로 효율적인 언어 학습을 돕는 도구 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP 임베딩 + GPT 디코더 기반의 영상 및 이미지 캡션 생성 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Katna/OpenCV로 키프레임을 추출하고, ViT+GPT-2로 캡션을 생성하는 영상 캡션 툴 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 세밀한 언어 감지를 지원하는 다국어 전사 파이프라인 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 글로벌 창작 교류의 언어 장벽을 허무는 솔루션 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 비디오용 자동 메타데이터 생성 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 전사, 자동 자막, 하이라이팅, 메타데이터 생성을 지원하는 AI 기반 자동 영상 편집 도구 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 콘텐츠 발행 워크플로우를 정리하는 도구 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 여러 플랫폼에 영상을 자동으로 모니터링·처리·발행하는 시스템 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AI 어시스턴트를 효과적으로 사용하는 고급 기법 | |

### ⚙️ 이 저장소의 로컬 자동화 도구

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: 더 안전한 삭제(`saferm`), 복원(`unrm`), 영구 삭제(`removeitanyway`) 기능.
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: 도메인-IP 해석 및 중복 제거 출력 생성.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: AI 보조 분석을 위해 파이썬 파일을 디렉터리 단위로 텍스트 번들로 병합.

<a id="repository-structure"></a>
## 저장소 구조

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

참고: 이전 README 변형에서 보였던 예전의 일반적인 폴더 다이어그램(`book/`, `code/ai-agents/` 등)은 현재 저장소 트리와 정확히 일치하지 않습니다. 위 구조가 현재 실제 파일을 기준으로 정리된 것입니다.

<a id="features"></a>
## 기능

- 전략적 게으름을 바탕으로 생산성, 학습, 콘텐츠 워크플로우를 개선하는 프레임워크입니다.
- 전사, 자막, 번역, 발행 자동화를 아우르는 선별된 AI 프로젝트 포트폴리오.
- GPT 기반 단어 선택을 활용한 전자잉크 연동 언어 학습(`EinkWordsGPT`).
- 되돌릴 수 있는 삭제 워크플로우를 위한 실용적인 쉘 안전 도구.
- DNS/도메인 트래픽 점검 및 저장소 텍스트 변환을 위한 스크립트 중심 유틸리티.
- `i18n/`를 통한 다국어 문서 지원.

<a id="prerequisites"></a>
## 필수 조건

일반:
- Git
- Python 3.9+ 권장

`code/EinkWordsGPT`의 경우:
- Raspberry Pi (문서에는 Raspberry Pi 5 언급)
- Python 드라이버가 지원하는 Waveshare 7.3인치 7색 전자잉크 디스플레이 (`waveshare_epd`)
- 코드에서 사용하는 Python 패키지: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (`sqlite3`는 Python 표준 라이브러리 사용)
- 환경 변수에 OpenAI API 키 설정 (코드는 `OpenAI()`를 직접 초기화)

`vlogs/chatgpt-traffic`의 경우:
- `dnspython`

`scripts/lazy-care/SafeShell`의 경우:
- `realpath`, `mv`, `/bin/rm`에 접근 가능한 Bash 또는 Zsh 쉘

<a id="installation"></a>
## 설치

저장소를 클론하세요:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

저장소 전체에서 자주 쓰는 Python 의존성 설치:

```bash
pip install openai Pillow pytz pykakasi dnspython
```

참고: `code/EinkWordsGPT/README.md`에서는 `requirements.txt`를 언급하지만, 현재 이 저장소에는 `requirements.txt`가 없습니다. 위처럼 직접 패키지를 설치하세요.

<a id="usage"></a>
## 사용법

### 1) EinkWordsGPT (로컬 하드웨어 플로우)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # 선택: 하드웨어/디스플레이 테스트
python words_gpt.py        # 디스플레이 루프 실행 (약 300초마다 갱신)
```

선택적 데이터베이스 유지보수 스크립트:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (안전한 삭제 워크플로우)

쉘 함수 로드:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # 또는 ~/.zshrc
source ~/.bashrc                          # 또는 source ~/.zshrc
```

명령어 사용:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) ChatGPT Traffic resolver

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text 병합기

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

참고: `convert-repo-to-merged-text.py`는 현재 하드코딩된 경로(`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`)를 사용합니다. 다른 저장소에 대해 실행하려면 상수 값을 수정하세요.

<a id="configuration"></a>
## 설정

### OpenAI 설정 (`code/EinkWordsGPT`)

코드는 다음과 같이 클라이언트를 생성합니다:

```python
client = OpenAI()
```

따라서 스크립트 실행 전 표준 OpenAI 환경 변수 방식으로 API 인증 정보를 구성하세요.

### 데이터베이스 경로 (`code/EinkWordsGPT`)

코드 내 기본값:

```python
db_path = 'words_phonetics.db'
```

`code/EinkWordsGPT/`에 `words_phonetics.db`가 존재하는지 확인하세요(현재 저장소에 포함되어 있음).

### SafeShell 휴지통 위치

`saferm`/`unrm`/`removeitanyway`는 고정된 기본 경로를 사용합니다:

```bash
/mnt/disk/BIN/ROOT
```

환경이 다르면 `scripts/lazy-care/SafeShell/safeshell_functions.sh`에서 경로를 조정하세요.

<a id="examples"></a>
## 예시

- `demos/`의 전자잉크 단어 카드 데모:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT 제작 노트/자료:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

<a id="development-notes"></a>
## 개발 메모

- 이 저장소는 로컬 코드와 외부 프로젝트 링크를 함께 담은 멀티 프로젝트 쇼케이스입니다.
- 루트에는 패키지 매니저/빌드 매니페스트가 아직 없습니다(`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile`이 루트에 없음).
- 일부 하위 README는 템플릿 성격이 강하며 현재 파일 구조와 일부 달리 보일 수 있습니다. 본 README의 명령어는 현재 존재하는 경로와 스크립트에 맞춰 정리했습니다.
- `README_EN.md`와 `README_CN.md`는 레거시 버전이고, 현재 다국어 구조는 `README.md` + `i18n/*`입니다.

<a id="troubleshooting"></a>
## 문제 해결

- Python 패키지의 `ModuleNotFoundError`:
  - `pip install openai Pillow pytz pykakasi dnspython`으로 의존성을 재설치하세요.

- `EinkWordsGPT`에서 `ImportError: waveshare_epd`:
  - Raspberry Pi 환경에 Waveshare e-paper Python 드라이버/라이브러리를 설치하세요.

- OpenAI 인증 오류:
  - `words_gpt.py` 또는 `words_update.py` 실행 전에 환경 변수로 OpenAI API 키가 설정되었는지 확인하세요.

- 설정 후 `saferm`/`unrm`이 보이지 않는 경우:
  - 올바른 쉘 rc 파일을 source했는지, `safeshell_functions.sh`가 성공적으로 추가되었는지 확인하세요.

- `unrm`으로 파일 복원이 되지 않는 경우:
  - 복원 경로가 SafeShell의 미러 휴지통 레이아웃(`/mnt/disk/BIN/ROOT`)과 일치하는지 확인하세요.

- `repo2text` 스크립트에서 출력이 없는 경우:
  - `convert-repo-to-merged-text.py`의 `source_directory`를 실제 존재하는 폴더로 변경하세요.

<a id="roadmap"></a>
## 로드맵

- 모든 i18n 파일에서 루트 README 내용 정합성 확대(현재는 많은 언어에서 요약본만 제공).
- Waveshare e-ink 드라이버의 환경별 설정 문서 추가.
- 로컬 도구용 루트 수준 재현 가능한 의존성 매니페스트 추가.
- 핵심 유틸리티에 대한 검증/테스트 스크립트 추가.
- 외부 프로젝트 링크를 더 풍부한 로컬 데모로 통합 정리.

<a id="introduction"></a>
## 소개

게으름의 예술은 에너지를 낭비하지 않고 정말 중요한 일에 집중할 수 있게 해주는 전략적 게으름을 제안합니다. 이 저장소는 의도적인 '게으름'이 생산성, 창의성, 웰빙을 높일 수 있는 방법을 탐색합니다.

<a id="the-theory-of-lazying"></a>
## 게으름의 이론

전략적 게으름의 원칙에 대한 종합적 소개로, 우선순위 설정, 위임, 자동화를 통해 생산성과 웰빙을 극대화하는 방법을 다룹니다.

핵심 원칙은 파레토의 80/20 법칙을 일상에 적용하는 것입니다. 결과가 가장 큰 상위 20% 활동을 찾아내는 방식입니다.

<a id="practical-tips-and-tricks"></a>
## 실전 팁과 요령

일과, 인간관계, 자기 관리에 게으름 원칙을 적용하는 실행 가능한 조언 모음입니다:
- 반복 작업 자동화
- 포모도로 기법으로 시간 관리
- 의사결정 피로를 줄이는 시스템 구축
- AI 도구를 보조적으로 활용하기

<a id="use-cases"></a>
## 사용 사례

게으름 원칙으로 문제를 해결하고 효율을 높인 실제 사례들:
- 사업가가 위임과 자동화로 비즈니스 성장에 집중하는 방식
- 학술 연구자가 워크플로우를 간소화하는 방식
- 콘텐츠 제작자가 제작 과정을 최적화하는 방식

<a id="ai-agents-and-automation"></a>
## AI 에이전트와 자동화

작업을 단순화하는 AI 에이전트와 자동화 도구의 발전을 살펴봅니다:
- ChatGPT를 개인 비서처럼 활용
- 맞춤형 자동화 워크플로우 구축
- 수동 학습을 줄이는 전자잉크 디스플레이 구축

<a id="language-learning-and-vlogs"></a>
## 언어 학습과 브이로그

효율적인 언어 학습을 위한 자료와 기법, 그리고 게으름 여정을 기록한 브이로그:
- 간격 반복 기반의 개인화된 언어 학습 설계
- 몰입형 학습 기법 적용
- 수동 학습을 강화하는 프로젝트 구축

<a id="community-contributions"></a>
## 커뮤니티 기여

전략적 게으름 관련 경험, 팁, 아이디어를 공유하세요:
- 생산성 해킹 교류 포럼
- 일상 루틴용 도구와 템플릿
- 게으른 효율성을 위한 협업 프로젝트

## 연결

- 웹사이트: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- 이메일: lach@lazying.art

<a id="contributing"></a>
## 기여하기

기여는 코드, 문서, 예시, 번역 모두 환영합니다.

1. 저장소를 포크하세요.
2. 브랜치를 만드세요 (`git checkout -b feature/your-feature`).
3. 변경사항을 명확한 커밋 메시지로 작성하세요.
4. 변경 동기와 영향도를 설명하는 Pull Request를 올리세요.

시작이 막막하다면:
- 로컬 도구의 설정 문서를 개선하세요.
- 기존 유틸리티에 테스트/검증 스크립트를 추가하세요.
- `i18n/README.*.md` 중 한 버전의 정합성과 품질을 개선하세요.

<a id="license"></a>
## 라이선스

이 저장소에는 루트(`LICENSE`)와 몇몇 하위 폴더에 GPLv3 라이선스 텍스트가 포함되어 있습니다.

참고: 일부 하위 프로젝트 README에서는 MIT를 언급합니다. 각 하위 프로젝트를 독립적으로 재배포할 계획이라면 루트 저장소는 GPLv3 적용으로 보고, 하위 프로젝트별 라이선스를 별도로 확인하세요.


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
