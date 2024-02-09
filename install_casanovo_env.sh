conda create --name casanovo_env python=3.10
conda activate casanovo_env

# Optional GPU support 
# conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia

# Install casanovo (locally from our fork)
pip install .

# we need pyarrow for the conversion script
pip install pyarrow

#After installation, test that it was successful by viewing the Casanovo command line interface help:
casanovo --help