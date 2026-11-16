"""Tạo font Noto Sans SC / Noto Serif SC tĩnh, đã subset để đóng gói offline.

Font CJK gốc (variable) nặng 18-25MB. Script này:
  1. Cố định trục wght thành các độ đậm cần dùng (static instance).
  2. Giữ lại ASCII, Latin mở rộng (pinyin có dấu), dấu câu CJK và toàn bộ
     6763 chữ Hán trong GB2312 — đủ cho HSK 1-6 (và HSK 3.0 phần lớn).

Cách dùng (cần `pip install fonttools`):
    python tool/subset_fonts.py <thư mục chứa NotoSansSC.ttf, NotoSerifSC.ttf>

Nguồn font: https://github.com/google/fonts/tree/main/ofl (giấy phép OFL).
"""
import io
import os
import sys

from fontTools import subset
from fontTools.ttLib import TTFont
from fontTools.varLib import instancer

OUT_DIR = os.path.join(os.path.dirname(__file__), "..", "assets", "fonts")

# (file nguồn, tên family xuất ra, {tên file: wght})
TARGETS = [
    ("NotoSansSC.ttf", "NotoSansSC", {"Regular": 400, "Bold": 700}),
    ("NotoSerifSC.ttf", "NotoSerifSC", {"Regular": 400, "SemiBold": 600}),
]


def gb2312_chars():
    chars = set()
    for hi in range(0xB0, 0xF8):  # Khu chữ Hán cấp 1 + cấp 2
        for lo in range(0xA1, 0xFF):
            try:
                chars.add(bytes([hi, lo]).decode("gb2312"))
            except UnicodeDecodeError:
                pass
    return chars


def unicodes():
    cps = set(range(0x20, 0x7F))           # ASCII
    cps |= set(range(0xA0, 0x250))         # Latin-1 + Latin Extended A/B (ǎ ǚ ...)
    cps |= set(range(0x300, 0x370))        # Combining diacritics
    cps |= set(range(0x2000, 0x2070))      # General punctuation
    cps |= set(range(0x3000, 0x3040))      # CJK symbols & punctuation (。、「」)
    cps |= set(range(0xFF00, 0xFFF0))      # Full-width forms (，！？)
    cps |= {0x7C73, 0x5B57, 0x683C}        # 米字格
    cps |= {ord(c) for c in gb2312_chars()}
    return cps


def main(src_dir):
    os.makedirs(OUT_DIR, exist_ok=True)
    cps = unicodes()
    for src, family, weights in TARGETS:
        for style, wght in weights.items():
            font = TTFont(os.path.join(src_dir, src))
            static = instancer.instantiateVariableFont(font, {"wght": wght})
            buf = io.BytesIO()
            static.save(buf)
            buf.seek(0)
            font = TTFont(buf)
            options = subset.Options()
            options.layout_features = ["*"]
            options.name_IDs = ["*"]
            options.notdef_outline = True
            sub = subset.Subsetter(options)
            sub.populate(unicodes=cps)
            sub.subset(font)
            out = os.path.join(OUT_DIR, f"{family}-{style}.ttf")
            font.save(out)
            print(f"{out}: {os.path.getsize(out) // 1024} KB")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else ".")
