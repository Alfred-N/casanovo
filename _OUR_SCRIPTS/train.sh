#!/bin/bash

MGF_DATA_DIR="/Users/alfred/Datasets/9_species_MGF"

# Full paths for the required MGF files with suffixes appended
TRAINING_SPECTRA_PATH1="$MGF_DATA_DIR/train-00000-of-00002-ca1fbc3de7c99259.mgf"
TRAINING_SPECTRA_PATH2="$MGF_DATA_DIR/train-00001-of-00002-fb1cb1b5c4a4ef4f.mgf"
VALIDATION_SPECTRA_PATH="$MGF_DATA_DIR/validation-00000-of-00001-b84568f5bf3ba95d.mgf"

CONFIG_FILE="_OUR_SCRIPTS/configs/default.yaml"
OUTPUT_FILE="train_excl_yeast.mztab"

# conda deactivate
# conda activate casanovo_env

# Eval
# casanovo evaluate "$VALIDATION_SPECTRA_PATH"

# Train
casanovo train --config "$CONFIG_FILE" -o "$OUTPUT_FILE" --validation_peak_path "$VALIDATION_SPECTRA_PATH" "$TRAINING_SPECTRA_PATH1" "$TRAINING_SPECTRA_PATH2"
