#!/bin/bash

virtualenv venv -p python3
. venv/bin/activate

pip install -r requirements.txt
