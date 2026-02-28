[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> Lưu ý: Kho lưu trữ này đã được di chuyển. Việc phát triển đang diễn ra tại https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

Một kho lưu trữ thúc đẩy sự lười biếng có chiến lược để có cuộc sống đơn giản và hiệu quả hơn, bao gồm AI agents, học ngôn ngữ và vlog với các mẹo thực tiễn cùng tình huống sử dụng ngoài đời thực.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Mục lục

- [Tổng quan](#tổng-quan)
- [Dự án](#dự-án)
- [Công cụ tự động hóa](#công-cụ-tự-động-hóa)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Giới thiệu](#giới-thiệu)
- [Lý thuyết về Lazying](#lý-thuyết-về-lazying)
- [Mẹo và thủ thuật thực tế](#mẹo-và-thủ-thuật-thực-tế)
- [Trường hợp sử dụng](#trường-hợp-sử-dụng)
- [AI Agents và tự động hóa](#ai-agents-và-tự-động-hóa)
- [Học ngôn ngữ và vlog](#học-ngôn-ngữ-và-vlog)
- [Đóng góp cộng đồng](#đóng-góp-cộng-đồng)
- [Điều kiện tiên quyết](#điều-kiện-tiên-quyết)
- [Cài đặt](#cài-đặt)
- [Sử dụng](#sử-dụng)
- [Cấu hình](#cấu-hình)
- [Ví dụ](#ví-dụ)
- [Ghi chú phát triển](#ghi-chú-phát-triển)
- [Khắc phục sự cố](#khắc-phục-sự-cố)
- [Lộ trình](#lộ-trình)
- [Đóng góp](#đóng-góp)
- [Giấy phép](#giấy-phép)
- [Lời cảm ơn](#lời-cảm-ơn)
- [Kết nối](#kết-nối)

## Tổng quan

`the-art-of-lazying-legacy` là một kho umbrella được tuyển chọn xoay quanh triết lý lười biếng có chiến lược:

- Nội dung mang tính khái niệm về cách áp dụng triết lý "lazying" vào công việc và cuộc sống.
- Các hiện vật mã nguồn thực tiễn, bao gồm học ngôn ngữ bằng e-ink + GPT (`code/EinkWordsGPT`).
- Script tiện ích cho quy trình an toàn hơn (`scripts/lazy-care/SafeShell`).
- Công cụ phía vlog và các đoạn tự động hóa (`vlogs/`).
- Tài nguyên demo và ví dụ (`demos/`, `examples/`, `figs/`).

| Snapshot | Value |
|---|---|
| Repository role | Legacy archive + idea map |
| Active development | https://github.com/lachlanchen/the-art-of-lazying |
| Multilingual README files | `README.md`, `README_CN.md`, `README_EN.md` |
| i18n directory | `i18n/` (present) |

Kho lưu trữ này vẫn hữu ích như một kho lưu trữ kế thừa và bản đồ ý tưởng, trong khi việc phát triển chủ động đã chuyển sang kho đã di chuyển ở liên kết phía trên.

## Dự án

### 🤖 Công cụ sáng tạo dùng AI

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

## Công cụ tự động hóa

Kho này bao gồm các tiện ích tự động hóa cục bộ có thể chạy trực tiếp:

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Continuous e-ink word-card rendering loop (default refresh every 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch and targeted word detail refresh against OpenAI-backed logic. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3" e-paper hardware test. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, and `removeitanyway` shell functions. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Domain-to-IP resolution + deduplicated output. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Merge `.py` files by subdirectory into `.txt` files. |

## Cấu trúc thư mục

### Cấu trúc kho hiện tại (chính xác)

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

### Cấu trúc khái niệm ban đầu (được giữ lại)

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

> Lưu ý: Bản đồ khái niệm ở trên được giữ nguyên có chủ đích từ các phiên bản README trước. Khối "Current Repository Structure" phản ánh cây thư mục cụ thể trong kho lưu trữ kế thừa này.

## Giới thiệu

The Art of Lazying trình bày sự lười biếng có chiến lược như một cách tối ưu hóa năng lượng và tập trung vào những gì thực sự quan trọng. Kho này khám phá cách lười biếng có chủ đích có thể dẫn tới năng suất cao hơn, sáng tạo hơn và hạnh phúc hơn.

## Lý thuyết về Lazying

Phần giới thiệu toàn diện về các nguyên tắc của lười biếng có chiến lược, tập trung vào cách tối đa hóa năng suất và sức khỏe tinh thần bằng cách ưu tiên, ủy quyền và tự động hóa công việc.

Nguyên tắc cốt lõi là áp dụng quy tắc 80/20 của Pareto vào đời sống hằng ngày - xác định 20% hoạt động tạo ra 80% kết quả mong muốn.

## Mẹo và thủ thuật thực tế

Bộ lời khuyên có thể áp dụng ngay về cách áp dụng các nguyên tắc lazy vào công việc, quan hệ và chăm sóc bản thân:

- Tự động hóa các tác vụ lặp lại
- Sử dụng Pomodoro Technique để quản lý thời gian
- Tạo hệ thống giúp giảm mệt mỏi khi ra quyết định
- Tận dụng công cụ AI để hỗ trợ

## Trường hợp sử dụng

Các ví dụ đời thực cho thấy nguyên lý lazying giải quyết vấn đề và cải thiện hiệu quả như thế nào:

- Cách doanh nhân dùng ủy quyền và tự động hóa để tập trung tăng trưởng kinh doanh
- Cách giới học thuật tinh gọn quy trình nghiên cứu
- Cách nhà sáng tạo nội dung tối ưu hóa quy trình sản xuất

## AI Agents và tự động hóa

Khám phá việc phát triển AI agents và công cụ tự động hóa để đơn giản hóa tác vụ:

- Dùng ChatGPT như trợ lý cá nhân
- Xây dựng quy trình tự động hóa tùy chỉnh
- Tạo màn hình e-ink cho học thụ động

## Học ngôn ngữ và vlog

Tài nguyên và kỹ thuật học ngôn ngữ hiệu quả, cùng vlog ghi lại hành trình lazying:

- Tạo học ngôn ngữ cá nhân hóa với spaced repetition
- Triển khai kỹ thuật học nhập vai
- Xây dựng dự án khuyến khích học thụ động

## Đóng góp cộng đồng

Hãy chia sẻ trải nghiệm, mẹo và ý tưởng của bạn về lười biếng có chiến lược:

- Diễn đàn trao đổi mẹo tăng năng suất
- Công cụ và mẫu cho thói quen hằng ngày
- Dự án cộng tác cho hiệu quả kiểu lazy

## Điều kiện tiên quyết

Kho này chứa nhiều script độc lập, vì vậy điều kiện tiên quyết thay đổi theo từng mô-đun.

Nền tảng chung:

- Python 3.9+
- `pip`
- Git

Tín hiệu theo dự án từ file nguồn:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (for e-paper hardware flows)
- `sqlite3` (standard library)

Yêu cầu phần cứng cho runtime `EinkWordsGPT` đầy đủ:

- Raspberry Pi (project docs mention Raspberry Pi 5)
- Waveshare 7-color 7.3-inch e-ink panel

## Cài đặt

Do không có manifest dependency ở thư mục gốc, hãy cài dependency thủ công cho mô-đun bạn muốn chạy.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Dependency tùy chọn/phần cứng:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

Thiết lập SafeShell:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Sử dụng

### 1) Chạy vòng lặp hiển thị EinkWordsGPT

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Kiểm tra/cập nhật lại chi tiết từ

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Kiểm tra panel Waveshare 7.3-inch

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Phân giải domain liên quan ChatGPT và xuất IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Gộp file Python theo thư mục để tạo gói văn bản thân thiện cho AI

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Dùng quy trình xóa file an toàn hơn

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Cấu hình

### OpenAI Credentials

`EinkWordsGPT` và các script cập nhật dùng `OpenAI()` từ SDK chính thức và yêu cầu thông tin xác thực được cấu hình trong môi trường của bạn.

Giả định (khuyến nghị):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Vị trí cơ sở dữ liệu

`code/EinkWordsGPT/words_gpt.py` và `words_update.py` sử dụng:

- `db_path = 'words_phonetics.db'`

Hãy chạy script từ `code/EinkWordsGPT` hoặc cập nhật đường dẫn nếu chạy từ nơi khác.

### SafeShell Trash Root

`saferm`/`unrm`/`removeitanyway` hiện dùng đường dẫn gốc cố định:

- `/mnt/disk/BIN/ROOT`

Đảm bảo đường dẫn này tồn tại và có quyền ghi trước khi phụ thuộc vào `saferm`.

### Repo2Text Paths

`vlogs/repo2text/convert-repo-to-merged-text.py` hiện có các đường dẫn hard-code:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Hãy sửa các hằng số này cho phù hợp với dự án cục bộ của bạn.

## Ví dụ

### Ví dụ: Vòng lặp thẻ học e-ink

- Script chọn (hoặc tải về) chi tiết từ.
- Thẻ từ hiển thị phiên âm, tách âm tiết và gợi ý từ đồng nghĩa tiếng Nhật.
- Màn hình làm mới mỗi 5 phút (`time.sleep(300)`).

### Ví dụ: Quy trình xóa an toàn

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Ví dụ: File đầu ra domain/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Ghi chú phát triển

- Đây là kho lưu trữ kế thừa; việc phát triển chủ động ở: https://github.com/lachlanchen/the-art-of-lazying
- Nội dung cấp cao nhất mang tính tuyển chọn và liên kết tới nhiều kho bên ngoài.
- `i18n/` tồn tại nhưng hiện đang trống; các README ngôn ngữ hiện đang nằm ở cấp cao nhất.
- Không có `requirements.txt` hoặc `pyproject.toml` ở thư mục gốc.

Ghi chú tương thích được giữ lại:

- Tài liệu cũ hơn trong các thư mục con có thể nhắc đến các script (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) nay đã được hợp nhất vào `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Khắc phục sự cố

- `ModuleNotFoundError`: Cài các gói Python còn thiếu được liệt kê trong [Điều kiện tiên quyết](#điều-kiện-tiên-quyết).
- Lỗi xác thực `openai`: xác nhận `OPENAI_API_KEY` đã được export trong shell.
- Lỗi runtime Waveshare: xác minh cấu hình SPI/device và cài dependency của nhà cung cấp trên Pi.
- `saferm` có vẻ không làm gì: kiểm tra `/mnt/disk/BIN/ROOT` có tồn tại và có quyền ghi.
- `repo2text` không tạo file: đảm bảo `source_directory` trỏ đến thư mục hiện có chứa file `.py`.
- Bất thường domain của `chatgpt-traffic`: rà soát và làm sạch danh sách `domains` trong script trước khi dùng production.

## Lộ trình

- Giữ kho này như một kho lưu trữ kế thừa ổn định với chỉ dẫn rõ ràng tới các dự án đang hoạt động.
- Cải thiện manifest dependency cho từng submodule có thể chạy.
- Thêm bố cục i18n nhất quán dưới `/i18n` trong các bản sửa đổi tương lai.
- Mở rộng ví dụ thực tế và hướng dẫn thiết lập có thể tái lập cho cả luồng phần cứng và không phần cứng.

## Đóng góp

Rất hoan nghênh đóng góp.

1. Fork dự án.
2. Tạo nhánh tính năng (`git checkout -b feature/AmazingFeature`).
3. Commit thay đổi (`git commit -m 'Add some AmazingFeature'`).
4. Push lên nhánh (`git push origin feature/AmazingFeature`).
5. Mở Pull Request.

Bạn cũng có thể đóng góp bằng cách:

- Đề xuất cải tiến cho quy trình làm việc lười biếng có chiến lược.
- Báo cáo lỗi trong script hoặc tài liệu.
- Cải thiện khả năng tái lập cài đặt cho các luồng phần cứng/phần mềm.

## Giấy phép

Kho này được cấp phép theo GNU General Public License v3.0. Xem [LICENSE](LICENSE).

## Lời cảm ơn

Xin cảm ơn các cộng tác viên, đội ngũ OpenAI và cộng đồng Raspberry Pi / maker đã hỗ trợ các thử nghiệm xoay quanh hệ thống học tập ma sát thấp.

## Kết nối

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
