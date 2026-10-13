import os
import zipfile

def build():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Read version from module.prop
    version = "v1.0.0"
    prop_path = os.path.join(script_dir, "module.prop")
    if os.path.exists(prop_path):
        with open(prop_path, "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("version="):
                    version = line.strip().split("=")[1]
                    break

    zip_name = f"a502zt_disable-edge-limit-{version}.zip"
    zip_path = os.path.join(script_dir, zip_name)

    files_to_pack = [
        "module.prop",
        "customize.sh",
        "service.sh",
        "action.sh",
    ]

    print(f"Creating Magisk/KernelSU module zip: {zip_name}...")
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for fname in files_to_pack:
            fpath = os.path.join(script_dir, fname)
            if not os.path.exists(fpath):
                print(f"Warning: {fname} does not exist, skipping.")
                continue
            with open(fpath, "rb") as f:
                data = f.read()
            # Normalize to LF
            data = data.replace(b"\r\n", b"\n")
            info = zipfile.ZipInfo(fname)
            # Give Unix 0755 permissions
            info.external_attr = 0o755 << 16
            z.writestr(info, data)
            print(f"  + Added: {fname}")

    print(f"\nBuild complete! Output: {zip_path}")

if __name__ == "__main__":
    build()
