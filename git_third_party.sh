#!/usr/bin/env bash
set -euo pipefail

# Clone optional external projects for local debugging/development.
# These checkouts are ignored by git. The modified bundled projects
# mapabase, depth-anything-3, and HunyuanWorld-Mirror are intentionally
# kept in this repository and are not cloned here.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THIRD_PARTY_DIR="${ROOT_DIR}/third_party"

mkdir -p "${THIRD_PARTY_DIR}"

clone_repo() {
  local dir_name="$1"
  local repo_url="$2"
  local ref="${3:-}"

  local target="${THIRD_PARTY_DIR}/${dir_name}"
  if [[ -d "${target}/.git" ]]; then
    echo "[skip] ${dir_name} already exists"
    return
  fi

  if [[ -d "${target}" && -n "$(find "${target}" -mindepth 1 -maxdepth 1 2>/dev/null)" ]]; then
    echo "[skip] ${dir_name} exists and is not empty"
    return
  fi

  echo "[clone] ${repo_url} -> third_party/${dir_name}"
  git clone "${repo_url}" "${target}"

  if [[ -n "${ref}" ]]; then
    git -C "${target}" checkout "${ref}"
  fi
}

clone_repo "LightGlue" "https://github.com/cvg/LightGlue.git"
clone_repo "AnyCalib" "https://github.com/javrtg/AnyCalib.git"
clone_repo "croco" "https://github.com/naver/croco.git" "croco_module"
clone_repo "dust3r" "https://github.com/naver/dust3r.git" "dust3r_setup"
clone_repo "mast3r" "https://github.com/Nik-V9/mast3r.git"
clone_repo "must3r" "https://github.com/naver/must3r.git"
clone_repo "Pi3" "https://github.com/yyfz/Pi3.git"
clone_repo "pow3r" "https://github.com/Nik-V9/pow3r.git"
clone_repo "robustmvd" "https://github.com/infinity1096/robustmvd.git"
clone_repo "asmk" "https://github.com/lojzezust/asmk.git"
clone_repo "nvdiffrast" "https://github.com/NVlabs/nvdiffrast.git"
clone_repo "MoGe" "https://github.com/microsoft/MoGe.git"

echo "External third-party checkouts are ready."
