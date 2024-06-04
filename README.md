You have to download the "libcudnn7_7.6.3.30-1+cuda10.1_amd64.deb" file from here : https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/
and put it in the same repository than your dockerfile

You will then have to open a terminal in this directory, and launch the command :
docker build -t nvidia-cuda-10.1-devel-ubuntu-18.04 .
