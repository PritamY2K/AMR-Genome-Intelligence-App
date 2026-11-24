#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: bash download_ncbi_genome.sh GCA_or_GCF_accession" >&2
    exit 1
fi

ACCESSION="$1"

if [[ ! "$ACCESSION" =~ ^GC[AF]_[0-9]+\.[0-9]+$ ]]; then
    echo "ERROR: Invalid NCBI assembly accession" >&2
    exit 1
fi

for cmd in datasets unzip; do
    command -v "$cmd" >/dev/null 2>&1 || {
        echo "ERROR: Required command not found: $cmd" >&2
        exit 1
    }
done

DOWNLOAD_BASE="${AMR_DOWNLOAD_DIR:-./ncbi_downloads}"
DOWNLOAD_DIR="$DOWNLOAD_BASE/$ACCESSION"
ZIP_FILE="$DOWNLOAD_BASE/${ACCESSION}.zip"

mkdir -p "$DOWNLOAD_BASE"

if [[ -e "$ZIP_FILE" || -e "$DOWNLOAD_DIR" ]]; then
    echo "ERROR: Existing download detected; refusing to overwrite." >&2
    exit 1
fi

datasets download genome accession "$ACCESSION" \
    --include genome,gff3,protein \
    --filename "$ZIP_FILE"

mkdir "$DOWNLOAD_DIR"

unzip -q "$ZIP_FILE" -d "$DOWNLOAD_DIR"

FASTA_FILE="$(find "$DOWNLOAD_DIR" -type f -name '*genomic.fna' -print -quit)"

if [[ -z "$FASTA_FILE" ]]; then
    echo "ERROR: Genomic FASTA not found." >&2
    exit 1
fi

echo "Genome successfully downloaded."
echo "FASTA: $FASTA_FILE"
