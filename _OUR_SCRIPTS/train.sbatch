#!/usr/bin/env bash
#SBATCH -A Berzelius-2024-32
#SBATCH -t 1-00:00:00
#SBATCH --gpus=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --output=slurm_outs/slurm-%j.out   # Redirect stdout to "slurm-outs" folder
#SBATCH --error=slurm_outs/slurm-%j.err    # Redirect stderr to "slurm-outs" folder

module load Anaconda/2021.05-nsc1
conda activate casanovo_env

MGF_DATA_DIR="/proj/bedrock/datasets/9_species_MGF"

# Full paths for the required MGF files with suffixes appended
TRAINING_SPECTRA_PATH1="$MGF_DATA_DIR/train-00000-of-00002-ca1fbc3de7c99259.mgf"
TRAINING_SPECTRA_PATH2="$MGF_DATA_DIR/train-00001-of-00002-fb1cb1b5c4a4ef4f.mgf"
VALIDATION_SPECTRA_PATH="$MGF_DATA_DIR/validation-00000-of-00001-b84568f5bf3ba95d.mgf"

CONFIG_FILE="_OUR_SCRIPTS/configs/default.yaml"
OUTPUT_FILE="train_excl_yeast.mztab"

casanovo train --config "$CONFIG_FILE" -o "$OUTPUT_FILE" --validation_peak_path "$VALIDATION_SPECTRA_PATH" "$TRAINING_SPECTRA_PATH1" "$TRAINING_SPECTRA_PATH2"
