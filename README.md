# A3D-Bench Evaluate Forward Models

Code release for **A3D-Bench: A Geometry-Aware Benchmark for Feed-Forward UAV 3D Reconstruction**.

This repository contains the evaluation and fine-tuning framework used for A3D-Bench. It is adapted from
[MapAnything](https://github.com/facebookresearch/map-anything) and keeps the original `mapanything` Python package
name so that existing configs, imports, and wrappers remain compatible.

The code focuses on geometry-aware UAV evaluation:

- real and synthetic UAV benchmark configs for A3D-Real, A3D-Syn, A3D-FA, UrbanScene3D, UseGeo, and ENRICH;
- unified dense reconstruction metrics for depth, camera rays, poses, rotations, and point clouds;
- fine-tuning scripts for MapAnything, VGGT, Pi3, and Pi3X under A3D training splits;
- prior-aware evaluation for models that accept camera intrinsics, poses, or both;
- wrappers for representative feed-forward reconstruction models.

## Status

This is the code framework for the paper release. Dataset download links, trained checkpoints, and the final citation
will be added when the corresponding paper artifacts are public.

## Repository Layout

```text
assets/                         Figures and static assets used by docs
bash_scripts/benchmark/         Benchmark launch scripts, including UAV dense N-view evaluation
bash_scripts/train/             Fine-tuning and ablation launch scripts
benchmarking/                   Benchmark entry points and adapters
configs/                        Hydra configs for datasets, models, training, and evaluation
data_processing/                WAI-format data processing utilities
mapanything/                    Main package, adapted from MapAnything
scripts/                        Utility scripts for checkpoints, visualization, and profiling
third_party/                    Modified vendored projects plus optional external-project checkout area
README_MapAnything.md           Original MapAnything README kept for provenance/reference
THIRD_PARTY.md                  Third-party dependency and license notes
NOTICE                          Attribution and derivative-work notice
```

## Installation

```bash
git clone https://github.com/yanxian-ll/a3dbench_evaluate_forward_models.git
cd a3dbench_evaluate_forward_models

conda create -n a3dbench python=3.12 -y
conda activate a3dbench

# Install PyTorch for your CUDA / driver setup.
# Example for CUDA 12.1:
pip install torch==2.4 torchvision torchaudio
pip install --no-cache-dir --index-url https://download.pytorch.org/whl/cu121 "xformers==0.0.27.post2"

# Install the base framework.
pip install -e .

# Optional: install all external-model extras.
pip install -e ".[all]"

# Optional developer tools.
pre-commit install
```

The optional extras use upstream Git repositories for external projects where possible. The modified local copies of
`mapabase`, `depth-anything-3`, and `HunyuanWorld-Mirror` are kept under `third_party/` and installed from those local
paths.

## Third-Party Code Policy

Only the following modified projects are vendored in this repository:

- `third_party/mapabase`
- `third_party/depth-anything-3`
- `third_party/HunyuanWorld-Mirror`

Other third-party projects are treated as external dependencies and are installed through `pyproject.toml` extras or
checked out only for local development. See [THIRD_PARTY.md](THIRD_PARTY.md) and [third_party/README.md](third_party/README.md).

If you need local source checkouts for debugging external wrappers, run:

```bash
bash git_third_party.sh
```

Those external checkouts are ignored by git.

## A3D UAV Evaluation

Most paper evaluation scripts live under:

```text
bash_scripts/benchmark/uav_dense_n_view/
```

Examples:

```bash
# MapAnything, image-only
bash bash_scripts/benchmark/uav_dense_n_view/mapa/mapa.sh

# MapAnything with camera intrinsics and pose priors
bash bash_scripts/benchmark/uav_dense_n_view/mapa/mapa_cp.sh

# A3D-fine-tuned Pi3X with camera intrinsics
bash bash_scripts/benchmark/uav_dense_n_view/pi3x/pi3x_ft_c.sh

# HunyuanWorld-Mirror with camera pose priors
bash bash_scripts/benchmark/uav_dense_n_view/hy/hunyuan_p.sh
```

Before running, update machine paths in `configs/machine/*.yaml` and dataset roots in the relevant dataset configs.
The main A3D-related benchmark configs include:

- `configs/dataset/benchmark_518_a3d_enrich_usegeo_us3d.yaml`
- `configs/dataset/benchmark_518_a3dsynlfa.yaml`
- `configs/dense_n_view_benchmark.yaml`

## Fine-Tuning

A3D fine-tuning scripts are in:

```text
bash_scripts/train/uav_finetuning/
bash_scripts/train/ablations/a3d_dataset/
```

Examples:

```bash
# MapAnything fine-tuning with the full A3D mixture
bash bash_scripts/train/uav_finetuning/mapa_finetuning_8v_6d_16ipg_2g_mvs.sh

# VGGT fine-tuning on A3D-Syn
bash bash_scripts/train/uav_finetuning/vggt_finetuning_8v_6d_16ipg_2g_a3dsyn.sh

# Dataset ablation: A3D full mixture
bash bash_scripts/train/ablations/a3d_dataset/a3d_all.sh
```

See [train.md](train.md) for the inherited MapAnything training workflow and the current training-config structure.

## Data

The framework uses the WAI-style scene representation inherited from MapAnything. A processed scene typically contains
RGB images, camera intrinsics, camera poses, depth or rendered reference depth, masks, camera rays, and metadata. See
[data_processing/README.md](data_processing/README.md) for conversion utilities and format details.

A3D-Bench dataset release links are not included yet. Until public data links are available, scripts assume local data
roots configured in `configs/machine/*.yaml` and `configs/dataset/*`.

## License

The Apache-2.0-covered framework code is released under [LICENSE](LICENSE). This repository is derived from
MapAnything, whose public code is also Apache-2.0 licensed. See [NOTICE](NOTICE) for attribution.

Third-party code, model weights, and datasets may use different licenses. In particular, `third_party/HunyuanWorld-Mirror`
is governed by the Tencent HunyuanWorld-Mirror Community License Agreement included in that directory. See
[THIRD_PARTY.md](THIRD_PARTY.md) before redistribution.

This README is not legal advice; verify the relevant upstream licenses for your use case.

## Acknowledgments

This framework builds on [MapAnything](https://github.com/facebookresearch/map-anything). We also thank the authors and
maintainers of Depth Anything 3, HunyuanWorld-Mirror, VGGT, Pi3/Pi3X, DUSt3R, MASt3R, MUSt3R, Pow3R, MoGe, AnyCalib,
LightGlue, RobustMVD, WAI, and the datasets used by A3D-Bench.

## Citation

If you use this repository, please cite the A3D-Bench paper once the final bibliographic entry is available. Temporary
placeholder:

```bibtex
@misc{a3dbench2026,
  title  = {A3D-Bench: A Geometry-Aware Benchmark for Feed-Forward UAV 3D Reconstruction},
  author = {A3D-Bench Authors},
  year   = {2026},
  note   = {Code and benchmark framework}
}
```
