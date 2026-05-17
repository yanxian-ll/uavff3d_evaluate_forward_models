# External model adapters

This directory contains the external model wrappers used by the UAVFF3D fine-tuning and evaluation code.

Retained adapters:

- `vggt`: VGGT evaluation/fine-tuning adapter
- `pi3`: Pi3 evaluation/fine-tuning adapter
- `pi3x`: Pi3X evaluation/fine-tuning adapter with optional geometric priors
- `da3` and `da3_train`: Depth Anything 3 inference and trainable adapters
- `hunyuan` and `hunyuan_train`: HunyuanWorld-Mirror inference and trainable adapters

Depth Anything 3 and HunyuanWorld-Mirror are installed from the local `third_party/` directories. VGGT, Pi3, and Pi3X code is integrated here to keep the UAVFF3D benchmark self-contained.
