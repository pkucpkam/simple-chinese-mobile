"""Sinh assets/pronunciation/syllables.json cho bảng pinyin tương tác.

Với mỗi âm tiết (thanh mẫu + vận mẫu) và mỗi thanh 1-4, chọn một chữ Hán
"đại diện" để TTS đọc đúng âm đó (app chưa có file ghi âm cho từng âm tiết).

Nguồn: Unicode Unihan (https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip)
  - kHanyuPinlu: cách đọc kèm tần suất trong ngữ liệu → ưu tiên chữ phổ biến
    và cách đọc chiếm áp đảo (≥ 90%) để TTS không đọc nhầm sang âm khác.
  - kMandarin + kGB0: bổ sung âm tiết hiếm mà Pinlu không có, chỉ lấy chữ
    trong GB2312 cấp 1 (3755 chữ thông dụng).

Cách dùng:
    python tool/gen_pinyin_chart.py <thư mục đã giải nén Unihan.zip>
"""
import json
import os
import re
import sys
import unicodedata
from collections import defaultdict

OUT = os.path.join(os.path.dirname(__file__), "..", "assets", "pronunciation", "syllables.json")

INITIALS = ["b", "p", "m", "f", "d", "t", "n", "l", "g", "k", "h",
            "j", "q", "x", "zh", "ch", "sh", "r", "z", "c", "s"]

# Vận mẫu theo thứ tự bảng pinyin chuẩn (nhóm a/o/e, i-, u-, ü-).
FINALS = ["a", "o", "e", "i", "er", "ai", "ei", "ao", "ou", "an", "en", "ang", "eng", "ong",
          "ia", "ie", "iao", "iu", "ian", "in", "iang", "ing", "iong",
          "u", "ua", "uo", "uai", "ui", "uan", "un", "uang", "ueng",
          "ü", "üe", "üan", "ün"]

# Âm tiết không có thanh mẫu: cách viết y/w → vận mẫu gốc.
ZERO = {
    "yi": "i", "ya": "ia", "ye": "ie", "yao": "iao", "you": "iu", "yan": "ian",
    "yin": "in", "yang": "iang", "ying": "ing", "yong": "iong",
    "wu": "u", "wa": "ua", "wo": "uo", "wai": "uai", "wei": "ui", "wan": "uan",
    "wen": "un", "wang": "uang", "weng": "ueng",
    "yu": "ü", "yue": "üe", "yuan": "üan", "yun": "ün",
}

TONE_MARKS = {"̄": 1, "́": 2, "̌": 3, "̀": 4}


def parse_marked(s):
    """'nǚ' → ('nü', 3). Dấu thanh tách bằng NFD; giữ ü (u + U+0308)."""
    tone = 5
    out = []
    for ch in unicodedata.normalize("NFD", s):
        if ch in TONE_MARKS:
            tone = TONE_MARKS[ch]
        else:
            out.append(ch)
    return unicodedata.normalize("NFC", "".join(out)), tone


def split_syllable(base):
    """'zhang' → ('zh', 'ang'); 'yue' → ('', 'üe'); 'ju' → ('j', 'ü')."""
    if base in ZERO:
        return "", ZERO[base]
    if base in ("a", "o", "e", "ai", "ei", "ao", "ou", "an", "en", "ang", "eng", "er"):
        return "", base
    for ini in sorted(INITIALS, key=len, reverse=True):
        if base.startswith(ini):
            fin = base[len(ini):]
            # j/q/x + u... thực chất là ü (viết tắt bỏ hai chấm).
            if ini in ("j", "q", "x") and fin.startswith("u"):
                fin = "ü" + fin[1:]
            return ini, fin
    return None


def load(path, field):
    data = {}
    with open(path, encoding="utf8") as f:
        for line in f:
            if f"\t{field}\t" in line:
                cp, _, val = line.rstrip("\n").split("\t")
                data[chr(int(cp[2:], 16))] = val
    return data


def main(src):
    pinlu = load(os.path.join(src, "Unihan_Readings.txt"), "kHanyuPinlu")
    mandarin = load(os.path.join(src, "Unihan_Readings.txt"), "kMandarin")
    gb0 = load(os.path.join(src, "Unihan_OtherMappings.txt"), "kGB0")
    level1 = {c for c, v in gb0.items() if 16 <= int(v[:2]) <= 55}
    simplified = set(gb0)  # GB2312 chỉ chứa chữ giản thể

    # (âm tiết, thanh) → [(điểm, chữ)]
    cands = defaultdict(list)
    for ch, val in pinlu.items():
        if ch not in simplified:
            continue
        readings = [(parse_marked(r), int(n))
                    for r, n in re.findall(r"([^\s(]+)\((\d+)\)", val)]
        # Không tính thanh nhẹ khi xét tỉ lệ: 妈 hay đọc nhẹ trong 妈妈 nhưng
        # đọc riêng một chữ thì TTS vẫn đọc mā.
        total = sum(n for (_, t), n in readings if t != 5) or 1
        for (base, tone), n in readings:
            if tone == 5 or n / total < 0.9:
                continue  # chữ đa âm → TTS dễ đọc sai, bỏ qua
            # Ưu tiên chữ GB2312 cấp 1 (thông dụng) trước, rồi tới tần suất.
            cands[(base, tone)].append((ch in level1, n, ch))
    # Bổ sung từ kMandarin cho tổ hợp chưa có.
    for ch, val in mandarin.items():
        if ch not in level1 or ch in pinlu:
            continue
        base, tone = parse_marked(val.split()[0])
        if tone != 5 and (base, tone) not in cands:
            cands[(base, tone)].append((True, 0, ch))

    table = {}
    for (base, tone), lst in cands.items():
        parts = split_syllable(base)
        if parts is None or parts[1] not in FINALS:
            continue
        best = max(lst)[2]
        entry = table.setdefault(base, {"syllable": base, "initial": parts[0],
                                        "final": parts[1], "tones": {}})
        entry["tones"][str(tone)] = best

    syllables = sorted(table.values(), key=lambda e: (
        FINALS.index(e["final"]), ([""] + INITIALS).index(e["initial"])))
    out = {
        "contentVersion": 1,
        "initials": [""] + INITIALS,
        "finals": FINALS,
        "syllables": syllables,
    }
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf8") as f:
        json.dump(out, f, ensure_ascii=False, separators=(",", ":"))
    print(f"{len(syllables)} âm tiết, "
          f"{sum(len(e['tones']) for e in syllables)} tổ hợp âm tiết+thanh → {OUT}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else ".")
