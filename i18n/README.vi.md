[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

# Nghệ Thuật Lười Biếng

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

Một kho lưu trữ tập trung vào tư duy lười biếng chiến lược để sống đơn giản hơn nhưng hiệu quả hơn, bao quát AI agents, học ngôn ngữ, tự động hóa thực tiễn và quy trình công việc ngoài đời thực dựa trên vlog.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Mục lục

- [Tổng quan](#tổng-quan)
- [Dự án](#dự-án)
- [Cấu trúc kho lưu trữ](#cấu-trúc-kho-lưu-trữ)
- [Tính năng](#tính-năng)
- [Điều kiện tiên quyết](#điều-kiện-tiên-quyết)
- [Cài đặt](#cài-đặt)
- [Cách dùng](#cách-dùng)
- [Cấu hình](#cấu-hình)
- [Ví dụ](#ví-dụ)
- [Ghi chú phát triển](#ghi-chú-phát-triển)
- [Khắc phục sự cố](#khắc-phục-sự-cố)
- [Lộ trình](#lộ-trình)
- [Giới thiệu](#giới-thiệu)
- [Lý thuyết về nghệ thuật lười biếng](#lý-thuyết-về-nghệ-thuật-lười-biếng)
- [Mẹo và thủ thuật thực tế](#mẹo-và-thủ-thuật-thực-tế)
- [Các trường hợp sử dụng](#các-trường-hợp-sử-dụng)
- [AI Agents và tự động hóa](#ai-agents-và-tự-động-hóa)
- [Học ngôn ngữ và vlog](#học-ngôn-ngữ-và-vlog)
- [Đóng góp cộng đồng](#đóng-góp-cộng-đồng)
- [Kết nối](#kết-nối)
- [Hỗ trợ / Quyên góp](#hỗ-trợ--quyên-góp)
- [Đóng góp](#đóng-góp)
- [Giấy phép](#giấy-phép)

## Tổng quan

`the-art-of-lazying` là kho trung tâm cho thực hành lười biếng chiến lược: tự động hóa công việc lặp lại, cải thiện quy trình học ngôn ngữ và ghi lại các thử nghiệm thực tế thông qua script và vlog.

| Nhìn nhanh | Chi tiết |
|---|---|
| 🎯 Chủ đề cốt lõi | Lười biếng chiến lược cho năng suất, học tập và đầu ra sáng tạo |
| 🧩 Kiểu kho | Mô hình lai giữa công cụ cục bộ và các dự án bên ngoài được tuyển chọn |
| 🛠️ Điểm nổi bật cục bộ | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Tài liệu | README gốc + các biến thể đa ngôn ngữ trong `i18n/` |

Kho này bao gồm cả:
- Các liên kết tuyển chọn tới những dự án bên ngoài liên quan.
- Công cụ và mã cục bộ, đặc biệt là:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + màn hình học từ vựng dùng OpenAI).
  - `scripts/lazy-care/SafeShell` (các hàm shell xóa/khôi phục an toàn).
  - `vlogs/chatgpt-traffic` và `vlogs/repo2text` (các tiện ích Python nhỏ).

## Dự án

### 🚀 Công cụ sáng tạo dùng AI

| Dự án | Mô tả | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Màn hình e-ink học từ vựng chạy bằng GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Phân tích nguồn gốc từ và trình bày dưới dạng đồ thị. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Công cụ học ngôn ngữ hiệu quả với ít công sức | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Tạo chú thích video & ảnh bằng OpenAI CLIP embeddings + GPT decoder | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Công cụ tạo chú thích video: trích xuất key-frame bằng Katna/OpenCV và sinh chú thích bằng mô hình ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline phiên âm đa ngôn ngữ với nhận diện ngôn ngữ chi tiết | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Phá vỡ rào cản ngôn ngữ cho trao đổi sáng tạo toàn cầu | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Tự động tạo metadata cho video | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Công cụ dựng video tự động dùng AI với phiên âm, tạo phụ đề, tô điểm nổi bật và sinh metadata | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Tinh gọn quy trình xuất bản nội dung | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Hệ thống tự động giám sát, xử lý và xuất bản nội dung video lên nhiều nền tảng | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Các kỹ thuật nâng cao để sử dụng trợ lý AI hiệu quả | |

### ⚙️ Công cụ tự động hóa (cục bộ trong kho này)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: xóa trong shell an toàn hơn (`saferm`), khôi phục (`unrm`), và xóa vĩnh viễn có chủ đích (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: bộ phân giải domain-sang-IP và trình tạo đầu ra loại trùng lặp.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: gộp file Python theo thư mục thành các gói văn bản để phân tích có AI hỗ trợ.

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

Lưu ý: Các sơ đồ thư mục kiểu tổng quát trong một số biến thể README cũ từng tham chiếu các đường dẫn trừu tượng (ví dụ `book/`, `code/ai-agents/`) không khớp chính xác với cây thư mục hiện tại. Cấu trúc ở trên phản ánh các file hiện có.

## Tính năng

- Khung lười biếng chiến lược cho năng suất, học tập và quy trình nội dung.
- Danh mục dự án AI tuyển chọn, bao trùm phiên âm, tạo chú thích, dịch thuật và tự động hóa xuất bản.
- Học ngôn ngữ tích hợp phần cứng với chọn từ có GPT hỗ trợ (`EinkWordsGPT`).
- Công cụ an toàn shell thực dụng cho quy trình xóa có thể hoàn tác.
- Tiện ích ưu tiên script cho kiểm tra lưu lượng DNS/domain và chuyển đổi kho thành văn bản.
- Hỗ trợ tài liệu đa ngôn ngữ qua `i18n/`.

## Điều kiện tiên quyết

Chung:
- Git
- Khuyến nghị Python 3.9+

Cho `code/EinkWordsGPT`:
- Raspberry Pi (tài liệu dự án có nhắc Raspberry Pi 5)
- Màn hình e-ink Waveshare 7.3 inch 7 màu có hỗ trợ Python driver (`waveshare_epd`)
- Các gói Python dùng trong mã: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (dùng `sqlite3` trong Python stdlib)
- OpenAI API key được cấu hình trong môi trường (mã khởi tạo `OpenAI()` trực tiếp)

Cho `vlogs/chatgpt-traffic`:
- `dnspython`

Cho `scripts/lazy-care/SafeShell`:
- Bash hoặc Zsh có quyền truy cập `realpath`, `mv`, và `/bin/rm`

## Cài đặt

Clone kho:

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Cài các dependency Python thường dùng (mốc cơ bản toàn kho):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Lưu ý: `code/EinkWordsGPT/README.md` có nhắc `requirements.txt`, nhưng hiện tại kho này không có `requirements.txt`. Hãy cài thủ công như ở trên.

## Cách dùng

### 1) EinkWordsGPT (luồng phần cứng cục bộ)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

Script bảo trì cơ sở dữ liệu (tùy chọn):

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (quy trình xóa an toàn hơn)

Nạp các hàm shell:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

Dùng lệnh:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Trình phân giải ChatGPT Traffic

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Bộ gộp repo-thành-văn-bản

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Lưu ý: `convert-repo-to-merged-text.py` hiện dùng đường dẫn hardcode (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Hãy chỉnh các hằng này trước khi chạy cho kho khác.

## Cấu hình

### Cấu hình OpenAI (`code/EinkWordsGPT`)

Mã tạo client bằng:

```python
client = OpenAI()
```

Vì vậy, hãy cấu hình API credentials bằng cách tiêu chuẩn qua biến môi trường của OpenAI trước khi chạy script.

### Đường dẫn cơ sở dữ liệu (`code/EinkWordsGPT`)

Mặc định trong mã:

```python
db_path = 'words_phonetics.db'
```

Đảm bảo `words_phonetics.db` tồn tại trong `code/EinkWordsGPT/` (hiện đã có sẵn trong kho này).

### Vị trí thùng rác SafeShell

`saferm`/`unrm`/`removeitanyway` dùng một đường dẫn gốc cố định:

```bash
/mnt/disk/BIN/ROOT
```

Nếu môi trường của bạn khác, hãy chỉnh đường dẫn này trong `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Ví dụ

- Demo thẻ từ vựng e-ink trong `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Ghi chú/tài liệu build cho ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Ghi chú phát triển

- Đây là kho trình diễn đa dự án, gồm cả mã cục bộ và liên kết dự án bên ngoài.
- Hiện chưa có package manager hoặc build manifest cấp root (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` chưa có ở root).
- Một số README con mang tính mẫu và có thể đã cũ một phần so với bố cục file hiện tại; các lệnh trong README này đã được căn theo đường dẫn/script hiện có.
- `README_EN.md` và `README_CN.md` tồn tại như biến thể cũ; `README.md` + `i18n/*` là cấu trúc đa ngôn ngữ đang hoạt động.

## Khắc phục sự cố

- `ModuleNotFoundError` cho các gói Python:
  - Cài lại dependency với `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` trong `EinkWordsGPT`:
  - Cài driver/thư viện Python cho e-paper Waveshare trên môi trường Raspberry Pi.

- Lỗi xác thực OpenAI:
  - Kiểm tra OpenAI API key đã được thiết lập trong biến môi trường trước khi chạy `words_gpt.py` hoặc `words_update.py`.

- Không tìm thấy `saferm`/`unrm` sau khi thiết lập:
  - Xác nhận đã `source` đúng file rc shell và đã append `safeshell_functions.sh` thành công.

- `unrm` không thể khôi phục file:
  - Kiểm tra đường dẫn khôi phục có khớp bố cục thùng rác dạng mirror của SafeShell dưới `/mnt/disk/BIN/ROOT`.

- Script `repo2text` không tạo output:
  - Cập nhật `source_directory` trong `convert-repo-to-merged-text.py` thành thư mục có tồn tại.

## Lộ trình

- Mở rộng độ tương ứng nội dung README gốc trên tất cả file i18n (hiện nhiều ngôn ngữ mới ở mức tóm tắt).
- Bổ sung tài liệu cài đặt theo từng môi trường cho driver Waveshare e-ink.
- Thêm manifest dependency tái lập được ở cấp root cho các công cụ cục bộ.
- Thêm script kiểm thử/xác thực cho các tiện ích quan trọng.
- Tiếp tục hợp nhất liên kết dự án bên ngoài với demo cục bộ phong phú hơn.

## Giới thiệu

The Art of Lazying giới thiệu lười biếng chiến lược như một cách tối ưu năng lượng và tập trung vào điều thật sự quan trọng. Kho này khám phá cách lười biếng có chủ đích có thể dẫn tới năng suất, sáng tạo và sức khỏe tinh thần tốt hơn.

## Lý thuyết về nghệ thuật lười biếng

Phần giới thiệu toàn diện về các nguyên tắc của lười biếng chiến lược, tập trung vào việc tối đa hóa năng suất và chất lượng sống thông qua ưu tiên, ủy quyền và tự động hóa công việc.

Nguyên tắc cốt lõi là áp dụng quy tắc 80/20 (Pareto) vào đời sống hằng ngày: xác định 20% hoạt động tạo ra 80% kết quả mong muốn.

## Mẹo và thủ thuật thực tế

Tập hợp các lời khuyên có thể áp dụng ngay về việc dùng nguyên tắc lười biếng trong công việc, quan hệ và chăm sóc bản thân:
- Tự động hóa các tác vụ lặp đi lặp lại
- Dùng Pomodoro Technique để quản lý thời gian
- Tạo hệ thống giúp giảm mệt mỏi khi ra quyết định
- Tận dụng công cụ AI để hỗ trợ

## Các trường hợp sử dụng

Ví dụ thực tế cho thấy nguyên tắc lazying giải quyết vấn đề và nâng cao hiệu quả:
- Cách doanh nhân dùng ủy quyền và tự động hóa để tập trung vào tăng trưởng kinh doanh
- Cách giới học thuật tinh gọn quy trình nghiên cứu
- Cách nhà sáng tạo nội dung tối ưu quy trình sản xuất

## AI Agents và tự động hóa

Khám phá việc phát triển AI agents và công cụ tự động hóa giúp đơn giản hóa công việc:
- Dùng ChatGPT như một trợ lý cá nhân
- Xây dựng quy trình tự động hóa tùy chỉnh
- Tạo màn hình e-ink cho học thụ động

## Học ngôn ngữ và vlog

Tài nguyên và kỹ thuật học ngôn ngữ hiệu quả, cùng vlog ghi lại hành trình lazying:
- Xây dựng lộ trình học ngôn ngữ cá nhân hóa với spaced repetition
- Triển khai các kỹ thuật học nhập vai
- Xây dựng dự án khuyến khích học thụ động

## Đóng góp cộng đồng

Chia sẻ trải nghiệm, mẹo và ý tưởng của riêng bạn về lười biếng chiến lược:
- Diễn đàn trao đổi mẹo tăng năng suất
- Công cụ và template cho nếp sinh hoạt hằng ngày
- Dự án cộng tác hướng tới hiệu quả kiểu lazy

## Kết nối

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## Hỗ trợ / Quyên góp

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

Liên kết tài trợ bổ sung từ `.github/FUNDING.yml`:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## Đóng góp

Mọi đóng góp đều được hoan nghênh cho mã nguồn, tài liệu, ví dụ và bản dịch.

1. Fork kho lưu trữ.
2. Tạo nhánh (`git checkout -b feature/your-feature`).
3. Thực hiện thay đổi với commit message rõ ràng.
4. Mở Pull Request mô tả động lực và tác động.

Nếu bạn chưa chắc nên bắt đầu từ đâu:
- Cải thiện tài liệu thiết lập cho một công cụ cục bộ.
- Thêm test hoặc script xác thực cho các tiện ích hiện có.
- Cải thiện độ tương ứng/chất lượng cho một biến thể `i18n/README.*.md`.

## Giấy phép

Kho này bao gồm văn bản giấy phép GPLv3 ở root (`LICENSE`) và trong một số thư mục con.

Lưu ý: Một số README của các dự án con có nhắc MIT. Cho đến khi từng submodule được làm rõ, hãy coi kho gốc chịu sự điều chỉnh của GPLv3 và xác minh theo từng dự án con nếu bạn định phân phối lại mã độc lập.
