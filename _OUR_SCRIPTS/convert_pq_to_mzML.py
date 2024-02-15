import os
import pandas as pd
from tqdm import tqdm

# Define your input and output directories
input_dir = "/Users/alfred/Documents/Datasets/9_species"
output_dir = "/Users/alfred/Datasets/9_species_MGF"

# Create the output directory if it doesn't exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)


def translate_modifications(sequence):
    # Mapping of modifications from dataset to model expected format
    modification_mapping = {
        "C(+57.02)": "C+57.021",
        "M(+15.99)": "M+15.995",
        "N(+.98)": "N+0.984",
        "Q(+.98)": "Q+0.984",
        # Add more mappings as necessary
    }

    for original, translated in modification_mapping.items():
        sequence = sequence.replace(original, translated)

    return sequence


def convert_parquet_to_mgf(input_file, output_file):
    # Load the Parquet file
    df = pd.read_parquet(input_file)

    # Open the output MGF file
    with open(output_file, "w") as f:
        for index, row in tqdm(
            df.iterrows(), desc=f"Converting file {input_file}"
        ):
            f.write("BEGIN IONS\n")
            f.write(
                f"TITLE={index}\n"
            )  # Assuming each row's index can be used as TITLE
            f.write(f"PEPMASS={row['precursor_mz']}\n")
            f.write(f"CHARGE={row['precursor_charge']}+\n")
            # f.write(f"SCANS=F1:{index}\n")  # Assuming index for SCANS as well, adjust as necessary
            # f.write(f"RTINSECONDS={row.get('rtinseconds', 0)}\n")  # Placeholder, add this column to your data if available
            _SEQ = row["modified_sequence"]
            f.write(f"SEQ={translate_modifications(_SEQ)}\n")
            # Write the m/z and intensity pairs
            for mz, intensity in zip(row["mz_array"], row["intensity_array"]):
                f.write(f"{mz} {intensity}\n")

            f.write("END IONS\n\n")


# Loop through all Parquet files in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith(".parquet"):
        input_file_path = os.path.join(input_dir, filename)
        output_file_path = os.path.join(
            output_dir, filename.replace(".parquet", ".mgf")
        )
        convert_parquet_to_mgf(input_file_path, output_file_path)
        print(f"Converted {filename} to MGF format.")
