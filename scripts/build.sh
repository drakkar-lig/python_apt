#!/bin/bash
set -e
set -x

# find the version of the apt package in this debian version
version=$(apt search python3-apt | grep 'python3-apt/' \
           | awk '{print $2}')
# point to the corresponding git tag of the repo
git checkout $version
# setup.py will use env variable DEBVER for the version
export DEBVER=$version
sed -i -e 's/name="python-apt"/name="python-apt-binary"/' setup.py
# fix an issue occuring when installing the wheel
sed -i -e 's/\(shutil.copy.*install_purelib\)/pass  # \1/' setup.py
# build the wheel
# (unfortunately the platform tag obtained is too loose, but we will fix that below)
source .venv/bin/activate
pip wheel .
# use auditwheel to retrieve the <a>.<b> versioning of manylinux compatibility
# (this is linked to the version of glibc)
platform_tag=$(auditwheel show python_apt_binary-$version-*.whl | grep -o 'manylinux_[0-9]*_[0-9]*_x86_64')
# update the platform tag of the wheel
wheel tags --remove --platform-tag $platform_tag python_apt_binary-$version-*.whl
