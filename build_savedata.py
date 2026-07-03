from zlib import compress
from os import listdir
from os.path import join, dirname

def build_savedata(src_dir: str, out_dir: str) -> None:
    files = listdir(src_dir)
    for basename in files:
        basename = basename
        if not basename.endswith(".lua"):
            continue
        src_path = join(src_dir, basename)
        if basename == "main.lua":
            basename = "s_settings.jkr"
        out_path = join(out_dir, basename)
        with open(src_path, "rb") as f:
            d = f.read()
        with open(out_path, "wb") as f:
            if basename == "s_settings.jkr":
                d = compress(d, wbits=-15)
            _ = f.write(d)

if __name__ == "__main__":
    d = dirname(__file__)
    build_savedata(join(d, "source"), join(d, "savedata"))

