FROM condaforge/mambaforge:4.13.0-1

ARG USERNAME=appuser
ARG GROUPNAME=${USERNAME}
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${GROUPNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

RUN apt-get update -q \
    && apt-get install -q -y --no-install-recommends \
    curl \
    git \
    git-lfs \
    && apt-get clean

RUN rm -rf /tmp/* /var/lib/apt/lists/*

USER appuser

WORKDIR /home/${USERNAME}

COPY /.condarc .


