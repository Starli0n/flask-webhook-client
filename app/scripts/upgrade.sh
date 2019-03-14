#!/bin/bash

virtualenv venv -p python3
. scripts/activate.sh

pip install -U Flask

pip freeze 2>/dev/null > requirements.txt
