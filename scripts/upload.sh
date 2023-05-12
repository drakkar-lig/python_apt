#!/bin/bash

if [ "$1" = "prod" ]
then
    echo 'Note: uploading to PyPI.'
    repo_args=""
else
    echo 'Note: uploading to testpypi -- use "./run.sh prod" to target the real PyPI instance.'
    repo_args="-r testpypi"
fi

source .venv/bin/activate
twine upload $repo_args python_apt_binary-*-manylinux*_x86_64.whl
