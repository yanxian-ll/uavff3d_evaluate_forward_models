# A3D-Bench Training and Fine-Tuning

This repository keeps the MapAnything training stack and adapts it for A3D-Bench UAV-domain fine-tuning and ablation
experiments. The import package is still `mapanything` for compatibility with inherited configs and launch scripts.

## Before Training

1. Install the framework from the repository root:

```bash
pip install -e .
pip install -e ".[all]"
```

2. Prepare datasets in the WAI-style format used by the dataloaders. See `data_processing/README.md`.
3. Update local paths in `configs/machine/*.yaml`.
4. Check the dataset configs you plan to use, especially:

```text
configs/dataset/uavtrain_a3dsyn_518_many_ar_16ipg_2g.yaml
configs/dataset/uavtrain_a3dreal_518_many_ar_16ipg_2g.yaml
configs/dataset/uavtrain_6d_518_many_ar_16ipg_2g.yaml
configs/dataset/a3dreal_wai/
configs/dataset/a3dsynl_wai/
configs/dataset/a3dsyns_wai/
```

## UAV Fine-Tuning Scripts

Main A3D fine-tuning launch scripts are under:

```text
bash_scripts/train/uav_finetuning/
```

Examples:

```bash
# MapAnything fine-tuning on the configured A3D mixture
bash bash_scripts/train/uav_finetuning/mapa_finetuning_8v_6d_16ipg_2g_mvs.sh

# MapAnything fine-tuning on A3D-Real only
bash bash_scripts/train/uav_finetuning/mapa_finetuning_8v_6d_16ipg_2g_mvs_a3dreal.sh

# VGGT fine-tuning on A3D-Syn
bash bash_scripts/train/uav_finetuning/vggt_finetuning_8v_6d_16ipg_2g_a3dsyn.sh

# Pi3X fine-tuning on A3D-Syn
bash bash_scripts/train/uav_finetuning/pi3x_finetuning_8v_6d_16ipg_2g_mvs_a3dsyn.sh
```

Most scripts expect GPU count or distributed settings to be edited for the local machine. Check each script before
launching on a new cluster.

## Dataset Ablations

A3D dataset ablations are under:

```text
bash_scripts/train/ablations/a3d_dataset/
```

Examples:

```bash
bash bash_scripts/train/ablations/a3d_dataset/syn_only.sh
bash bash_scripts/train/ablations/a3d_dataset/real_only.sh
bash bash_scripts/train/ablations/a3d_dataset/a3d_all.sh
```

These scripts compare synthetic-only, real-only, blended, and full A3D training mixtures.

## Config Structure

The training entry point is inherited from MapAnything:

```text
configs/train.yaml
mapanything/train/training.py
```

Important config groups:

- `configs/machine/`: local filesystem paths and cluster settings;
- `configs/dataset/`: dataset mixtures, WAI roots, resolutions, and sampling settings;
- `configs/model/`: model wrappers and model-specific parameters;
- `configs/loss/`: loss combinations;
- `configs/train_params/`: optimizer, schedule, LoRA, checkpointing, and fine-tuning settings.

## Checkpoints

The release does not include trained weights by default. Put downloaded or converted checkpoints under `checkpoints/`
or another path configured in `configs/machine/*.yaml`. The `checkpoints/` directory is ignored by git.

## Notes

- Do not commit datasets, generated metadata, logs, or checkpoints.
- HunyuanWorld-Mirror and Depth Anything 3 fine-tuning paths depend on the modified local packages under `third_party/`.
- External projects not modified for A3D should remain external dependencies; see `THIRD_PARTY.md`.
