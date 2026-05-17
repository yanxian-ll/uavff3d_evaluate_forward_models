#!/bin/bash

# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the Apache License, Version 2.0
# found in the LICENSE file in the root directory of this source tree.

export HYDRA_FULL_ERROR=1
export NUMEXPR_MAX_THREADS=16

# If no cuda device is given, default to cuda_device=0
CUDA_DEVICE=${1:-0}

# Each row contains: batch size, number of input views, Hydra dataset config, random seed.
batch_sizes_and_views=(
    "4 8 benchmark_518_uavff3d_enrich_usegeo_us3d 8"
    "3 16 benchmark_518_uavff3d_enrich_usegeo_us3d 16"
    "2 24 benchmark_518_uavff3d_enrich_usegeo_us3d 24"
    "1 32 benchmark_518_uavff3d_enrich_usegeo_us3d 32"
)

# Run all requested view-count settings.
for combo in "${batch_sizes_and_views[@]}"; do
    # Parse the row into shell variables.
    read -r batch_size num_views dataset seed <<< "$combo"
    
    echo "Running $dataset with batch_size=$batch_size and num_views=$num_views, seed=$seed"

    python3 \
        benchmarking/dense_n_view/benchmark.py \
        machine=aws \
        cuda_device=${CUDA_DEVICE} \
        seed=$seed \
        compute_abs_metrics=true \
        save_n_fused_ply=3 \
        dataset=$dataset \
        dataset.num_workers=12 \
        dataset.num_views=$num_views \
        batch_size=$batch_size \
        model=pi3x \
        model/task=images_only \
        model.pretrained='${root_experiments_dir}/mapanything/uav_training/pi3x_finetuning_16v_6d_16ipg_2g_mvs/checkpoint-best.pth' \
        hydra.run.dir='${root_experiments_dir}/mapanything/benchmarking/dense_'"${num_views}"'_view/pi3x_ft'

    echo "Finished running $dataset with batch_size=$batch_size and num_views=$num_views"
done
