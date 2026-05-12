# External Model Wrappers

This directory contains lightweight wrappers that let A3D-Bench evaluate multiple feed-forward reconstruction models
through the inherited MapAnything model factory and unified output format.

The wrappers are part of this repository, but the upstream model implementations remain third-party projects. Install
their dependencies through the optional extras in the root `pyproject.toml`, for example:

```bash
pip install -e ".[dust3r]"
pip install -e ".[pi3]"
pip install -e ".[depth-anything-3]"
pip install -e ".[hunyuanworld-mirror]"
```

The modified local copies of `depth-anything-3` and `HunyuanWorld-Mirror` are installed from `third_party/`. Other
external projects are installed from their upstream Git repositories or cloned locally with `bash git_third_party.sh`
for development.

Third-party implementations, checkpoints, and model outputs are governed by their own licenses. See the root
`THIRD_PARTY.md` before redistributing code or weights.
