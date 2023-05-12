# python-apt-binary

Build wheels of [python-apt](https://salsa.debian.org/apt-team/python-apt.git) for python3 on Debian Buster and Bullseye and upload them on PyPI.

python3-apt is directly available as an apt package, but the fact it is missing from PyPI prevents its use in an isolated virtual environment.

# Requirements

Run this on a Linux machine with docker CLI.

# How to use

```
$ run.sh
```
This builds the wheel packages and uploads them to testpypi.

```
$ run.sh prod
```
This builds the wheel packages and uploads them to the real PyPI instance.


