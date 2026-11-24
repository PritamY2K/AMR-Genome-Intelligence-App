# AMR Genome Intelligence App

**Associated manuscript:** *AMR-Intel: An Integrated Computational Framework for Comparative Antimicrobial Resistance Gene Annotation and Genome-Scale Analysis*

**Target journal:** Computational Biology and Chemistry

## Overview

This repository provides nonproprietary computational resources supporting the comparative antimicrobial resistance gene annotation and genome-scale analysis reported in the associated manuscript.

The study evaluated 1,000 bacterial genome assemblies using established computational AMR annotation tools.

## Computational tools

The standard annotation workflow incorporates:

- Prodigal for protein-coding sequence prediction
- AMRFinderPlus for antimicrobial resistance determinant annotation
- ABRicate with CARD and ResFinder databases
- CARD-RGI for resistance gene annotation

## Dataset

The `accessions/all_accessions.txt` file contains 1,000 unique NCBI genome assembly accession identifiers.

## Standard workflow

The `scripts/` directory contains nonproprietary procedures for genome retrieval and AMR annotation.

The accession-based workflow can be invoked using:

```bash
bash scripts/run_accession_amr.sh GCA_OR_GCF_ACCESSION
```

The required software, reference databases and environment variables must be configured before execution. See `REPRODUCIBILITY.md` and `SOFTWARE_VERSIONS.md`.

## Comparative annotation results

The original analysis generated 111,142 tool-specific annotation records across four established annotation methods.

Differences in reported annotation numbers reflect the tools' database coverage, matching criteria and reporting conventions, and should not be interpreted as direct measures of diagnostic accuracy.

## Reproducibility

The included nonproprietary workflow has undergone a successful one-genome functional test. Complete reproduction of the frozen 1,000-genome analysis requires reconciliation of software versions, database releases and historical execution records.

## Data availability

The genome accession list is provided in this repository. Additional supporting research datasets may be deposited separately following scientific and confidentiality review.

## Intellectual property

This repository contains only separately reviewed, nonproprietary research resources. Confidential patent-related algorithms and implementation details are not included.

## Citation

Citation details for the associated manuscript will be added following publication.
