#!/bin/bash

MGF_DATA_DIR="/Users/alfred/Datasets/9_species_MGF"

# Full paths for the required MGF files with suffixes appended
TRAINING_SPECTRA_PATH1="$MGF_DATA_DIR/train-00000-of-00002-ca1fbc3de7c99259.mgf"
TRAINING_SPECTRA_PATH2="$MGF_DATA_DIR/train-00001-of-00002-fb1cb1b5c4a4ef4f.mgf"
VALIDATION_SPECTRA_PATH="$MGF_DATA_DIR/validation-00000-of-00001-b84568f5bf3ba95d.mgf"

# conda deactivate
# conda activate casanovo_env

# Eval
# casanovo evaluate "$VALIDATION_SPECTRA_PATH"

# Train
casanovo sequence -o test_results.mztab  "$VALIDATION_SPECTRA_PATH"
