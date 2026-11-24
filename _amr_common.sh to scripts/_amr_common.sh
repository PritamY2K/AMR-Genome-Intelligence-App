#!/usr/bin/env bash
set -euo pipefail

fail() {
    echo "ERROR: $*" >&2
    exit 1
}

validate_sample() {
    [[ "$1" =~ ^GC[AF]_[0-9]+\.[0-9]+$ ]] ||
        fail "Invalid NCBI assembly accession"
}

check_setup() {
    for cmd in prodigal amrfinder abricate; do
        command -v "$cmd" >/dev/null 2>&1 ||
            fail "Missing required tool: $cmd"
    done

    [[ -n "${CARD_DIR:-}" ]] ||
        fail "Set CARD_DIR to the CARD local database directory"

    [[ -f "$CARD_DIR/localDB/card.json" ]] ||
        fail "CARD localDB/card.json not found"

    command -v "${RGI_BIN:-rgi}" >/dev/null 2>&1 ||
        fail "CARD-RGI executable not found"
}

run_amr_on_fasta() {
    local genome="$1"
    local prefix="$2"
    local results="${AMR_RESULTS_DIR:-./results}"

    [[ -s "$genome" ]] ||
        fail "Genome FASTA missing or empty"

    check_setup
    mkdir -p "$results"

    local abs_genome abs_results protein
    abs_genome="$(realpath "$genome")"
    abs_results="$(realpath "$results")"
    protein="$abs_results/${prefix}_proteins.faa"

    if find "$abs_results" -maxdepth 1 \
        -name "${prefix}_*" -print -quit | grep -q .; then
        fail "Existing analysis outputs detected; refusing to overwrite"
    fi

    prodigal -i "$genome" \
        -a "$protein" \
        -d "$results/${prefix}_genes.fna" \
        -o "$results/${prefix}_prodigal.gbk" \
        -p single

    amrfinder -p "$protein" \
        -o "$results/${prefix}_amrfinder.tsv"

    abricate --db resfinder "$genome" \
        > "$results/${prefix}_abricate_resfinder.tsv"

    abricate --db card "$genome" \
        > "$results/${prefix}_abricate_card.tsv"

    (
        cd "$CARD_DIR"
        "${RGI_BIN:-rgi}" main \
            -i "$abs_genome" \
            -o "$abs_results/${prefix}_rgi" \
            -t contig -a DIAMOND \
            --clean --local
    )

    echo "Standard AMR annotation completed."
}
