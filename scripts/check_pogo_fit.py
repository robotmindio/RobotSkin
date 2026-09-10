#!/usr/bin/env python3
"""Check provisional pogo connector, cable and both screw access clearances."""
from pathlib import Path
import subprocess
import tempfile

import trimesh


def main():
    scene = Path(__file__).resolve().parents[1] / "scad/source/pogo_fit.scad"
    with tempfile.TemporaryDirectory(prefix="robotskin-pogo-fit-") as directory:
        output = Path(directory) / "collision.stl"
        result = subprocess.run(
            ["openscad", "-D", 'MODE="collision"', "-o", str(output), str(scene)],
            capture_output=True, text=True, check=True,
        )
        if "ERROR:" in result.stderr or "WARNING:" in result.stderr:
            raise RuntimeError(result.stderr)
        mesh = trimesh.load_mesh(output, process=True)
        if not mesh.is_watertight or len(mesh.split()) != 1 or abs(mesh.volume-1) > 1e-5:
            raise AssertionError("Pogo mount intersects nominal connector, cables or screw access")
        print("PASS pogo nominal clearances (screenshot dimensions and physical fit unconfirmed)")


if __name__ == "__main__":
    main()
