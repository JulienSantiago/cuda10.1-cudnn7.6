# Utiliser l'image officielle d'Ubuntu 18.04 comme base
FROM ubuntu:18.04


# Définir debconf pour fonctionner en mode non interactif
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip gcc wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Ajouter les dépôts de paquets NVIDIA pour CUDA 10.1
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.105-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1804_10.1.105-1_amd64.deb

# Ajouter la clé publique correcte
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

# Mettre à jour et installer CUDA
RUN apt-get update && apt-get install -y \
    cuda-10-1

# Installer les pilotes NVIDIA 418
RUN apt-get update && apt-get install -y \
    nvidia-driver-418

# Copier cuDNN .deb dans l'image Docker
COPY libcudnn7_7.6.3.30-1+cuda10.1_amd64.deb /tmp/libcudnn7.deb

# Installer cuDNN
RUN dpkg -i /tmp/libcudnn7.deb 

# Nettoyer les fichiers inutiles
RUN rm -rf /var/lib/apt/lists/* /tmp/*

# Définir les variables d'environnement pour CUDA
ENV PATH /usr/local/cuda-10.1/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda-10.1/lib64:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Vérifier l'installation de nvcc
RUN nvcc --version
