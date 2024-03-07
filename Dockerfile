FROM rocker/tidyverse:latest

# Install R packages and Jupyter Lab
RUN conda install -y --quiet \
    jupyterlab=4.1.2 \
    nb_conda_kernels=2.3.1 \
    r-base=4.1.3 \
    r-irkernel=1.3.2 \ 
    r-tidyverse=2.0.0 \ 
    r-tidymodels=1.1.0 \ 
    r-psych=2.3.3 \ 
    r-ggally=2.1.2