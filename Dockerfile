ARG BASE=python:3.9.13-bullseye
FROM ${BASE} as base
FROM base as installer

RUN apt-get update && apt-get install -y curl

WORKDIR /tmp

ARG CONDA_VERSION=py39_4.12.0
ARG ARCH=Linux-x86_64
ARG PYTHON_VERSION=3.10.5
ARG CONDA_BASE_PATH=/opt/conda
ARG CONDA_BIN_PATH=${CONDA_BASE_PATH}/bin

RUN curl -fso install-conda.sh \
    https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-${ARCH}.sh
RUN bash install-conda.sh -b -p ${CONDA_BASE_PATH}

RUN ${CONDA_BIN_PATH}/conda install -c conda-forge -y python=${PYTHON_VERSION}

FROM base
COPY --from=installer ${CONDA_BASE_PATH} ${CONDA_BASE_PATH}
ENV PATH=${CONDA_BIN_PATH}:$PATH
