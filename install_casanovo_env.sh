conda create --name casanovo_env python=3.10
conda activate casanovo_env

# Optional GPU support 
# conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia

# Install casanovo (locally from our fork)
pip install .