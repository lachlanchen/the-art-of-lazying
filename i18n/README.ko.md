[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

# 게으름의 예술 (The Art of Lazying)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

AI 에이전트, 언어 학습, 실용 자동화, 브이로그 기반의 현실 워크플로를 다루며, 더 단순하고 더 높은 레버리지의 삶을 위한 전략적 게으름에 집중한 저장소입니다.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## 목차

- [개요](#개요)
- [프로젝트](#프로젝트)
- [저장소 구조](#저장소-구조)
- [특징](#특징)
- [사전 준비](#사전-준비)
- [설치](#설치)
- [사용법](#사용법)
- [설정](#설정)
- [예시](#예시)
- [개발 노트](#개발-노트)
- [문제 해결](#문제-해결)
- [로드맵](#로드맵)
- [소개](#소개)
- [게으름 이론](#게으름-이론)
- [실용 팁과 트릭](#실용-팁과-트릭)
- [활용 사례](#활용-사례)
- [AI 에이전트와 자동화](#ai-에이전트와-자동화)
- [언어 학습과 브이로그](#언어-학습과-브이로그)
- [커뮤니티 기여](#커뮤니티-기여)
- [연결](#연결)
- [지원 / 기부](#지원--기부)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

## 개요

`the-art-of-lazying`는 실전형 전략적 게으름을 위한 허브 저장소입니다. 반복 작업을 자동화하고, 언어 학습 워크플로를 개선하며, 스크립트와 브이로그를 통해 실제 실험을 기록합니다.

| 한눈에 보기 | 상세 |
|---|---|
| 🎯 핵심 테마 | 생산성, 학습, 창작 결과물을 위한 전략적 게으름 |
| 🧩 저장소 성격 | 로컬 도구 + 선별된 외부 프로젝트 하이브리드 |
| 🛠️ 로컬 하이라이트 | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 문서 | 루트 README + 다국어 `i18n/` 변형 |

이 저장소에는 다음이 함께 포함됩니다:
- 관련 외부 프로젝트로 향하는 큐레이션 링크
- 로컬 도구와 코드, 특히:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + OpenAI 단어 학습 디스플레이)
  - `scripts/lazy-care/SafeShell` (안전 삭제/복원 셸 함수)
  - `vlogs/chatgpt-traffic` 및 `vlogs/repo2text` (작은 Python 유틸리티)

## 프로젝트

### 🚀 AI 기반 창작 도구

| 프로젝트 | 설명 | 데모 |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | GPT 기반 단어 학습이 가능한 e-ink 디스플레이 | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | 단어 어원을 분석하고 그래프로 시각화 | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | 최소한의 노력으로 효율적인 언어 학습을 돕는 도구 | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | OpenAI CLIP 임베딩 + GPT 디코더 기반 영상/이미지 캡셔닝 | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | 영상 캡셔닝 도구: Katna/OpenCV로 키프레임 추출 후 ViT+GPT-2 모델로 캡션 생성 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | 세밀한 언어 감지를 포함한 다국어 전사 파이프라인 | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | 글로벌 창작 교류를 위한 언어 장벽 해소 | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | 영상 메타데이터 자동 생성 | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | 전사, 자동 자막, 하이라이트, 메타데이터 생성을 포함한 AI 기반 자동 영상 편집 도구 | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | 콘텐츠 퍼블리싱 워크플로 간소화 | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | 영상 콘텐츠를 다중 플랫폼에 모니터링/처리/배포하는 자동 시스템 | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | AI 어시스턴트를 효과적으로 활용하기 위한 고급 기법 | |

### ⚙️ 자동화 도구 (이 저장소의 로컬 구성)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: 더 안전한 셸 삭제(`saferm`), 복원(`unrm`), 명시적 영구 삭제(`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: 도메인-IP 해석 및 중복 제거 출력 생성기.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: 디렉터리 단위로 Python 파일을 텍스트 번들로 합쳐 AI 보조 분석에 활용.

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

참고: 이전 README 변형에 있던 오래된 일반 폴더 다이어그램(예: `book/`, `code/ai-agents/`)은 현재 저장소 트리와 정확히 일치하지 않습니다. 위 구조는 현재 파일 기준입니다.

## 특징

- 생산성, 학습, 콘텐츠 워크플로를 위한 전략적 게으름 프레임워크
- 전사, 캡셔닝, 번역, 퍼블리싱 자동화를 아우르는 큐레이션 AI 프로젝트 포트폴리오
- GPT 보조 단어 선택을 활용한 하드웨어 통합 언어 학습(`EinkWordsGPT`)
- 되돌릴 수 있는 삭제 워크플로를 위한 실용 셸 안전 도구
- DNS/도메인 트래픽 점검 및 저장소-텍스트 변환을 위한 스크립트 중심 유틸리티
- `i18n/` 기반 다국어 문서 지원

## 사전 준비

일반:
- Git
- Python 3.9+ 권장

`code/EinkWordsGPT`용:
- Raspberry Pi (프로젝트 문서에서 Raspberry Pi 5 언급)
- Python 드라이버 지원이 있는 Waveshare 7.3인치 7색 e-ink 디스플레이(`waveshare_epd`)
- 코드에서 사용하는 Python 패키지: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (Python 표준 라이브러리 `sqlite3` 사용)
- 환경 변수에 설정된 OpenAI API 키 (코드에서 `OpenAI()`를 직접 초기화)

`vlogs/chatgpt-traffic`용:
- `dnspython`

`scripts/lazy-care/SafeShell`용:
- `realpath`, `mv`, `/bin/rm`에 접근 가능한 Bash 또는 Zsh 셸

## 설치

저장소 클론:

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

자주 쓰는 Python 의존성 설치(저장소 전반 기본값):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

참고: `code/EinkWordsGPT/README.md`에는 `requirements.txt`가 언급되지만, 현재 이 저장소에는 `requirements.txt`가 없습니다. 위처럼 수동 설치가 필요합니다.

## 사용법

### 1) EinkWordsGPT (로컬 하드웨어 플로우)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

선택적 데이터베이스 유지보수 스크립트:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (안전 삭제 워크플로)

셸 함수 로드:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

명령 사용:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) ChatGPT Traffic 해석기

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Repo-to-text 병합기

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

참고: `convert-repo-to-merged-text.py`는 현재 하드코딩된 경로(`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`)를 사용합니다. 다른 저장소에 적용하려면 실행 전에 상수를 수정하세요.

## 설정

### OpenAI 설정 (`code/EinkWordsGPT`)

코드에서 클라이언트를 다음과 같이 생성합니다:

```python
client = OpenAI()
```

따라서 스크립트 실행 전에 OpenAI 표준 환경 변수 방식으로 API 자격 증명을 설정하세요.

### 데이터베이스 경로 (`code/EinkWordsGPT`)

코드 기본값:

```python
db_path = 'words_phonetics.db'
```

`words_phonetics.db`가 `code/EinkWordsGPT/`에 존재하는지 확인하세요(현재 이 저장소에 포함되어 있습니다).

### SafeShell 휴지통 위치

`saferm`/`unrm`/`removeitanyway`는 고정 기본 경로를 사용합니다:

```bash
/mnt/disk/BIN/ROOT
```

환경이 다르면 `scripts/lazy-care/SafeShell/safeshell_functions.sh`에서 이 경로를 조정하세요.

## 예시

- `demos/`의 e-ink 단어 카드 데모:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- ChachaGPT 제작 노트/자료:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## 개발 노트

- 이 저장소는 로컬 코드와 외부 프로젝트 링크를 함께 담은 멀티 프로젝트 쇼케이스 저장소입니다.
- 현재 루트 레벨 패키지 매니저 또는 빌드 매니페스트가 제공되지 않습니다(`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile`이 루트에 없음).
- 일부 하위 README는 템플릿 성격이 있어 현재 파일 레이아웃과 부분적으로 불일치할 수 있습니다. 이 README의 명령어는 현재 존재하는 경로/스크립트에 맞췄습니다.
- `README_EN.md`와 `README_CN.md`는 레거시 변형이며, 활성 다국어 구조는 `README.md` + `i18n/*`입니다.

## 문제 해결

- Python 패키지 `ModuleNotFoundError` 발생 시:
  - `pip install openai Pillow pytz pykakasi dnspython`로 의존성을 다시 설치하세요.

- `EinkWordsGPT`에서 `ImportError: waveshare_epd` 발생 시:
  - Raspberry Pi 환경에 Waveshare e-paper Python 드라이버/라이브러리를 설치하세요.

- OpenAI 인증 오류 발생 시:
  - `words_gpt.py` 또는 `words_update.py` 실행 전, OpenAI API 키가 환경 변수에 설정되어 있는지 확인하세요.

- 설정 후 `saferm`/`unrm` 명령을 찾을 수 없을 때:
  - 올바른 셸 rc 파일을 source 했는지, `safeshell_functions.sh`가 정상적으로 append 되었는지 확인하세요.

- `unrm`이 파일을 복원하지 못할 때:
  - 복원 경로가 `/mnt/disk/BIN/ROOT` 하위 SafeShell 미러 휴지통 레이아웃과 일치하는지 확인하세요.

- `repo2text` 스크립트 실행 결과가 없을 때:
  - `convert-repo-to-merged-text.py`의 `source_directory`를 실제 존재하는 폴더로 수정하세요.

## 로드맵

- 모든 i18n 파일에서 루트 README와 동등한 수준으로 내용 확장(현재 다수 언어는 요약 중심).
- Waveshare e-ink 드라이버용 환경별 설정 문서 추가.
- 로컬 도구용 루트 레벨 재현 가능한 의존성 매니페스트 추가.
- 핵심 유틸리티 검증/테스트 스크립트 추가.
- 외부 프로젝트 링크를 더 풍부한 로컬 데모와 함께 계속 정리.

## 소개

The Art of Lazying은 에너지를 최적화하고 정말 중요한 것에 집중하기 위한 방법으로 전략적 게으름을 제시합니다. 이 저장소는 의도적인 게으름이 생산성, 창의성, 웰빙을 어떻게 높일 수 있는지 탐구합니다.

## 게으름 이론

우선순위화, 위임, 자동화에 집중해 생산성과 웰빙을 극대화하는 전략적 게으름 원칙을 종합적으로 소개합니다.

핵심 원리는 일상에 파레토 80/20 법칙을 적용하는 것입니다. 즉, 원하는 결과의 80%를 만드는 20% 활동을 식별하는 데 초점을 둡니다.

## 실용 팁과 트릭

일, 관계, 셀프케어에 게으름 원칙을 적용하기 위한 실행 가능한 조언 모음:
- 반복 작업 자동화
- 시간 관리를 위한 포모도로 기법 활용
- 의사결정 피로를 줄이는 시스템 구축
- 보조 도구로서 AI 활용

## 활용 사례

게으름 원칙이 문제를 해결하고 효율을 개선하는 실제 사례:
- 창업가가 위임과 자동화로 비즈니스 성장에 집중하는 방법
- 연구자가 리서치 워크플로를 간소화하는 방법
- 콘텐츠 제작자가 제작 과정을 최적화하는 방법

## AI 에이전트와 자동화

작업을 단순화하는 AI 에이전트/자동화 도구 개발 탐색:
- 개인 비서로 ChatGPT 활용
- 맞춤 자동화 워크플로 구축
- 수동 학습을 위한 e-ink 디스플레이 제작

## 언어 학습과 브이로그

효율적인 언어 학습 리소스와 기법, 그리고 lazying 여정을 기록한 브이로그:
- 간격 반복 기반 개인화 언어 학습 설계
- 몰입형 학습 기법 구현
- 수동 학습을 촉진하는 프로젝트 구축

## 커뮤니티 기여

전략적 게으름에 대한 본인의 경험, 팁, 아이디어를 공유하세요:
- 생산성 해킹 교류 포럼
- 일상 루틴용 도구와 템플릿
- 게으른 효율성을 위한 협업 프로젝트

## 연결

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## 지원 / 기부

<div align="center">
<table style="margin:0 auto; text-align:center; border-collapse:collapse;">
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate">https://chat.lazying.art/donate</a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate"><img src="figs/donate_button.svg" alt="Donate" height="44"></a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://paypal.me/RongzhouChen">
        <img src="https://img.shields.io/badge/PayPal-Donate-003087?logo=paypal&logoColor=white" alt="Donate with PayPal">
      </a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400">
        <img src="https://img.shields.io/badge/Stripe-Donate-635bff?logo=stripe&logoColor=white" alt="Donate with Stripe">
      </a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>WeChat</strong></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>Alipay</strong></td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="WeChat QR" src="figs/donate_wechat.png" width="240"/></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="Alipay QR" src="figs/donate_alipay.png" width="240"/></td>
  </tr>
</table>
</div>

`.github/FUNDING.yml`의 추가 후원 링크:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## 기여하기

코드, 문서, 예시, 번역 전반에서 기여를 환영합니다.

1. 저장소를 포크합니다.
2. 브랜치를 생성합니다(`git checkout -b feature/your-feature`).
3. 명확한 커밋 메시지와 함께 변경합니다.
4. 동기와 영향도를 설명하는 Pull Request를 엽니다.

시작점이 막막하다면:
- 로컬 도구의 설정 문서를 개선하세요.
- 기존 유틸리티에 테스트 또는 검증 스크립트를 추가하세요.
- `i18n/README.*.md` 변형 하나의 내용 동등성/품질을 개선하세요.

## 라이선스

이 저장소는 루트(`LICENSE`) 및 여러 하위 폴더에 GPLv3 라이선스 텍스트를 포함합니다.

참고: 일부 서브프로젝트 README에는 MIT가 언급됩니다. 각 서브모듈이 명확해질 때까지 루트 저장소는 GPLv3 지배로 간주하고, 코드를 독립적으로 재배포할 계획이라면 서브프로젝트별 라이선스를 확인하세요.
