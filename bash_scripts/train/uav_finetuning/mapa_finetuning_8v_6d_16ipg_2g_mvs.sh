#!/bin/bash

# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the Apache License, Version 2.0
# found in the LICENSE file in the root directory of this source tree.

# Number of GPUs used by torchrun. Defaults to one GPU.
NUM_GPUS=${1:-1}

# Runtime logging settings
export HYDRA_FULL_ERROR=1
export NCCL_DEBUG=INFO
if command -v module >/dev/null 2>&1; then
    module load cuda/12.4 nccl/2.18.3-cuda.12.1 nccl_efa/1.24.1-nccl.2.18.3-cuda.12.0 libfabric-aws/2.1.0amzn5.0 openmpi5/5.0.6 || true
fi

# Distributed runtime settings. Override these in your cluster launcher if needed.
export OMP_NUM_THREADS=24
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
export FI_PROVIDER=efa
export FI_EFA_USE_DEVICE_RDMA=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_SET_CUDA_SYNC_MEMOPS=0
export NCCL_BUFFSIZE=8388608
export NCCL_P2P_NET_CHUNKSIZE=524288

# Launch UAVFF3D fine-tuning.
torchrun --nproc_per_node ${NUM_GPUS} \
    scripts/train.py \
    machine=aws \
    dataset=uavtrain_6d_518_many_ar_16ipg_2g \
    dataset.num_workers=12 \
    dataset.num_views=8 \
    loss=overall_loss_highpm_plus_rel_pose_no_conf \
    model=mapanything \
    model/task=mvs_training \
    model.encoder.gradient_checkpointing=true \
    model.info_sharing.module_args.gradient_checkpointing=true \
    model.pred_head.gradient_checkpointing=true \
    model.pretrained='checkpoints/map-anything/map-anything.pth' \
    train_params=finetune_with_lower_encoder_lr \
    train_params.lr=5e-06 \
    train_params.min_lr=5e-08 \
    train_params.submodule_configs.encoder.lr=1e-07 \
    train_params.submodule_configs.encoder.min_lr=1e-09 \
    train_params.epochs=10 \
    train_params.warmup_epochs=2 \
    train_params.accum_iter=8 \
    train_params.keep_freq=3 \
    train_params.max_num_of_imgs_per_gpu=16 \
    hydra.run.dir='${root_experiments_dir}/mapanything/uav_training/mapa_finetuning_16v_6d_16ipg_2g_mvs'

