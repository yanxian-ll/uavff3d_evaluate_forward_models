# UAVFF3D Fine-tuning and Evaluation Code

This repository contains the fine-tuning and evaluation code used for **UAVFF3D: A Geometry-Aware Benchmark for Feed-Forward UAV 3D Reconstruction**.

The code is based on the MapAnything training and benchmarking framework and keeps the components needed to reproduce the UAVFF3D experiments: UAV-domain fine-tuning, dense N-view evaluation with shared scene-level alignment, and wrappers for MapAnything, VGGT, Pi3, Pi3X, Depth Anything 3, and HunyuanWorld-Mirror.

## What is included

```text
bash_scripts/
  benchmark/uav_dense_n_view/     UAVFF3D dense N-view evaluation launchers
  train/uav_finetuning/           UAV-domain fine-tuning launchers
benchmarking/dense_n_view/        Shared-alignment dense N-view evaluator
configs/                          Hydra configs for training, evaluation, models, and datasets
mapanything/                      MapAnything-based training/evaluation framework and model wrappers
scripts/train.py                  Training entry point
third_party/
  HunyuanWorld-Mirror/            Vendored HunyuanWorld-Mirror adapter dependency
  depth-anything-3/               Vendored Depth Anything 3 adapter dependency
```

Unrelated MapAnything demos, profiling scripts, calibration benchmarks, RMVD benchmarks, and unrelated bash launchers were removed to make the release focused and easier to maintain.

## Relationship to MapAnything

This project reuses the MapAnything framework for data loading, Hydra configuration, training, and benchmarking. The UAVFF3D-specific parts are the dataset loaders, UAV-domain fine-tuning configurations, dense N-view evaluation launchers, and benchmark settings used in the paper.

Please cite and follow the license of MapAnything when using this repository. See [`THIRD_PARTY.md`](THIRD_PARTY.md) for third-party license notes.

## Installation

Create a Python environment, then install this project in editable mode:

```bash
conda create -n uavff3d python=3.10 -y
conda activate uavff3d

# Install PyTorch separately for your CUDA version, then:
pip install -e .
```

Install optional model dependencies as needed:

```bash
# Depth Anything 3 and HunyuanWorld-Mirror wrappers use the vendored local copies.
pip install -e .[da3,hunyuan]

# Development tools.
pip install -e .[dev]
```

The VGGT, Pi3, and Pi3X adapters used here are integrated under `mapanything/models/external/` in the same style as the submitted codebase.

## Data layout

Set the dataset paths in `configs/machine/aws.yaml` or create a new machine config under `configs/machine/`.

The expected top-level dataset layout is:

```text
${root_data_dir}/
  UAVFF3D-Real/
  UAVFF3D-Syn-L/
  UAVFF3D-Syn-S/
  UAVFF3D-FA/
  BlendedMVS/
  UAVScenes/
  WHU-WHUOMVS/
  UseGeo/
  UrbanScene3D/
  ENRICH/
  metadata/
```

The metadata directory should contain the scene lists and HFOV metadata referenced by the dataset configs.

## Fine-tuning

Fine-tuning launchers are in `bash_scripts/train/uav_finetuning/`.

Example:

```bash
bash bash_scripts/train/uav_finetuning/mapa_finetuning_8v_6d_16ipg_2g_mvs.sh 2
```

The first argument is the number of GPUs. Scripts default to one GPU if no argument is supplied.

The main training mixtures are:

- `uavtrain_6d_518_many_ar_16ipg_2g`: full UAVFF3D training mix
- `uavtrain_public_518_many_ar_16ipg_2g`: public-data-only ablation
- `uavtrain_uavff3d_real_518_many_ar_16ipg_2g`: UAVFF3D-Real ablation
- `uavtrain_uavff3d_syn_518_many_ar_16ipg_2g`: UAVFF3D-Syn ablation

## Dense N-view evaluation

Evaluation launchers are in `bash_scripts/benchmark/uav_dense_n_view/`.

Example:

```bash
bash bash_scripts/benchmark/uav_dense_n_view/mapa/mapa_ft.sh 0
```

The first argument is the CUDA device index. Evaluation uses:

```bash
python3 benchmarking/dense_n_view/benchmark.py \
  dataset=benchmark_518_uavff3d_enrich_usegeo_us3d \
  model=mapanything \
  model/task=images_only \
  compute_abs_metrics=true
```

The evaluator reports the metrics used in the paper, including ray error, pose ATE under shared scene-level alignment, AbsRel depth, rotation error, and Chamfer-L1.

## Checkpoints

Place model checkpoints under `checkpoints/` or update `root_pretrained_checkpoints_dir` in the selected machine config. Fine-tuned checkpoints are expected under `${root_experiments_dir}/mapanything/uav_training/...` by the provided scripts.

Use the conversion utility when a Hugging Face checkpoint needs to be converted into the benchmark checkpoint format:

```bash
python scripts/convert_hf_to_benchmark_checkpoint.py --help
```

## License

The main project code is released under the Apache License 2.0. Third-party code, checkpoints, and datasets may have different licenses. In particular, the vendored copies of HunyuanWorld-Mirror and Depth Anything 3 remain governed by their upstream licenses. See [`THIRD_PARTY.md`](THIRD_PARTY.md) and [`NOTICE`](NOTICE).

## Citation

If you use this code, please cite the UAVFF3D paper and the relevant upstream projects, including MapAnything and any evaluated model wrappers you use.
