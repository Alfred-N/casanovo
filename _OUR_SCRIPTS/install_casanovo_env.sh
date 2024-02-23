conda create --name casanovo_2.1.1 python=3.10
conda activate casanovo_2.1.1

# Optional GPU support 
# conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia

# Install casanovo (locally from our fork)
python -m pip install .

# OR install the specific release "releases/download/v2.1.1/casanovo_excl_yeast.ckpt"
python -m pip install casanovo==2.1.1

# we need pyarrow for the conversion script
pip install pyarrow

#After installation, test that it was successful by viewing the Casanovo command line interface help:
casanovo --help