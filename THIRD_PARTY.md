# Third-Party Code and License Notes

This repository is adapted from MapAnything and contains wrappers for several external feed-forward 3D reconstruction,
depth, calibration, and rendering projects. The root Apache-2.0 license applies only to code that is Apache-2.0-covered
within this repository. Third-party projects retain their own licenses.

## Bundled Modified Projects

These projects are included under `third_party/` because local modifications are needed by the A3D-Bench framework.

| Path | Upstream / provenance | Local role | License file |
| --- | --- | --- | --- |
| `third_party/mapabase` | Derived from MapAnything | Modified MapAnything base package used by A3D experiments | `third_party/mapabase/LICENSE` |
| `third_party/depth-anything-3` | Depth Anything 3 | Modified DA3 package used by A3D wrappers and losses | `third_party/depth-anything-3/LICENSE` |
| `third_party/HunyuanWorld-Mirror` | Tencent HunyuanWorld-Mirror | Modified HunyuanWorld-Mirror package used by A3D wrappers and losses | `third_party/HunyuanWorld-Mirror/License.txt`, `third_party/HunyuanWorld-Mirror/Notice.txt` |

Important: HunyuanWorld-Mirror is not Apache-2.0. It is governed by the Tencent HunyuanWorld-Mirror Community License
Agreement included in its directory. That license contains territory, use, distribution, and notice requirements.

## External Projects

The remaining third-party projects should not be committed into this repository. They are installed from upstream Git
repositories through optional dependencies in `pyproject.toml`, or cloned locally only when you need to inspect/debug
their source.

| Project | Default source |
| --- | --- |
| AnyCalib | `https://github.com/javrtg/AnyCalib.git` |
| LightGlue | `https://github.com/cvg/LightGlue.git` |
| CroCo | `https://github.com/naver/croco.git` branch `croco_module` |
| DUSt3R | `https://github.com/naver/dust3r.git` branch `dust3r_setup` |
| MASt3R | `https://github.com/Nik-V9/mast3r.git` |
| MUSt3R | `https://github.com/naver/must3r.git` |
| Pi3 / Pi3X | `https://github.com/yyfz/Pi3.git` |
| Pow3R | `https://github.com/Nik-V9/pow3r.git` |
| RobustMVD | `https://github.com/infinity1096/robustmvd.git` |
| ASMK | `https://github.com/lojzezust/asmk.git` |
| nvdiffrast | `https://github.com/NVlabs/nvdiffrast.git` |
| MoGe | `https://github.com/microsoft/MoGe.git` |

Use `bash git_third_party.sh` to clone these external sources into `third_party/` for local development. These checkout
directories are ignored by git.

## Model Weights and Datasets

Model weights and datasets are not covered by the root repository license unless explicitly stated by their providers.
Check each upstream model card, dataset page, and license before use or redistribution.

## MapAnything Provenance

The original MapAnything README is preserved as `README_MapAnything.md`. Root-level docs in this repository describe
the A3D-Bench adaptation and should be treated as the entry point for this project.
