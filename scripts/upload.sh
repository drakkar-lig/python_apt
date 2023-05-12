#!/bin/bash

if [ "$1" = "prod" ]
then
    repo_args=""
else
    repo_args="-r testpypi"
fi

source .venv/bin/activate
twine upload $repo_args python_apt_binary-*-manylinux*_x86_64.whl
