[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> 참고: 이 저장소는 이전되었습니다. 현재 활성 개발은 https://github.com/lachlanchen/the-art-of-lazying 에서 계속됩니다.
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

전략적 게으름을 통해 더 단순하고 생산적인 삶을 지향하는 저장소입니다. AI 에이전트, 언어 학습, 브이로그를 아우르며 실용적인 팁과 실제 활용 사례를 담고 있습니다.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 목차

- [개요](#개요)
- [프로젝트](#프로젝트)
- [자동화 도구](#자동화-도구)
- [폴더 구조](#폴더-구조)
- [소개](#소개)
- [게으름의 이론](#게으름의-이론)
- [실전 팁과 트릭](#실전-팁과-트릭)
- [활용 사례](#활용-사례)
- [AI 에이전트와 자동화](#ai-에이전트와-자동화)
- [언어 학습과 브이로그](#언어-학습과-브이로그)
- [커뮤니티 기여](#커뮤니티-기여)
- [사전 요구사항](#사전-요구사항)
- [설치](#설치)
- [사용법](#사용법)
- [설정](#설정)
- [예시](#예시)
- [개발 노트](#개발-노트)
- [문제 해결](#문제-해결)
- [로드맵](#로드맵)
- [기여하기](#기여하기)
- [라이선스](#라이선스)
- [감사의 말](#감사의-말)
- [연결](#연결)

## 개요

`the-art-of-lazying-legacy`는 전략적 게으름을 중심으로 큐레이션된 우산형 저장소입니다.

- 일과 삶에 "lazying" 철학을 적용하는 개념적 콘텐츠
- 전자잉크 + GPT 언어 학습(`code/EinkWordsGPT`)을 포함한 실용 코드 자산
- 더 안전한 워크플로를 위한 유틸리티 스크립트(`scripts/lazy-care/SafeShell`)
- 브이로그용 도구 및 자동화 스니펫(`vlogs/`)
- 데모 자산 및 예제(`demos/`, `examples/`, `figs/`)

| Snapshot | Value |
|---|---|
| Repository role | Legacy archive + idea map |
| Active development | https://github.com/lachlanchen/the-art-of-lazying |
| Multilingual README files | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n directory | `i18n/` (present) |

이 저장소는 레거시 아카이브이자 아이디어 맵으로 계속 유용하며, 활성 개발은 위에 링크된 이전 저장소에서 진행됩니다.

## 프로젝트

### 🤖 AI 기반 크리에이티브 도구

| Project | Description | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 기반 단어 학습을 위한 전자잉크 디스플레이 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 단어의 어원을 분석하고 그래프로 제시합니다. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 적은 노력으로 효율적인 언어 학습을 위한 도구 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP 임베딩 + GPT 디코더 기반 영상/이미지 캡셔닝 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 영상 캡셔닝 도구: Katna/OpenCV로 키프레임 추출 후 ViT+GPT-2 모델로 캡션 생성 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 세분화된 언어 감지를 지원하는 다국어 전사 파이프라인 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 전 세계 창작 교류를 위한 언어 장벽 해소 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 영상용 메타데이터 자동 생성 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 전사, 자동 자막, 하이라이트, 메타데이터 생성을 포함한 AI 기반 자동 영상 편집 도구 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 콘텐츠 퍼블리싱 워크플로 간소화 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 여러 플랫폼으로 영상 콘텐츠를 모니터링·처리·발행하는 자동화 시스템 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AI 어시스턴트를 효과적으로 활용하기 위한 고급 기법 | |

## 자동화 도구

이 저장소에는 로컬에서 바로 실행 가능한 자동화 유틸리티가 포함되어 있습니다.

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | 연속 전자잉크 단어 카드 렌더링 루프(기본 300초마다 갱신). |
| `code/EinkWordsGPT/words_update.py` | OpenAI 기반 로직으로 단어 상세를 배치/선택 갱신. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3" e-paper 하드웨어 테스트. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, `removeitanyway` 셸 함수. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | 도메인-IP 해석 + 중복 제거 출력. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | 하위 디렉터리별 `.py` 파일을 `.txt`로 병합. |

## 폴더 구조

### 현재 저장소 구조 (정확한 현황)

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

### 원래의 개념적 구조 (보존)

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

> 참고: 위 개념도는 이전 README 버전의 맥락을 보존하기 위해 의도적으로 유지했습니다. "현재 저장소 구조" 블록은 이 레거시 저장소의 실제 트리를 반영합니다.

## 소개

The Art of Lazying는 전략적 게으름을 통해 에너지를 최적화하고 정말 중요한 일에 집중하는 방법을 제시합니다. 이 저장소는 의도적인 게으름이 어떻게 더 높은 생산성, 창의성, 웰빙으로 이어지는지 탐구합니다.

## 게으름의 이론

전략적 게으름의 원칙을 종합적으로 소개하며, 우선순위화·위임·자동화를 통해 생산성과 웰빙을 극대화하는 방법에 집중합니다.

핵심 원칙은 파레토의 80/20 법칙을 일상에 적용해, 원하는 결과의 80%를 만드는 20% 활동을 식별하는 것입니다.

## 실전 팁과 트릭

일, 관계, 자기관리에서 lazy 원칙을 적용하기 위한 실행 가능한 조언 모음입니다.

- 반복 업무 자동화
- 포모도로 기법으로 시간 관리
- 의사결정 피로를 줄이는 시스템 설계
- AI 도구를 활용한 보조

## 활용 사례

lazying 원칙이 문제를 해결하고 효율을 높이는 실제 사례입니다.

- 창업가가 위임과 자동화로 사업 성장에 집중하는 방법
- 연구자가 연구 워크플로를 간소화하는 방법
- 콘텐츠 크리에이터가 제작 프로세스를 최적화하는 방법

## AI 에이전트와 자동화

작업을 단순화하는 AI 에이전트와 자동화 도구 개발을 다룹니다.

- ChatGPT를 개인 비서로 활용
- 맞춤형 자동화 워크플로 구축
- 수동 학습을 돕는 전자잉크 디스플레이 제작

## 언어 학습과 브이로그

효율적인 언어 학습 리소스와 기법, 그리고 lazying 여정을 기록한 브이로그 자료를 제공합니다.

- 간격 반복 기반 개인화 언어 학습 구축
- 몰입형 학습 기법 적용
- 수동 학습을 장려하는 프로젝트 제작

## 커뮤니티 기여

전략적 게으름에 대한 여러분의 경험, 팁, 아이디어를 공유해 주세요.

- 생산성 해킹을 교환하는 포럼
- 일상 루틴을 위한 도구와 템플릿
- 게으른 효율을 위한 협업 프로젝트

## 사전 요구사항

저장소에는 서로 독립적인 스크립트가 여러 개 있으므로, 요구사항은 모듈별로 다릅니다.

공통 기준:

- Python 3.9+
- `pip`
- Git

소스 파일에서 확인되는 프로젝트별 신호:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (e-paper 하드웨어 플로우용)
- `sqlite3` (표준 라이브러리)

`EinkWordsGPT` 전체 런타임을 위한 하드웨어 요구사항:

- Raspberry Pi (프로젝트 문서에 Raspberry Pi 5 언급)
- Waveshare 7-color 7.3-inch e-ink panel

## 설치

루트 의존성 매니페스트가 없으므로, 실행하려는 모듈에 맞춰 의존성을 수동 설치해야 합니다.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

선택/하드웨어 의존성:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

SafeShell 설정:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## 사용법

### 1) EinkWordsGPT 디스플레이 루프 실행

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) 단어 상세 재확인/갱신

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Waveshare 7.3-inch 패널 테스트

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) ChatGPT 관련 도메인 해석 및 IP 출력

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) AI 친화 텍스트 번들을 위해 디렉터리별 Python 파일 병합

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) 더 안전한 파일 삭제 워크플로 사용

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## 설정

### OpenAI 자격 증명

`EinkWordsGPT` 및 업데이트 스크립트는 공식 SDK의 `OpenAI()`를 사용하며, 환경 변수에 자격 증명이 설정되어 있어야 합니다.

가정(권장):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### 데이터베이스 위치

`code/EinkWordsGPT/words_gpt.py`와 `words_update.py`는 다음을 사용합니다.

- `db_path = 'words_phonetics.db'`

스크립트는 `code/EinkWordsGPT`에서 실행하거나, 다른 위치에서 실행할 경우 경로를 수정하세요.

### SafeShell 휴지통 루트

`saferm`/`unrm`/`removeitanyway`는 현재 고정 베이스 경로를 사용합니다.

- `/mnt/disk/BIN/ROOT`

`saferm`에 의존하기 전에 해당 경로가 존재하고 쓰기 가능한지 확인하세요.

### Repo2Text 경로

`vlogs/repo2text/convert-repo-to-merged-text.py`에는 현재 하드코딩된 경로가 있습니다.

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

로컬 프로젝트에 맞게 이 상수들을 수정하세요.

## 예시

### 예시: E-ink 학습 카드 사이클

- 스크립트가 단어 상세를 선택(또는 조회)합니다.
- 단어 카드는 음성 기호, 음절 분해, 일본어 유의어 힌트를 렌더링합니다.
- 화면은 5분마다 갱신됩니다(`time.sleep(300)`).

### 예시: 안전 삭제 워크플로

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

## 개발 노트

- 이 저장소는 레거시 저장소이며, 활성 개발은 다음에서 진행됩니다: https://github.com/lachlanchen/the-art-of-lazying
- 최상위 콘텐츠는 큐레이션 중심이며, 외부 저장소 다수로 연결됩니다.
- `i18n/`는 존재하지만 현재 비어 있으며, 언어별 README는 현재 최상위에 위치합니다.
- 루트에 `requirements.txt` 또는 `pyproject.toml`이 없습니다.

보존된 호환성 참고:

- 하위 폴더의 이전 문서에는 (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) 스크립트가 언급될 수 있으나, 현재는 `scripts/lazy-care/SafeShell/safeshell_functions.sh`로 통합되었습니다.

## 문제 해결

- `ModuleNotFoundError`: [사전 요구사항](#사전-요구사항)에 나온 누락 패키지를 설치하세요.
- `openai` 인증 오류: 셸에서 `OPENAI_API_KEY`가 export 되었는지 확인하세요.
- Waveshare 런타임 문제: Pi에서 SPI/디바이스 설정 및 벤더 의존성 설치를 확인하세요.
- `saferm`이 동작하지 않는 것처럼 보일 때: `/mnt/disk/BIN/ROOT` 존재 여부와 쓰기 권한을 확인하세요.
- `repo2text`가 파일을 생성하지 않을 때: `source_directory`가 `.py` 파일을 포함한 기존 폴더를 가리키는지 확인하세요.
- `chatgpt-traffic` 도메인 이상: 운영에 사용하기 전에 스크립트의 `domains` 목록을 검토/정리하세요.

## 로드맵

- 이 저장소를 안정적인 레거시 아카이브로 유지하고, 활성 프로젝트로 향하는 명확한 안내를 제공합니다.
- 실행 가능한 각 서브모듈의 의존성 매니페스트를 개선합니다.
- 향후 개정에서 `/i18n` 하위의 일관된 i18n 레이아웃을 추가합니다.
- 하드웨어/비하드웨어 플로우 모두에 대해 실전 예시와 재현 가능한 설정 가이드를 확장합니다.

## 기여하기

기여를 환영합니다.

1. 프로젝트를 포크합니다.
2. 기능 브랜치를 생성합니다 (`git checkout -b feature/AmazingFeature`).
3. 변경사항을 커밋합니다 (`git commit -m 'Add some AmazingFeature'`).
4. 브랜치에 푸시합니다 (`git push origin feature/AmazingFeature`).
5. Pull Request를 생성합니다.

다음 방식으로도 기여할 수 있습니다.

- 전략적 게으름 워크플로 개선 아이디어 제안
- 스크립트/문서 이슈 제보
- 하드웨어/소프트웨어 경로의 설정 재현성 개선

## 라이선스

이 저장소는 GNU General Public License v3.0으로 라이선스됩니다. [LICENSE](LICENSE)를 참고하세요.

## 감사의 말

저마찰 학습 시스템 실험을 지원해 주는 기여자 여러분, OpenAI 팀, Raspberry Pi / 메이커 커뮤니티에 감사드립니다.

## 연결

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
