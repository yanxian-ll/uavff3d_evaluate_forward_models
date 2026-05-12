# Contributing to A3D-Bench Evaluate Forward Models

Thanks for helping improve this research codebase.

## Pull Requests

1. Fork the repository and create a branch from `main`.
2. Keep changes scoped and document behavior changes.
3. Add or update tests/docs when you change public behavior.
4. Run formatting, linting, and relevant smoke tests before opening a PR.
5. Do not commit datasets, model weights, generated outputs, or external third-party checkouts.

## Third-Party Code

Only `third_party/mapabase`, `third_party/depth-anything-3`, and `third_party/HunyuanWorld-Mirror` are bundled because
they contain local modifications. Other projects should remain external dependencies; see `THIRD_PARTY.md`.

## License

By contributing, you agree that your contributions are licensed under the repository `LICENSE` unless a file explicitly
states otherwise. Contributions to bundled third-party projects must also comply with that project's own license.
