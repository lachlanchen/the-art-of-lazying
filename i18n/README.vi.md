[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Lưu ý: Kho lưu trữ này đã được chuyển sang địa điểm mới. Việc phát triển đang tiếp tục tại https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

Kho lưu trữ này đề xuất tư duy "lazying" có tính chiến lược để sống tối giản và hiệu quả hơn, bao gồm AI agents, học ngôn ngữ và vlog với các mẹo thực tế cùng các trường hợp dùng trong cuộc sống.

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

## Liên kết nhanh

| Nhu cầu | Bắt đầu từ đây |
|---|---|
| Duyệt bản đồ nội dung chính | [Tổng quan](#tổng-quan) |
| Cài đặt các phụ thuộc | [Điều kiện tiên quyết](#điều-kiện-tiên-quyết) |
| Chạy ví dụ | [Sử dụng](#sử-dụng) |
| Sửa lỗi thường gặp | [Khắc phục sự cố](#khắc-phục-sự-cố) |
| Tham gia đóng góp | [Đóng góp](#đóng-góp) |

## Tổng quan

`the-art-of-lazying-legacy` là một kho lưu trữ dạng umbrella được chọn lọc xoay quanh triết lý lười biếng chiến lược:

- Nội dung khái niệm về việc áp dụng triết lý "lazying" vào công việc và cuộc sống.
- Tài nguyên mã thực tế, trong đó có học ngôn ngữ với e-ink + GPT (`code/EinkWordsGPT`).
- Script tiện ích cho quy trình làm việc an toàn hơn (`scripts/lazy-care/SafeShell`).
- Công cụ phụ trợ cho vlog và các đoạn tự động hóa (`vlogs/`).
- Tài sản demo và ví dụ (`demos/`, `examples/`, `figs/`).

| Ảnh chụp nhanh | Giá trị |
|---|---|
| Vai trò của kho | Lưu trữ legacy + bản đồ ý tưởng |
| Phát triển đang hoạt động | https://github.com/lachlanchen/the-art-of-lazying |
| README đa ngôn ngữ | `README.md`, `README_CN.md`, `README_EN.md` |
| Thư mục i18n | `i18n/` (đang có) |
| Học ngôn ngữ | Lặp lại giãn cách + quy trình GPT |
| Trọng tâm tự động hóa | Script, phụ đề, xuất bản và quy trình phần cứng |

Kho lưu trữ này vẫn hữu ích như một kho lưu trữ kế thừa và bản đồ ý tưởng, trong khi phát triển tích cực đã chuyển sang kho đã di chuyển ở liên kết bên trên.

---

## Dự án

### 🤖 Công cụ sáng tạo dựa trên AI

| Dự án | Mô tả | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Màn hình e-ink với học từ vựng nhờ GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Phân tích nguồn gốc từ vựng và hiển thị dạng đồ thị. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Công cụ học ngôn ngữ hiệu quả với chi phí công sức tối thiểu | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Tạo chú thích video và ảnh với embedding OpenAI CLIP + GPT decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Công cụ chú thích video: trích key-frame bằng Katna/OpenCV và tạo chú thích bằng mô hình ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline phiên âm đa ngôn ngữ với phát hiện ngôn ngữ chi tiết | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Xóa rào cản ngôn ngữ cho trao đổi sáng tạo toàn cầu | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Tự động sinh metadata cho video | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Công cụ chỉnh sửa video tự động dùng AI với phiên âm, phụ đề tự động, nổi bật nội dung và sinh metadata | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Chuẩn hóa quy trình xuất bản nội dung | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Hệ thống tự động giám sát, xử lý và xuất bản video trên nhiều nền tảng | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Kỹ thuật nâng cao để sử dụng AI assistants hiệu quả | |

## Công cụ tự động hóa

Kho lưu trữ này gồm các tiện ích tự động hóa có thể chạy trực tiếp cục bộ:

| Đường dẫn | Mục đích |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Vòng lặp hiển thị thẻ từ e-ink liên tục (mặc định làm mới mỗi 300 giây). |
| `code/EinkWordsGPT/words_update.py` | Làm mới chi tiết từ theo lô và chọn lọc dựa trên logic hỗ trợ bởi OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Kiểm thử phần cứng e-paper Waveshare 7.3". |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Các hàm shell `saferm`, `unrm`, và `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Phân giải tên miền sang IP + đầu ra đã loại trừ bản sao. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Gộp các file `.py` theo từng thư mục con thành file `.txt`. |

## Cấu trúc thư mục

### Cấu trúc hiện tại của kho (chính xác)

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

> Lưu ý: Bản đồ khái niệm ở trên được giữ nguyên cố ý từ các phiên bản README trước đó. Khối "Cấu trúc hiện tại của kho" phản ánh cấu trúc cây thực tế của repo legacy này.

## Giới thiệu

The Art of Lazying trình bày lối sống lười biếng chiến lược như một cách tối ưu hóa năng lượng và tập trung vào những gì thực sự quan trọng. Kho này khám phá cách lười biếng có mục đích có thể dẫn đến năng suất, sáng tạo và sự cân bằng tốt hơn.

## Lý thuyết về Lazying

Một lời giới thiệu toàn diện về các nguyên tắc của lười biếng chiến lược, tập trung vào cách tối đa hóa năng suất và sự cân bằng bằng cách ưu tiên, ủy quyền và tự động hóa công việc.

Nguyên tắc chính là áp dụng quy tắc Pareto 80/20 vào đời sống hàng ngày — nhận diện 20% hoạt động tạo ra 80% kết quả mong muốn.

## Mẹo và thủ thuật thực tế

Tập hợp những lời khuyên dễ áp dụng để đưa nguyên tắc lazying vào công việc, các mối quan hệ và chăm sóc bản thân:

- Tự động hóa các tác vụ lặp đi lặp lại
- Sử dụng kỹ thuật Pomodoro để quản lý thời gian
- Tạo hệ thống giảm mệt mỏi quyết định
- Tận dụng công cụ AI để hỗ trợ công việc

## Trường hợp sử dụng

Ví dụ thực tế cho thấy các nguyên tắc lazying giải quyết vấn đề và cải thiện hiệu suất:

- Doanh nhân dùng ủy quyền và tự động hóa để tập trung tăng trưởng kinh doanh
- Nghiên cứu viên tối ưu quy trình nghiên cứu
- Nhà sáng tạo nội dung tối ưu quy trình sản xuất

## AI Agents và tự động hóa

Khám phá phát triển AI agents và công cụ tự động hóa giúp đơn giản hóa công việc:

- Dùng ChatGPT như trợ lý cá nhân
- Xây dựng quy trình tự động hóa tùy biến
- Tạo thiết bị e-ink cho học tập thụ động

## Học ngôn ngữ và vlog

Tài nguyên và kỹ thuật học ngôn ngữ hiệu quả, cùng các vlog ghi lại hành trình lazying:

- Tạo học ngôn ngữ cá nhân hóa với lặp lại ngắt quãng
- Triển khai các kỹ thuật học nhập vai
- Xây dựng dự án giúp khuyến khích học tập thụ động

## Đóng góp cộng đồng

Chia sẻ kinh nghiệm, mẹo và ý tưởng của bạn về lười biếng chiến lược:

- Diễn đàn trao đổi về các mẹo năng suất
- Công cụ và mẫu cho thói quen hàng ngày
- Các dự án hợp tác để tăng hiệu quả theo hướng "lazy"

## Điều kiện tiên quyết

Kho lưu trữ chứa nhiều script độc lập, nên điều kiện tiên quyết khác nhau tùy module.

Cơ sở chung:

- Python 3.9+
- `pip`
- Git

Yêu cầu riêng theo module (được rút ra từ source files):

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (cho các luồng phần cứng e-paper)
- `sqlite3` (thư viện chuẩn)

Yêu cầu phần cứng để chạy toàn bộ `EinkWordsGPT`:

- Raspberry Pi (tài liệu dự án đề cập Raspberry Pi 5)
- Màn hình e-ink Waveshare 7 màu 7.3 inch

## Cài đặt

Vì không có manifest phụ thuộc ở root, hãy cài thủ công các phụ thuộc cho module bạn muốn chạy.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Phụ thuộc tùy chọn/phần cứng:

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

### 3) Kiểm tra panel Waveshare 7.3 inch

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Phân giải domain liên quan ChatGPT và in IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Gộp các file Python theo thư mục cho bộ văn bản thân thiện AI

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

### Thông tin xác thực OpenAI

`EinkWordsGPT` và các script cập nhật dùng `OpenAI()` từ SDK chính thức và yêu cầu cấu hình thông tin xác thực trong môi trường của bạn.

Giả định (khuyến nghị):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Vị trí cơ sở dữ liệu

`code/EinkWordsGPT/words_gpt.py` và `words_update.py` dùng:

- `db_path = 'words_phonetics.db'`

Chạy script từ `code/EinkWordsGPT` hoặc cập nhật đường dẫn nếu khởi chạy từ nơi khác.

### Nền tảng rác của SafeShell

`saferm`/`unrm`/`removeitanyway` hiện đang dùng một đường dẫn gốc cố định:

- `/mnt/disk/BIN/ROOT`

Đảm bảo đường dẫn này tồn tại và có quyền ghi trước khi dùng `saferm`.

### Đường dẫn Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` hiện có các path cố định:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Chỉnh sửa các hằng số này cho khớp dự án cục bộ của bạn.

## Ví dụ

### Ví dụ: Chu kỳ thẻ học e-ink

- Script chọn (hoặc lấy) chi tiết từ.
- Thẻ từ hiển thị phiên âm, phân tách âm tiết và gợi ý đồng nghĩa tiếng Nhật.
- Màn hình làm mới mỗi 5 phút (`time.sleep(300)`).

### Ví dụ: Quy trình xóa an toàn

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Ví dụ: File đầu ra Domain/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Ghi chú phát triển

- Đây là một repository legacy; phát triển đang được tiếp tục tại: https://github.com/lachlanchen/the-art-of-lazying
- Nội dung cấp cao là tổng hợp và liên kết tới nhiều kho bên ngoài.
- `i18n/` đã tồn tại nhưng trước đây được ghi là trống; hiện nay hiện có README theo nhiều ngôn ngữ.
- Không có `requirements.txt` gốc hoặc `pyproject.toml` tại root.

Ghi chú tương thích được giữ lại:

- Tài liệu trước đây trong các thư mục con có thể nhắc đến các script (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) hiện đã được gom vào `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Khắc phục sự cố

- `ModuleNotFoundError`: Cài đặt các package Python còn thiếu như trong [Điều kiện tiên quyết](#điều-kiện-tiên-quyết).
- Lỗi xác thực `openai`: xác nhận `OPENAI_API_KEY` đã được export trong shell.
- Vấn đề runtime trên Waveshare: kiểm tra thiết lập SPI/device và cài dependency hãng trên Pi.
- `saferm` không làm gì: kiểm tra `/mnt/disk/BIN/ROOT` có tồn tại và có quyền ghi.
- `repo2text` không tạo file: đảm bảo `source_directory` trỏ vào thư mục có file `.py`.
- Bất thường domain của `chatgpt-traffic`: kiểm tra và dọn danh sách `domains` trong script trước khi đưa vào môi trường production.

## Lộ trình

- Giữ kho này như một kho lưu trữ kế thừa ổn định với các liên kết rõ ràng đến dự án đang hoạt động.
- Cải thiện manifest phụ thuộc cho từng module có thể chạy.
- Thêm bố cục i18n nhất quán trong `/i18n` cho các bản cập nhật sau.
- Mở rộng ví dụ thực tế và hướng dẫn cài đặt tái lập cho luồng có phần cứng và không có phần cứng.

## Đóng góp

Đóng góp là rất hoan nghênh.

1. Fork repository.
2. Tạo branch tính năng của bạn (`git checkout -b feature/AmazingFeature`).
3. Commit thay đổi (`git commit -m 'Add some AmazingFeature'`).
4. Push lên branch (`git push origin feature/AmazingFeature`).
5. Tạo Pull Request.

Bạn cũng có thể đóng góp bằng cách:

- Đề xuất cải tiến cho quy trình làm việc lazying chiến lược.
- Báo lỗi trong script hoặc tài liệu.
- Cải thiện khả năng tái lập cài đặt cho các đường dẫn phần cứng/phần mềm.

## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |

## License

This repository is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE).

## Lời cảm ơn

Xin gửi lời cảm ơn đặc biệt đến cộng đồng đóng góp, đội ngũ OpenAI và cộng đồng Raspberry Pi / maker đã hỗ trợ thử nghiệm các hệ thống học tập ít ma sát.

## Kết nối

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
