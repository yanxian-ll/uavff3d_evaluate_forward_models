# Third-party code and licenses

This repository is based on the MapAnything training and benchmarking framework and includes adapters for several feed-forward 3D reconstruction models.

## MapAnything

The training loop, Hydra-based configuration style, dataset interfaces, and benchmark infrastructure are derived from MapAnything. The main project license is Apache License 2.0, matching the license shipped with the submitted codebase.

## Vendored third-party projects

The following projects are kept under `third_party/` because the UAVFF3D evaluation wrappers depend on local or modified code:

- `third_party/HunyuanWorld-Mirror`
- `third_party/depth-anything-3`

Their upstream license files are kept inside each vendored directory. Users must follow those licenses when using, redistributing, or modifying the corresponding code, checkpoints, or model outputs.

## Integrated external adapters

The following model adapters are integrated under `mapanything/models/external/`:

- VGGT
- Pi3
- Pi3X
- Depth Anything 3 wrapper
- HunyuanWorld-Mirror wrapper

These adapters are provided for reproducibility of the UAVFF3D fine-tuning and evaluation experiments. Model weights and upstream code may have their own terms of use. Check the upstream project license before redistribution or commercial use.

## Datasets and checkpoints

Datasets and checkpoints are not included in this source release. Users are responsible for obtaining them from their original sources and complying with their licenses.
