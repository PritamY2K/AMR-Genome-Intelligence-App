.# Reproducibility Guide

## Operating system

The original workflow was developed under Windows 11
using WSL Ubuntu and Conda environments.

## Required software

NCBI Datasets CLI, unzip, Prodigal, AMRFinderPlus,
ABRicate, CARD-RGI, Python and pandas.

Raw-read workflows additionally require fastp, SPAdes and QUAST.

## Accession-based analysis

The main Bash entry point is:

    bash scripts/run_accession_amr.sh GCF_OR_GCA_ACCESSION

This script downloads the requested genome and invokes
the AMR analysis tools.

The shared Bash configuration is located at:

    scripts/_amr_common.sh

## Validation runner

The Python validation runner accepts:

    python3 scripts/run_amr_validation_1000.py --base PROJECT_ROOT --dry-run

The runner requires the original project directory layout,
including Validation/amr_panel_1000_intermediate.json
and scripts/run_accession_amr.sh.

The dry-run option should be used before any actual execution.

## Safety warning

Some Bash scripts remove and recreate accession-specific
download or assembly directories.

Use a dedicated analysis directory. Do not execute these
scripts against valuable or irreplaceable working directories
without reviewing their operations.

## AST evidence matching

The evidence matching script expects:

    Validation/phenotype_validation/AMR_Intel_1000_AST_validation_master.tsv
    Validation/phenotype_validation/all_1000_tool_predictions.tsv

It produces:

    Validation/phenotype_validation/AMR_AST_ResFinder_evidence_matches.tsv

Evidence matching is not equivalent to validated
genotype-phenotype prediction.

## Reproducibility limitation

Exact reproduction requires the reference database releases,
software versions, input data, original directory structure,
and runtime configuration used in the frozen analysis.
These requirements are being verified before public release.
