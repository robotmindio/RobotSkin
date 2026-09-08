#!/usr/bin/env python3
"""Check the measured ESP32 header arrangement against the printable carrier."""
from pathlib import Path
import subprocess
import tempfile

import trimesh


def main():
    scene = Path(__file__).resolve().parents[1] / "scad/source/esp32_fit.scad"
    with tempfile.TemporaryDirectory(prefix="robotskin-esp32-fit-") as directory:
        output = Path(directory) / "collision.stl"
        result = subprocess.run(
            ["openscad", "-D", 'MODE="collision"', "-o", str(output), str(scene)],
            capture_output=True, text=True, check=True,
        )
        if "ERROR:" in result.stderr or "WARNING:" in result.stderr:
            raise RuntimeError(result.stderr)
        mesh = trimesh.load_mesh(output, process=True)
        if not mesh.is_watertight or len(mesh.split()) != 1 or abs(mesh.volume-1) > 1e-5:
            raise AssertionError("Carrier intersects board, solder, pins, cables, jumpers or screw heads")
        print("PASS ESP32 nominal assembly clearances (physical fit still requires a print)")


if __name__ == "__main__":
    main()
