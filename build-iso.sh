#!/usr/bin/env bash
# Build the Alnix ISO into out/.
#
# Builds the local package repository first if it does not exist yet (or when
# --rebuild-repo is given), then runs mkarchiso with a pacman.conf that
# includes that repository.
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="${root_dir}/repo/x86_64"
work_dir="${root_dir}/work"

if (( EUID != 0 )); then
    echo "This script must be run as root: sudo $0" >&2
    exit 1
fi

if [[ "${1:-}" == "--rebuild-repo" || ! -f "${repo_dir}/alnix-local.db" ]]; then
    "${root_dir}/build-repo.sh"
fi

# mkarchiso needs an absolute path to the local repo, so generate the final
# pacman.conf here instead of hardcoding a path into the profile.
mkdir -p "$work_dir"
{
    cat "${root_dir}/alnix/pacman.conf"
    printf '\n[alnix-local]\nSigLevel = Optional TrustAll\nServer = file://%s\n' "$repo_dir"
} > "${work_dir}/pacman.conf"

rm -rf "${work_dir}/iso"
mkarchiso -v -C "${work_dir}/pacman.conf" -w "${work_dir}/iso" -o "${root_dir}/out" "${root_dir}/alnix"
chown -R "$(stat -c '%u:%g' "$root_dir")" "${root_dir}/out"
