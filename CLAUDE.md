# Practice RNA-Seq project

Practice project for the course PLNTPTH 5006, using RNA-Seq data from Garrigós et al.
(2025) on Culex pipiens mosquitoes infected with two avian Plasmodium species.

## Data

- FASTQ files are in `../garrigos/fastq`: paired-end, ~75-bp Illumina reads for
  22 samples, subsampled to 500,000 reads per file
- Sample metadata is in `../garrigos/meta/metadata.tsv`
- Never modify, move, or delete anything in `../garrigos`

## Project structure

- `scripts/`: scripts
- `results/`: all output, in a separate subdir for each step (e.g. `results/fastqc`)

## Computing infrastructure

- We work at the Ohio Supercomputer Center (OSC)
- I haven't yet learned how to submit batch jobs, so don't propose to use these
  (and therefore run programs with a single core/thread)

## Shell script conventions

- Start scripts with `#!/bin/bash` and `set -euo pipefail`
- Below that, add a comment block with the script's purpose and a usage line
  (e.g. `# Usage: bash scripts/fastqc.sh <FASTQ file> <output dir>`)
- Copy arguments to descriptively named, lowercase variables (e.g. `fastq="$1"`);
  use uppercase only for constants (e.g. `CONTAINER=...`)
- At the start, report the script name, the date, and the inputs;
  at the end, report the program version, a success message, and the date
- Create output dirs with `mkdir -p` before writing to them
- Strike a balance between script functionality and robustness vs. simplicity and
  readability: I am a shell beginner
- In script comments, briefly explain any non-obvious commands, options, and constructs
- Programs that aren't available in the system path should be run with Apptainer
  containers from Seqera Containers (`oras://` URLs),
  not with `module load` or by installing them