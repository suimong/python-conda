FROM condaforge/mambaforge:4.13.0-1

ARG USERNAME=appuser
ARG GROUPNAME=${USERNAME}
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG CONDA_ENV_NAME=workbench
ARG CONDA_ENV_FILE=conda-env-${CONDA_ENV_NAME}-base.yml


RUN groupadd --gid ${USER_GID} ${GROUPNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

RUN apt-get update -q \
    && apt-get install -q -y --no-install-recommends \
    curl \
    git \
    git-lfs \
    && apt-get clean

# requires super user privilege
RUN rm -rf \
    /tmp/* \
    /var/lib/apt/lists/*

USER appuser

WORKDIR /home/appuser

COPY /${CONDA_ENV_FILE} .

RUN mamba env create -f ${CONDA_ENV_FILE}

RUN rm -rf ./${CONDA_ENV_FILE}

RUN mamba init

# CMD conda activate ${CONDA_ENV_NAME}
