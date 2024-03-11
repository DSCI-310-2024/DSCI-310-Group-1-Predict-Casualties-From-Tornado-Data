FROM quay.io/jupyter/r-notebook:r-4.3.2

# Install R packages
RUN conda install -y --quiet \
    nb_conda_kernels=2.3.1 \ 
    r-psych=2.4.1 \ 
    r-ggally=2.2.1