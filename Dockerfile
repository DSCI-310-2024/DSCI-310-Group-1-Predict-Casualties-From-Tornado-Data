FROM quay.io/jupyter/r-notebook:r-4.3.2

# Install R packages
RUN conda install -y --quiet \
    nb_conda_kernels=2.3.1 \
    r-irkernel=1.3.2 \ 
    r-psych=2.4.1 \ 
    r-ggally=2.2.1 \
    r-docopt=0.7.1 \
    r-kableextra=1.4.\
    r-vdiffr=1.0.7 \
    r-testthat=3.2.0 \
    jupyter-book=0.15.1 \
    make

# To get specific version of quarto
USER root
ARG QUARTO_VERSION="1.4.537"
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN gdebi --non-interactive quarto-linux-amd64.deb

    
