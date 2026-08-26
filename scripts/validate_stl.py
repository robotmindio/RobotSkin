#!/usr/bin/env python3
"""Reject broken production STL meshes, including disconnected floating shells."""

import argparse
from pathlib import Path

import trimesh


def validate(path: Path) -> list[str]:
    loaded = trimesh.load_mesh(path, process=True)
    mesh = loaded.dump(concatenate=True) if isinstance(loaded, trimesh.Scene) else loaded
    errors = []
    if mesh.is_empty:
        return ["empty mesh"]
    if not mesh.is_watertight:
        errors.append("mesh is not watertight")
    if not mesh.is_winding_consistent:
        errors.append("face winding is inconsistent")
    if mesh.volume <= 0:
        errors.append(f"non-positive volume ({mesh.volume:g})")
    components = mesh.split(only_watertight=False)
    if len(components) != 1:
        errors.append(f"{len(components)} disconnected shells (floating regions)")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("paths", nargs="+", type=Path)
    args = parser.parse_args()
    failed = False
    for path in args.paths:
        errors = validate(path)
        if errors:
            failed = True
            print(f"FAIL {path}: {'; '.join(errors)}")
        else:
            print(f"PASS {path}")
    return int(failed)


if __name__ == "__main__":
    raise SystemExit(main())
