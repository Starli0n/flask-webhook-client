#!/bin/bash

virtualenv venv -p python3
. venv/bin/activate

pip install -U Flask

pip freeze 2>/dev/null > requirements.txt
