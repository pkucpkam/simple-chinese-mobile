"""Trích dữ liệu nét chữ cho mọi chữ Hán trong từ vựng (assets/content/*/words.json).

Nguồn: Make Me a Hanzi — https://github.com/skishore/makemeahanzi (graphics.txt),
giấy phép Arphic Public License (xem assets/strokes/COPYING).

Mỗi chữ ghi ra assets/strokes/<mã unicode hex>.json, vd 你 → 4f60.json, đúng định
dạng mà package stroke_order_animator đọc (strokes + medians).

Cách dùng:
    python tool/gen_strokes.py <đường dẫn graphics.txt>
Chạy lại mỗi khi thêm cấp độ mới (vd HSK2) để bổ sung chữ còn thiếu.
"""
import glob
import json
import os
import sys

ROOT = os.path.join(os.path.dirname(__file__), "..")
OUT = os.path.join(ROOT, "assets", "strokes")


def wanted_chars():
    chars = set()
    for path in glob.glob(os.path.join(ROOT, "assets", "content", "*", "words.json")):
        for w in json.load(open(path, encoding="utf8"))["items"]:
            chars.update(c for c in w["hanzi"] if "一" <= c <= "鿿")
    return chars


def main(graphics):
    chars = wanted_chars()
    os.makedirs(OUT, exist_ok=True)
    found = set()
    with open(graphics, encoding="utf8") as f:
        for line in f:
            entry = json.loads(line)
            ch = entry["character"]
            if ch in chars:
                data = {"strokes": entry["strokes"], "medians": entry["medians"]}
                path = os.path.join(OUT, f"{ord(ch):x}.json")
                with open(path, "w", encoding="utf8") as o:
                    json.dump(data, o, separators=(",", ":"))
                found.add(ch)
    missing = sorted(chars - found)
    print(f"{len(found)}/{len(chars)} chữ có dữ liệu nét" +
          (f"; thiếu: {''.join(missing)}" if missing else ""))


if __name__ == "__main__":
    main(sys.argv[1])
