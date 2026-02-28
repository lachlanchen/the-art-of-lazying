[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# Nghệ thuật lười biếng

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

Kho lưu trữ tập trung vào chủ đề lười biếng chiến lược để có cuộc sống đơn giản hơn, hiệu suất cao hơn, bao gồm AI agents, học ngôn ngữ, tự động hóa thực tế và quy trình làm việc dựa trên vlog ngoài đời thực.

| Mục tiêu | Nội dung README này | 
|---|---|
| 🤖 Tự động hóa | Công cụ nền tảng, scripts, và quy trình thực tế có thể chạy trực tiếp tại máy cục bộ |
| 🧠 Học tập | Các dự án ưu tiên ngôn ngữ và ví dụ cho thói quen học hiệu quả |
| 📚 Chia sẻ | Tài liệu đa ngôn ngữ, liên kết dự án, và hướng dẫn đóng góp |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Mục lục

- [Tổng quan](#tổng-quan)
- [Dự án](#dự-án)
- [Cấu trúc kho lưu trữ](#cấu-trúc-kho-lưu-trữ)
- [Tính năng](#tính-năng)
- [Điều kiện tiên quyết](#điều-kiện-tiên-quyết)
- [Cài đặt](#cài-đặt)
- [Cách sử dụng](#cách-sử-dụng)
- [Cấu hình](#cấu-hình)
- [Ví dụ](#ví-dụ)
- [Ghi chú phát triển](#ghi-chú-phát-triển)
- [Khắc phục sự cố](#khắc-phục-sự-cố)
- [Lộ trình](#lộ-trình)
- [Giới thiệu](#giới-thiệu)
- [Lý thuyết của lười biếng](#lý-thuyết-của-lười-biếng)
- [Mẹo thực tế](#mẹo-thực-tế)
- [Tình huống sử dụng](#tình-huống-sử-dụng)
- [AI Agents và tự động hóa](#ai-agents-và-tự-động-hóa)
- [Học ngôn ngữ và vlog](#học-ngôn-ngữ-và-vlog)
- [Đóng góp cộng đồng](#đóng-góp-cộng-đồng)
- [Hỗ trợ](#-support)
- [Kết nối](#kết-nối)
- [Đóng góp](#đóng-góp)
- [Giấy phép](#giấy-phép)

## Tổng quan

`the-art-of-lazying` là kho trung tâm cho lười biếng chiến lược trong thực tế: tự động hóa công việc lặp lại, cải thiện quy trình học ngôn ngữ, và ghi lại thử nghiệm thực tiễn thông qua scripts và vlog.

| Tổng quan nhanh | Chi tiết |
|---|---|
| 🎯 Chủ đề cốt lõi | Lười biếng chiến lược để tăng năng suất, học tập và năng lực sáng tạo |
| 🧩 Phong cách kho | Kết hợp công cụ local + bộ sưu tập dự án bên ngoài được tuyển chọn |
| 🛠️ Điểm nổi bật local | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Tài liệu | README gốc + biến thể đa ngôn ngữ trong `i18n/` |

Kho này bao gồm cả:
- Liên kết chọn lọc đến các dự án bên ngoài liên quan.
- Mã và công cụ local, cụ thể là:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + hiển thị học từ vựng hỗ trợ OpenAI).
  - `scripts/lazy-care/SafeShell` (các hàm shell xóa/khôi phục an toàn).
  - `vlogs/chatgpt-traffic` và `vlogs/repo2text` (các tiện ích Python nhỏ).

## Dự án

### 🚀 Công cụ sáng tạo hỗ trợ AI

| Dự án | Mô tả | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Màn hình e-ink với học từ vựng do GPT hỗ trợ | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Phân tích nguồn gốc từ và trình bày theo dạng đồ thị | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Công cụ học ngôn ngữ hiệu quả với tối thiểu nỗ lực | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Chú thích video và hình ảnh bằng OpenAI CLIP embeddings + GPT decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Công cụ phụ đề video: trích xuất khung hình chính bằng Katna/OpenCV và tạo chú thích bằng mô hình ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline phiên âm đa ngôn ngữ với nhận diện ngôn ngữ chi tiết | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Loại bỏ rào cản ngôn ngữ để tăng cường trao đổi sáng tạo toàn cầu | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Tự động tạo metadata cho video | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Công cụ chỉnh sửa video tự động bằng AI với phiên âm, phụ đề tự động, highlight, và sinh metadata | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Tinh gọn quy trình phát hành nội dung | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Hệ thống tự động theo dõi, xử lý và xuất bản nội dung video lên nhiều nền tảng | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Kỹ thuật nâng cao để dùng hiệu quả trợ lý AI | |

### ⚙️ Công cụ tự động hóa (local trong kho này)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: xóa shell an toàn hơn (`saferm`), khôi phục (`unrm`) và xóa vĩnh viễn có chủ đích (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: tra cứu domain thành IP và sinh đầu ra đã loại bỏ trùng lặp.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: gộp file Python theo thư mục thành gói văn bản để hỗ trợ phân tích bằng AI.

## Cấu trúc kho lưu trữ

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

Lưu ý: Các sơ đồ thư mục tổng quát trong một số phiên bản README trước đó có tham chiếu đường dẫn trừu tượng (ví dụ `book/`, `code/ai-agents/`) không khớp hoàn toàn với cấu trúc kho hiện tại. Cấu trúc trên phản ánh đúng file hiện có.

## Tính năng

- Khung lười biếng chiến lược nhằm tối ưu năng suất, học tập và nội dung.
- Danh mục dự án AI được chọn lọc trải rộng từ phiên âm, phụ đề, dịch thuật đến tự động hóa xuất bản.
- Học ngôn ngữ tích hợp phần cứng với chọn từ hỗ trợ GPT (`EinkWordsGPT`).
- Công cụ shell an toàn cho quy trình xóa có thể khôi phục.
- Tiện ích script-first cho kiểm tra DNS/domain traffic và chuyển đổi repo thành văn bản.
- Hỗ trợ tài liệu đa ngôn ngữ qua `i18n/`.

## Điều kiện tiên quyết

Chung:
- Git
- Python 3.9+ (khuyến nghị)

Đối với `code/EinkWordsGPT`:
- Raspberry Pi (tài liệu dự án đề cập Raspberry Pi 5)
- Màn hình e-ink 7.3 inch 7 màu của Waveshare với hỗ trợ driver Python (`waveshare_epd`)
- Các gói Python dùng trong mã: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (mã sử dụng `sqlite3` trong Python stdlib)
- OpenAI API key được cấu hình trong môi trường (mã khởi tạo `OpenAI()` trực tiếp)

Đối với `vlogs/chatgpt-traffic`:
- `dnspython`

Đối với `scripts/lazy-care/SafeShell`:
- Shell Bash hoặc Zsh có thể dùng `realpath`, `mv`, và `/bin/rm`

## Cài đặt

Clone repository:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Cài đặt các dependency Python dùng phổ biến (baseline toàn repo):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Lưu ý: `code/EinkWordsGPT/README.md` đề cập `requirements.txt`, nhưng hiện tại repository chưa có file `requirements.txt`. Hãy cài thủ công như bên trên.

## Cách sử dụng

### 1) EinkWordsGPT (luồng phần cứng local)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

Script bảo trì cơ sở dữ liệu tùy chọn:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (quy trình xóa an toàn)

Nạp shell functions:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

Sử dụng các lệnh:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Trình giải quyết ChatGPT Traffic

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Công cụ gộp repo thành text

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Lưu ý: `convert-repo-to-merged-text.py` hiện đang dùng đường dẫn hardcoded (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Hãy chỉnh sửa các hằng này trước khi chạy cho repository khác.

## Cấu hình

### Cấu hình OpenAI (`code/EinkWordsGPT`)

Mã tạo client với:

```python
client = OpenAI()
```

Vì vậy, hãy cấu hình credentials của API theo cách chuẩn bằng biến môi trường OpenAI trước khi chạy script.

### Đường dẫn cơ sở dữ liệu (`code/EinkWordsGPT`)

Mặc định trong mã:

```python
db_path = 'words_phonetics.db'
```

Đảm bảo `words_phonetics.db` tồn tại trong `code/EinkWordsGPT/` (nó đang được kèm sẵn trong repository này).

### Vị trí thùng rác SafeShell

`saferm`/`unrm`/`removeitanyway` dùng một đường dẫn gốc cố định:

```bash
/mnt/disk/BIN/ROOT
```

Điều chỉnh đường dẫn này trong `scripts/lazy-care/SafeShell/safeshell_functions.sh` nếu môi trường của bạn khác.

## Ví dụ

- Các demo thẻ từ vựng e-ink trong `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Ghi chú/nguyên liệu build cho ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Ghi chú phát triển

- Đây là một repo trình diễn nhiều dự án, kết hợp cả mã local và liên kết dự án ngoài.
- Không có package manager hoặc build manifest cấp root hiện tại (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` đều chưa có ở root).
- Một số README con có tính chất template và có thể đã lỗi thời so với cấu trúc file hiện tại; các lệnh trong README này đã căn chỉnh theo đường dẫn/script đang tồn tại.
- `README_EN.md` và `README_CN.md` là biến thể kế thừa; cấu trúc đa ngôn ngữ đang hoạt động là `README.md` + `i18n/*`.

## Khắc phục sự cố

- `ModuleNotFoundError` cho các gói Python:
  - Cài lại dependencies với `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` trong `EinkWordsGPT`:
  - Cài driver/thư viện e-paper Waveshare cho môi trường Raspberry Pi của bạn.

- Lỗi xác thực OpenAI:
  - Kiểm tra OpenAI API key đã được đặt trong biến môi trường trước khi chạy `words_gpt.py` hoặc `words_update.py`.

- `saferm`/`unrm` không tìm thấy sau khi thiết lập:
  - Kiểm tra đã source đúng shell rc file và `safeshell_functions.sh` đã được nạp thành công.

- `unrm` không thể khôi phục file:
  - Kiểm tra xem đường dẫn khôi phục có khớp layout thùng rác mirror của SafeShell dưới `/mnt/disk/BIN/ROOT`.

- Script `repo2text` không tạo ra output:
  - Cập nhật `source_directory` trong `convert-repo-to-merged-text.py` thành thư mục có thực.

## Lộ trình

- Mở rộng độ tương đương nội dung README gốc cho toàn bộ file i18n (hiện nhiều ngôn ngữ mới ở mức tóm tắt).
- Bổ sung tài liệu setup theo môi trường riêng cho driver Waveshare e-ink.
- Thêm manifest dependency tái lập được cho các công cụ local ở cấp root.
- Thêm scripts validation/testing cho các tiện ích quan trọng.
- Tiếp tục hợp nhất các liên kết dự án bên ngoài với demo local phong phú hơn.

## Giới thiệu

The Art of Lazying đưa ra lười biếng chiến lược như một cách tối ưu hóa năng lượng và tập trung vào những gì thực sự có ý nghĩa. Repository này khám phá cách lười biếng có chủ đích có thể dẫn đến năng suất, sáng tạo và phúc lợi tinh thần cao hơn.

## Lý thuyết của lười biếng

Một giới thiệu toàn diện về các nguyên tắc của lười biếng chiến lược, tập trung vào cách tối đa hóa hiệu suất và phúc lợi bằng cách ưu tiên, ủy quyền, và tự động hóa công việc.

Nguyên tắc cốt lõi là áp dụng quy tắc 80/20 của Pareto vào cuộc sống hàng ngày: xác định 20% hoạt động tạo ra 80% kết quả mong muốn.

## Mẹo thực tế

Một tập hợp lời khuyên có thể áp dụng ngay về việc vận dụng nguyên tắc lười biếng trong công việc, các mối quan hệ và tự chăm sóc:
- Tự động hóa các tác vụ lặp đi lặp lại
- Dùng kỹ thuật Pomodoro để quản lý thời gian
- Tạo hệ thống giảm mệt mỏi ra quyết định
- Tận dụng công cụ AI để hỗ trợ

## Tình huống sử dụng

Các ví dụ thực tế cho thấy nguyên tắc lười biếng giải quyết vấn đề và cải thiện hiệu quả:
- Doanh nhân dùng ủy quyền và tự động hóa để tập trung phát triển kinh doanh
- Giới nghiên cứu tối giản hóa quy trình nghiên cứu
- Nhà sáng tạo nội dung tối ưu hóa quy trình sản xuất nội dung

## AI Agents và tự động hóa

Khám phá sự phát triển của AI agents và công cụ tự động hóa giúp đơn giản hóa công việc:
- Sử dụng ChatGPT như trợ lý cá nhân
- Xây dựng workflow tự động hóa tùy chỉnh
- Tạo màn hình e-ink cho việc học thụ động

## Học ngôn ngữ và vlog

Nguồn lực và kỹ thuật học ngôn ngữ hiệu quả, cùng các vlog ghi lại hành trình lười biếng:
- Tạo lộ trình học ngôn ngữ cá nhân hóa bằng spaced repetition
- Áp dụng kỹ thuật học nhập vai
- Xây dựng dự án thúc đẩy học thụ động

## Đóng góp cộng đồng

Chia sẻ kinh nghiệm, mẹo và ý tưởng về lười biếng chiến lược của bạn:
- Diễn đàn trao đổi mẹo tăng hiệu suất
- Công cụ và template cho thói quen hằng ngày
- Dự án hợp tác hướng tới hiệu quả kiểu lười biếng

## Kết nối

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

## Đóng góp

Đóng góp rất hoan nghênh cho mã nguồn, tài liệu, ví dụ và bản dịch.

1. Fork repository.
2. Tạo một nhánh (`git checkout -b feature/your-feature`).
3. Thực hiện thay đổi với thông điệp commit rõ ràng.
4. Mở Pull Request mô tả động lực và tác động.

Nếu bạn chưa chắc bắt đầu từ đâu:
- Cải thiện tài liệu thiết lập cho một công cụ local.
- Thêm tests hoặc scripts xác thực cho các tiện ích hiện có.
- Nâng chất lượng và độ tương thích cho một biến thể `i18n/README.*.md`.

## Giấy phép

Repository này có nội dung giấy phép GPLv3 ở root (`LICENSE`) và ở một số thư mục con.

Lưu ý: Một số README của subproject nêu MIT. Cho đến khi từng dự án con được làm rõ, hãy coi repository gốc chịu điều chỉnh bởi GPLv3 và xác minh theo từng subproject nếu bạn định phân phối lại mã độc lập.


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
