FROM quay.io/jupyter/r-notebook:r-4.3.2

# Install R packages
RUN conda install -y --quiet \
    nb_conda_kernels=2.3.1 \
    r-irkernel=1.3.2 \ 
    r-psych=2.4.1 \ 
    r-ggally=2.2.1 \
    r-docopt=0.7.1 \
    r-kableextra=1.4.\
    make=4.4.1\
    quarto=1.4.551\

# Quarto installing
# USER ${NB_UID} (If using one of the jupyter notebook images, insert this as well)

# ARG QUARTO_VERSION="1.4.551"
# RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
# RUN gdebi --non-interactive quarto-linux-amd64.deb

# #And to install gdebi:
# USER root

# RUN sudo -S \
#     apt-get update && apt-get install -y \
#     make \
#     gdebi
