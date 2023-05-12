#!/bin/bash
set -e
set -x

version=$(apt search python3-apt | grep 'python3-apt/' | awk '{print $2}')
git checkout $version
export DEBVER=$version
sed -i -e 's/name="python-apt"/name="python-apt-binary"/' setup.py
source .venv/bin/activate
pip wheel .
platform_tag=$(auditwheel show python_apt_binary-$version-*.whl | grep -o 'manylinux_[0-9]*_[0-9]*_x86_64')
wheel tags --remove --platform-tag $platform_tag python_apt_binary-$version-*.whl
