# Third-Party Directory

This directory has two different roles:

1. Bundled modified projects that are part of this code release.
2. Optional local checkouts of external upstream projects for debugging and development.

## Bundled Modified Projects

These directories are intentionally kept in the repository:

- `mapabase`
- `depth-anything-3`
- `HunyuanWorld-Mirror`

They contain local modifications needed by the A3D-Bench framework. Their original licenses and notices are kept inside
each directory.

## External Checkouts

All other project directories in `third_party/` are treated as external checkouts and are ignored by git. Install them
through the optional dependencies in the root `pyproject.toml` whenever possible.

For local source checkouts, run from the repository root:

```bash
bash git_third_party.sh
```

See `../THIRD_PARTY.md` for the dependency table and license notes.
