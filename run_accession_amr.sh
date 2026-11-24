#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/_amr_common.sh"

[[ $# -eq 1 ]] ||
    fail "Usage: bash run_accession_amr.sh GCA_or_GCF_accession"

ACCESSION="$1"
validate_sample "$ACCESSION"

for cmd in datasets unzip; do
    command -v "$cmd" >/dev/null 2>&1 ||
        fail "Required command missing: $cmd"
done

DOWNLOAD_BASE="${AMR_DOWNLOAD_DIR:-./ncbi_downloads}"
DOWNLOAD_DIR="$DOWNLOAD_BASE/$ACCESSION"
ZIP_FILE="$DOWNLOAD_BASE/${ACCESSION}.zip"

mkdir -p "$DOWNLOAD_BASE"

[[ ! -e "$ZIP_FILE" && ! -e "$DOWNLOAD_DIR" ]] ||
    fail "Existing download detected; refusing to overwrite"

datasets download genome accession "$ACCESSION" \
    --include genome \
    --filename "$ZIP_FILE"

mkdir "$DOWNLOAD_DIR"
unzip -q "$ZIP_FILE" -d "$DOWNLOAD_DIR"

GENOME_FASTA="$(
    find "$DOWNLOAD_DIR" \
        -type f -name '*genomic.fna' -print -quit
)"

[[ -n "$GENOME_FASTA" ]] ||
    fail "No genomic FASTA found"

run_amr_on_fasta "$(realpath "$GENOME_FASTA")" "$ACCESSION"
