#!/bin/bash

virtualenv venv -p python3
. scripts/activate.sh

pip install -r requirements.txt
