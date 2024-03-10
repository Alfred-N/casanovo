import os
import pyteomics.mgf as mgf
from tqdm import tqdm
import re

# Read mgf predictions
mod_dict = {
    "C": "C+57.021",
    "M[15.9949]": "M+15.995",
    "[0.9840]": "+0.984",
}
n_term_mods = {
    "[-17.0265]": "-17.027",
    "[42.0106]": "+42.011",
    "[43.0058]": "+43.006",
    "[25.9803]": "+43.006-17.027",
}


def convert_mgf(mgf_in_path, mgf_out_path):
    spectra = []
    with mgf.MGF(mgf_in_path) as f_in:
        for spectrum_dict in tqdm(f_in):
            dn_seq = spectrum_dict["params"]["seq"]
            for dn_mod in mod_dict.keys():
                dn_seq = dn_seq.replace(dn_mod, mod_dict[dn_mod])
            for n_mod in n_term_mods.keys():
                if n_mod in dn_seq:
                    dn_seq = n_term_mods[n_mod] + dn_seq.replace(n_mod, "")

            # Remove periods that directly follow a letter, e.g. for the case
            # SEQ=K.YDSTHGR.Y which casanovo also cannot handle
            # But keep dots in the case SEQ=+43.006K.HIDAGAK.K
            # i.e. dots followed by digits is ok
            dn_seq = re.sub(r"(?<=[A-Za-z])\.(?=[A-Za-z])", "", dn_seq)

            spectrum_dict["params"]["seq"] = dn_seq
            spectra.append(spectrum_dict)

    mgf.write(spectra, mgf_out_path)


# input_mgf = "/Users/alfred/Datasets/dummy_mgf/BY_04_1.mgf"
# output_mgf = "zzz_test.mgf"
# convert_mgf(input_mgf, output_mgf)

input_dir = "/proj/bedrock/datasets/casanovo_datasets/ninespecies_revised_V2/massive.ucsd.edu/v01/MSV000090982/updates/2023-03-08_woutb_2c43c18c/peak/9speciesbenchmark/"
output_dir_base = "/proj/bedrock/datasets/casanovo_datasets/ninespecies_revised_CasaNovo_PTM_notation"

for root, dirs, files in tqdm(os.walk(input_dir), desc="Converting MGFS to CasaNovo's expected format"):
    for file in files:
        if file.endswith(".mgf"):
            input_file_path = os.path.join(root, file)
            relative_path = os.path.relpath(root, input_dir)
            output_dir = os.path.join(output_dir_base, relative_path)
            if not os.path.exists(output_dir):
                os.makedirs(output_dir)
            output_file_path = os.path.join(output_dir, file)
            # print(output_file_path)
            convert_mgf(input_file_path, output_file_path)