#!/usr/bin/env python3
"""Check provisional pogo connector, mating flange, cable and both screw access clearances."""
from pathlib import Path
import subprocess
import tempfile

import trimesh


def section_centres(mesh, origin, normal, axes, diameter):
    section = mesh.section(plane_origin=origin, plane_normal=normal)
    if section is None:
        raise AssertionError(f"Missing section at {origin}")
    centres = []
    for curve in section.discrete:
        low, high = curve.min(axis=0), curve.max(axis=0)
        if all(abs(high[i]-low[i]-diameter) < 0.01 for i in axes):
            centres.append(tuple(round((low[i]+high[i])/2, 3) for i in axes))
    return sorted(centres)


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
            raise AssertionError("Pogo mount intersects nominal connector, mating flange, cables or screw access")
        print("PASS pogo nominal connector/mate/cable/screw clearances")
        result = subprocess.run(
            ["openscad", "-D", 'MODE="part"', "-o", str(output), str(scene)],
            capture_output=True, text=True, check=True,
        )
        if "ERROR:" in result.stderr or "WARNING:" in result.stderr:
            raise RuntimeError(result.stderr)
        mesh = trimesh.load_mesh(output, process=True)
        # Measure actual mesh sections independently of the SCAD dimension constants.
        assert section_centres(mesh, [0,0.4,0], [0,1,0], [0,2], 6.4) == [(-10,12),(10,12)], \
            "Pogo apertures must be diameter 6.4 on 20 mm centres"
        for diameter in [1.7,4.2]:
            assert section_centres(mesh, [0,2,0], [0,1,0], [0,2], diameter) == [(-21.5,12),(21.5,12)], \
                "Flange pilots/posts must share the 43 mm mounting pattern"
        assert section_centres(mesh, [0,0,-1], [0,0,1], [0,1], 5.9) == \
            [(x,22) for x in [-25,-15,-5,5,15,25]], "Six standard pegs must sit behind the contact face on the 10 mm grid"
        print("PASS mesh sections: 20 mm contact pitch, 43 mm flange pitch, six rear pegs at 10 mm")
        print("Contact diameter/tolerances and physical fit still need supplier confirmation")


if __name__ == "__main__":
    main()
