# flask-webhook-client
Api to consume webhooks using flask into Docker


## Quick Start

- Configuration: `make env` (Tweak `.env` after)
- Installation
    - Docker: `make app`
    - Native: `make native-app`
- Url: `make url`
- Test: `make curl`


## Auto register blueprint

The concept of blueprint is linked with Flask.

The app will parse the files inside the blueprint directory to find matching modules for blueprint.

A matching module requires:
- to be inside a directory
- to have a python file inside with the same name as the directory
- to have a blueprint inside the file with the same name and ending with `_webhook`

- Example: create `app/blueprint/test/test.py`
```python
from flask import Blueprint

test_webhook = Blueprint('test_webhook', __name__)

@test_webhook.route('/')
def test():
    return 'Test webhook'
```

The app will create a webhook client listening to http://localhost:5000/test


## Visual Code

- Install [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) extension

- Add this configuration to the `launch.json` file
```json
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "app/main.py"
            },
            "args": [
                "run",
                "--no-debugger",
                "--no-reload"
            ],
            "jinja": true
        },
```

- Add this configuration to the `settings.json` file
```json
{
    "python.pythonPath": "${workspaceRoot}/app/venv/Scripts/python.exe",
    "python.linting.pylintEnabled": true,
    "python.linting.enabled": true
}
```
