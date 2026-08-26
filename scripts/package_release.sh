#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$PROJECT_DIR/VERSION")"
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+[-.a-zA-Z0-9]*$ ]] || {
  echo "Invalid VERSION: $VERSION" >&2
  exit 1
}

"$PROJECT_DIR/scripts/build.sh"
"$PROJECT_DIR/scripts/build_test_parts.sh"
python "$PROJECT_DIR/scripts/validate_stl.py" "$PROJECT_DIR"/stl/*.stl

STAGE_ROOT="$(mktemp -d)"
trap 'rm -rf "$STAGE_ROOT"' EXIT
PACKAGE_NAME="robotmind-modular-ecosystem-$VERSION"
PACKAGE_DIR="$STAGE_ROOT/$PACKAGE_NAME"
mkdir -p "$PACKAGE_DIR"

cp "$PROJECT_DIR/README.md" "$PROJECT_DIR/THESIS.md" \
  "$PROJECT_DIR/VERSION" "$PACKAGE_DIR/"
cp -R "$PROJECT_DIR/docs" "$PROJECT_DIR/scad" "$PROJECT_DIR/scripts" \
  "$PACKAGE_DIR/"
mkdir -p "$PACKAGE_DIR/renders" "$PACKAGE_DIR/stl" "$PACKAGE_DIR/test-stl"
cp "$PROJECT_DIR"/renders/*.png "$PACKAGE_DIR/renders/"
cp "$PROJECT_DIR"/stl/*.stl "$PACKAGE_DIR/stl/"
cp "$PROJECT_DIR"/test-stl/*.stl "$PACKAGE_DIR/test-stl/"

(
  cd "$PACKAGE_DIR"
  find . -type f ! -name SHA256SUMS -print0 | sort -z | xargs -0 sha256sum > SHA256SUMS
)

mkdir -p "$PROJECT_DIR/dist"
ARCHIVE="$PROJECT_DIR/dist/$PACKAGE_NAME.tar.gz"
rm -f "$ARCHIVE"
tar --sort=name --mtime='UTC 1970-01-01' --owner=0 --group=0 --numeric-owner \
  -C "$STAGE_ROOT" -czf "$ARCHIVE" "$PACKAGE_NAME"
sha256sum "$ARCHIVE" > "$ARCHIVE.sha256"
echo "Packaged $ARCHIVE"
