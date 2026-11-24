# Reproducibility Guide

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

## Historical validation runner

The original study used additional validation resources,
including a 1,000-genome validation workflow.

The historical validation runner and its intermediate
research files are not included in this publication
repository. The commands for those unavailable files
must not be represented as executable instructions
for the public repository.

The included scripts provide a separate
accession-based annotation workflow.

## Safety warning

Some Bash scripts remove and recreate accession-specific
download or assembly directories.

Use a dedicated analysis directory. Do not execute these
scripts against valuable or irreplaceable working directories
without reviewing their operations.

## AST evidence and data availability

The source-reported AST observations and selected
computational annotations are available in the
published Zenodo dataset:

https://doi.org/10.5281/zenodo.24497233

Historical evidence-matching scripts and their
intermediate research files are not included
in this publication repository.

The deposited annotation subset excludes CARD-based
tool results.

Evidence matching is not equivalent to independently
validated genotype-phenotype prediction.

## Reproducibility limitation

Exact reproduction requires the reference database releases,
software versions, input data, original directory structure,
and runtime configuration used in the frozen analysis.
The documented software and database versions
describe an inspected environment and have not
been established as an exact historical execution
snapshot.

The released accession-based scripts support a
limited reproducibility workflow, not automatic
reconstruction of all historical study outputs.
