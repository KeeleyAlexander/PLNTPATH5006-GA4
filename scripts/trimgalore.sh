#!/bin/bash
set -euo pipefail

#trimgalore container:
CONTAINER=oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4

# Copy the placeholder variables
r1fastq="$1"
r2fastq="$2"
outdir="$3"



# Initial logging
echo "Starting script trimgalore.sh"
date
# Create the output dir if needed
mkdir -p "$outdir"

# Run trimgalore with its container
apptainer exec "$CONTAINER" trim_galore -o "$outdir" --paired --fastqc "$r1fastq" "$r2fastq"

# Final logging
echo
echo "Used trim_galore version:2.3.0"
apptainer exec "$CONTAINER" trim_galore --version
echo
echo "Successfully finished script trimgalore.sh"
date