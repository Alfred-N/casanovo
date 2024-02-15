#!/bin/bash

MGF_DATA_DIR="/Users/alfred/Datasets/OLD_FORMAT_9_species_MGF"

# Paths to folders containing the MGF files
TRAINING_SPECTRA_PATH="$MGF_DATA_DIR/train"
VALIDATION_SPECTRA_PATH="$MGF_DATA_DIR/val"
TEST_SPECTRA_PATH="$MGF_DATA_DIR/test"

CHECKPOINT_PATH="/Users/alfred/Checkpoints/Casanovo/casanovo_excl_yeast.ckpt"
CONFIG_PATH="/Users/alfred/Documents/Code/casanovo/_OUR_SCRIPTS/configs/default.yaml"

# Eval
casanovo --mode "eval" --test_data_path "$VALIDATION_SPECTRA_PATH" --model_path "$CHECKPOINT_PATH" --config_path "$CONFIG_PATH"

# Train
# casanovo sequence -o test_results.mztab  "$VALIDATION_SPECTRA_PATH"
