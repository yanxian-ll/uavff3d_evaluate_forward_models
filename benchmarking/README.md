# Benchmarking

This directory contains benchmark entry points inherited from MapAnything and adapted for UAVFF3D evaluation.

The UAVFF3D paper scripts primarily use:

```text
bash_scripts/benchmark/uav_dense_n_view/
configs/dataset/benchmark_518_uavff3d_enrich_usegeo_us3d.yaml
configs/dataset/benchmark_518_uavff3d_fa.yaml
configs/dense_n_view_benchmark.yaml
```

Update paths in `configs/machine/*.yaml` before launching any benchmark. Outputs are written to the Hydra run directory
configured by the selected script/config and should not be committed.
