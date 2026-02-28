[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> 참고: 이 저장소는 이전되었습니다. 활성 개발은 https://github.com/lachlanchen/the-art-of-lazying 에서 계속됩니다.

# 게으름의 예술

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

이 저장소는 AI 에이전트, 언어 학습, Vlog를 중심으로 실전 팁과 실제 사용 사례를 다루며, 더 단순하고 생산적인 삶을 위한 전략적 "게으름"을 제시합니다.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

<a id="table-of-contents"></a>
## 목차

- [개요](#overview)
- [프로젝트](#projects)
- [자동화 도구](#automation-tools)
- [폴더 구조](#folder-structure)
- [소개](#introduction)
- [게으름의 이론](#the-theory-of-lazying)
- [실전 팁과 트릭](#practical-tips-and-tricks)
- [사용 사례](#use-cases)
- [AI 에이전트와 자동화](#ai-agents-and-automation)
- [언어 학습과 Vlog](#language-learning-and-vlogs)
- [커뮤니티 기여](#community-contributions)
- [사전 요구사항](#prerequisites)
- [설치](#installation)
- [사용법](#usage)
- [설정](#configuration)
- [예시](#examples)
- [개발 노트](#development-notes)
- [문제 해결](#troubleshooting)
- [로드맵](#roadmap)
- [기여](#contributing)
- [라이선스](#license)
- [감사의 말](#acknowledgments)
- [연결](#connect)

<a id="quick-links"></a>
## 빠른 링크

| 필요 | 시작 지점 |
|---|---|
| 전체 콘텐츠 지도 보기 | [개요](#overview) |
| 의존성 설치 | [사전 요구사항](#prerequisites) |
| 예시 실행 | [사용법](#usage) |
| 자주 발생하는 문제 해결 | [문제 해결](#troubleshooting) |
| 참여하기 | [기여](#contributing) |

<a id="overview"></a>
## 개요

`the-art-of-lazying-legacy`는 전략적 게으름을 중심으로 큐레이션한 상위 저장소입니다:

- 일과 삶에서 "게으름" 철학을 적용하는 개념적 내용.
- `code/EinkWordsGPT`를 포함한 실전 코드 산출물(E-ink + GPT 언어 학습).
- 더 안전한 워크플로우를 위한 유틸리티 스크립트(`scripts/lazy-care/SafeShell`).
- Vlog 관련 도구와 자동화 스니펫(`vlogs/`).
- 데모 자산과 예시 모음(`demos/`, `examples/`, `figs/`).

| 항목 | 값 |
|---|---|
| 리포지토리 역할 | 레거시 아카이브 + 아이디어 지도 |
| 활성 개발 | https://github.com/lachlanchen/the-art-of-lazying |
| 다국어 README | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n 디렉터리 | `i18n/` (존재) |
| 언어 학습 | 간격 반복 + GPT 워크플로우 |
| 자동화 초점 | 스크립트, 캡션, 배포, 하드웨어 워크플로우 |

이 저장소는 유용한 레거시 아카이브이자 아이디어 지도이며, 활성 개발은 위에서 링크한 이전 저장소로 이동했습니다.

---

<a id="projects"></a>
## 프로젝트

### 🤖 AI 기반 창작 도구

| 프로젝트 | 설명 | 데모 |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 기반 단어 학습을 위한 전자잉크 디스플레이 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 단어의 어원 분석 및 그래프 시각화 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 적은 노력으로 효율적인 언어 학습을 위한 도구 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP 임베딩 + GPT 디코더 기반 영상/이미지 캡셔닝 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 비디오 캡셔닝 도구: Katna/OpenCV로 핵심 프레임 추출 후 ViT+GPT-2로 자막 생성 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 정교한 언어 감지 기능이 있는 다국어 전사 파이프라인 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 글로벌 창작 협업을 위한 언어 장벽 해소 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 비디오용 메타데이터 자동 생성 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 전사, 자동 자막, 하이라이트, 메타데이터 생성이 통합된 AI 기반 자동 편집 도구 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 콘텐츠 배포 워크플로우 간소화 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 다중 플랫폼에 대한 비디오 모니터링/처리/게시 자동 시스템 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AI 어시스턴트를 효과적으로 활용하는 고급 기법 | |

<a id="automation-tools"></a>
## 자동화 도구

이 저장소에는 로컬에서 바로 실행 가능한 자동화 유틸리티가 포함되어 있습니다:

| 경로 | 목적 |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 연속 실행되는 e-ink 단어 카드 렌더링 루프(기본 300초 갱신) |
| `code/EinkWordsGPT/words_update.py` | OpenAI 기반 로직으로 단어 상세 정보를 배치/개별 갱신 |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3인치 전자잉크 하드웨어 테스트 |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, `removeitanyway` 셸 함수 |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 도메인-IPv4 해석 + 중복 제거 출력 |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | `.py` 파일을 하위 디렉터리 단위로 `.txt`로 병합 |

<a id="folder-structure"></a>
## 폴더 구조

### 현재 저장소 구조(정확)

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

### 원래 개념 구조(보존)

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

> Note: 위의 개념 지도는 이전 README 버전에서 의도적으로 유지한 것입니다. `Current Repository Structure` 블록은 이 레거시 저장소의 실제 트리를 반영합니다.

<a id="introduction"></a>
## 소개

The Art of Lazying은 에너지 사용을 최적화하고 진짜 중요한 것에 집중하기 위한 방식으로 전략적 게으름을 제시합니다. 이 저장소는 의도적으로 게으르면서도 생산성, 창의성, 웰빙을 높일 수 있는 방법을 탐색합니다.

<a id="the-theory-of-lazying"></a>
## 게으름의 이론

전략적 게으름의 원칙을 포괄적으로 소개합니다. 핵심은 우선순위를 정하고 위임하고 자동화함으로써 생산성과 웰빙을 동시에 극대화하는 것입니다.

이 핵심 원칙은 파레토의 80/20 법칙을 일상에 적용해, 원하는 결과의 80%를 만들어내는 20%의 활동을 찾아내는 것입니다.

<a id="practical-tips-and-tricks"></a>
## 실전 팁과 트릭

일, 대인 관계, 자기 관리에 게으름 원칙을 적용하는 실행 가능한 조언 모음입니다:

- 반복 작업 자동화
- 뽀모도로 기법을 활용한 시간 관리
- 의사결정 피로를 줄이는 시스템 구축
- AI 도구를 보조 역할로 적극 활용

<a id="use-cases"></a>
## 사용 사례

게으름 원칙이 문제 해결과 효율 향상에 어떻게 기여하는지 실제 예시입니다:

- 창업가가 위임과 자동화를 사용해 비즈니스 성장에 집중하는 방식
- 연구자가 연구 워크플로우를 간소화하는 방식
- 콘텐츠 제작자가 제작 프로세스를 최적화하는 방식

<a id="ai-agents-and-automation"></a>
## AI 에이전트와 자동화

작업을 단순화하는 AI 에이전트와 자동화 도구의 발전을 살펴봅니다:

- ChatGPT를 개인 비서로 활용
- 맞춤형 자동화 워크플로우 구축
- 수동 학습을 돕는 e-ink 디스플레이 구성

<a id="language-learning-and-vlogs"></a>
## 언어 학습과 Vlog

효율적인 언어 학습을 위한 리소스와 기법, 그리고 게으름 여정 기록 Vlog를 정리한 섹션입니다:

- 간격 반복 기반의 개인 맞춤 언어 학습 만들기
- 몰입형 학습 기법 적용
- 수동/반복 학습을 유도하는 프로젝트 제작

<a id="community-contributions"></a>
## 커뮤니티 기여

전략적 게으름에 대한 여러분의 경험, 팁, 아이디어를 공유해 주세요:

- 생산성 꿀팁 교환 포럼
- 일상 루틴용 도구와 템플릿
- 협업 프로젝트를 통한 저비용 효율 개선

<a id="prerequisites"></a>
## 사전 요구사항

이 저장소는 여러 독립 스크립트를 포함하므로 요구사항은 모듈마다 다릅니다.

공통 기본 조건:

- Python 3.9+
- `pip`
- Git

소스 파일에서 확인되는 모듈별 요구사항:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (e-paper 하드웨어 흐름)
- `sqlite3` (표준 라이브러리)

`EinkWordsGPT` 전체 실행을 위한 하드웨어 요구사항:

- Raspberry Pi (프로젝트 문서에서는 Raspberry Pi 5 언급)
- Waveshare 7색 7.3인치 e-ink 패널

<a id="installation"></a>
## 설치

루트 수준 의존성 매니페스트가 없으므로, 실행하려는 모듈별로 의존성을 수동으로 설치하세요.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

선택/하드웨어 의존:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell 설정:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

<a id="usage"></a>
## 사용법

### 1) EinkWordsGPT 표시 루프 실행

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) 단어 상세 정보 재확인/갱신

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Waveshare 7.3인치 패널 테스트

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) ChatGPT 관련 도메인과 IP 결과 출력

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) AI 친화형 텍스트 번들 생성을 위한 Python 파일 병합

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) 더 안전한 파일 삭제 워크플로우 사용

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

<a id="configuration"></a>
## 설정

### OpenAI 자격 증명

`EinkWordsGPT`와 업데이트 스크립트는 공식 SDK의 `OpenAI()`를 사용하며, 환경에서 인증 정보를 설정할 것으로 가정합니다.

권장 가정:

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 데이터베이스 위치

`code/EinkWordsGPT/words_gpt.py`와 `words_update.py`는 다음을 사용합니다:

- `db_path = 'words_phonetics.db'`

`code/EinkWordsGPT`에서 스크립트를 실행하거나, 다른 위치에서 실행 시 경로를 갱신하세요.

### SafeShell 휴지통 루트

`saferm`/`unrm`/`removeitanyway`는 현재 고정 기본 경로를 사용합니다:

- `/mnt/disk/BIN/ROOT`

`saferm`을 사용하기 전에 해당 경로가 존재하며 쓰기 가능한지 확인하세요.

### Repo2Text 경로

`vlogs/repo2text/convert-repo-to-merged-text.py`에는 현재 하드코딩 경로가 있습니다:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

이 값을 로컬 프로젝트에 맞게 수정하세요.

<a id="examples"></a>
## 예시

### 예시: E-ink 학습 카드 주기

- 스크립트가 단어 상세 정보를 선택(또는 가져옴)합니다.
- 단어 카드는 음성 기호, 음절 분할, 일본어 동의어 힌트를 표시합니다.
- 화면은 5분마다 갱신됩니다 (`time.sleep(300)`).

### 예시: 안전한 삭제 워크플로우

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### 예시: 도메인/IP 출력 파일

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

<a id="development-notes"></a>
## 개발 노트

- 이 저장소는 레거시 저장소이며, 활성 개발은 다음에서 진행됩니다: https://github.com/lachlanchen/the-art-of-lazying
- 상위 레벨 콘텐츠는 큐레이션 중심이며, 외부 저장소 링크가 많습니다.
- `i18n/`가 존재하지만 현재 비어 있습니다; 언어별 README는 현재 최상위에 있습니다.
- 루트에는 `requirements.txt` 또는 `pyproject.toml`이 없습니다.

보존 호환성 참고:

- 하위 폴더의 이전 문서에는 이제 `scripts/lazy-care/SafeShell/safeshell_functions.sh`로 통합된 `saferm.sh`, `unrm.sh`, `removeitanyway.sh`가 언급될 수 있습니다.

<a id="troubleshooting"></a>
## 문제 해결

- `ModuleNotFoundError`: [사전 요구사항](#prerequisites)에 나열된 누락 패키지를 설치하세요.
- `openai` 인증 오류: `OPENAI_API_KEY`가 쉘에서 export 되었는지 확인하세요.
- Waveshare 실행 이슈: Pi의 SPI/장치 설정을 확인하고 벤더 의존 패키지를 설치하세요.
- `saferm`이 동작하지 않음: `/mnt/disk/BIN/ROOT`가 존재하고 쓰기 권한이 있는지 확인하세요.
- `repo2text`가 파일을 생성하지 않음: `source_directory`가 `.py` 파일이 있는 기존 폴더를 가리키는지 확인하세요.
- `chatgpt-traffic` 도메인 이상: 운영 전 스크립트의 `domains` 목록을 점검하고 정리하세요.

<a id="roadmap"></a>
## 로드맵

- 이 저장소를 활성 프로젝트에 대한 명확한 연결 고리가 있는 안정적인 레거시 아카이브로 유지합니다.
- 실행 가능한 각 하위 모듈별 의존성 매니페스트를 개선합니다.
- 향후 개정에서 `/i18n` 아래에 일관된 i18n 레이아웃을 추가합니다.
- 하드웨어/비하드웨어 흐름 모두에 대해 실전 예시와 재현 가능한 설정 가이드를 확장합니다.

<a id="contributing"></a>
## 기여

기여는 언제나 환영입니다.

1. 프로젝트를 포크합니다.
2. 기능 브랜치를 만듭니다 (`git checkout -b feature/AmazingFeature`).
3. 변경사항을 커밋합니다 (`git commit -m 'Add some AmazingFeature'`).
4. 브랜치에 푸시합니다 (`git push origin feature/AmazingFeature`).
5. 풀 리퀘스트(Pull Request)를 엽니다.

다음 방식으로도 기여할 수 있습니다:

- 전략적 게으름 워크플로우 개선 제안
- 스크립트 또는 문서의 이슈 보고
- 하드웨어/소프트웨어 설정 재현성을 높이는 개선

## 라이선스

이 저장소는 GNU General Public License v3.0 하에 라이선스됩니다. 자세한 내용은 [LICENSE](LICENSE) 를 참조하세요.

<a id="acknowledgments"></a>
## 감사 인사

아이디어 실험을 지원해 준 기여자, OpenAI 팀, 그리고 저마찰 학습 시스템 실험을 지지하는 Raspberry Pi / 메이커 커뮤니티에 감사드립니다.

<a id="connect"></a>
## 연결

- 웹사이트: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- 이메일: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
