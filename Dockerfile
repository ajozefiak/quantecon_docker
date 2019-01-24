# Setup
FROM jupyter/datascience-notebook
LABEL maintainer="QuantEcon Project <admin@quantecon.org>"
ARG PACKAGEVERSION=v0.9.5

# Install unzip for Electron and packages for Cairo
USER root
RUN apt-get update && apt-get install -y --no-install-recommends unzip \
    gettext \
    zlib1g-dev \
    libffi-dev \
    libpng-dev \
    libpixman-1-dev \
    libpoppler-dev \
    librsvg2-dev \
    libcairo2-dev \
    libpango1.0-0 \
    pandoc \
    python-sphinx \
    rsync \
    vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch user back.
USER $NB_UID

# Jupinx stuff.
RUN pip install sphinxcontrib-bibtex && pip install nbconvert && \
    git clone https://github.com/quantecon/sphinxcontrib-jupyter && \
    cd sphinxcontrib-jupyter && \
    python setup.py install

# AWS with verification.
RUN pip install --upgrade awscli && aws --version

# QuantEcon Python stuff.
RUN pip install quantecon && \
    conda install sphinx=1.7.9 && \
    conda install pybtex=0.21 && \
    pip install qeds && \
    pip install linearmodels && \
    pip install interpolation

ADD ./julia_pkg.jl ./

RUN julia ./julia_pkg.jl