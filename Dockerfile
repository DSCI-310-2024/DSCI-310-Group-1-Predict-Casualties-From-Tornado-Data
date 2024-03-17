FROM quay.io/jupyter/r-notebook:r-4.3.2

# Install R packages
RUN conda install -y --quiet \
    nb_conda_kernels=2.3.1 \
    r-irkernel=1.3.2 \ 
    r-psych=2.4.1 \ 
    r-ggally=2.2.1 \
    r-docopt=0.7.1 \
    r-kableextra=1.4.\
    jupyter-book=0.15.1 \
    make\
    quarto

# Quarto Installation

# Use root to install system-level packages
USER root

# Install system dependencies for Quarto
RUN apt-get update && apt-get install -y \
    make \
    gdebi

# Download and install Quarto
ARG QUARTO_VERSION="1.4.537"
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    gdebi --non-interactive quarto-linux-amd64.deb

# Switch back to the jovyan user
USER $NB_UID
    
