#!/bin/bash
set -e

for deb_version in buster bullseye
do
    cat >> Dockerfile  << EOF

FROM debian:$deb_version
RUN apt update
RUN apt install -y python3 python3-dev python3-venv libapt-pkg-dev gcc g++ git vim
WORKDIR /root
RUN git clone https://salsa.debian.org/apt-team/python-apt.git
WORKDIR /root/python-apt
RUN python3 -m venv .venv
RUN . .venv/bin/activate && pip install --upgrade pip && \
    pip install wheel auditwheel twine keyrings.cryptfile
ADD scripts /scripts
RUN /scripts/build.sh
ENTRYPOINT /scripts/upload.sh
EOF

    docker build -t python-apt:$deb_version .
    rm Dockerfile
done

if [ "$1" != "prod" ]
then
    echo 'Note: uploading to testpypi -- add argument "prod" to target the real PyPI instance.'
fi

for deb_version in buster bullseye
do
    docker run -it --rm python-apt:$deb_version "$@"
done
