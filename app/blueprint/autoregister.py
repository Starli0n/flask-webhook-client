import os
import importlib

def blueprint(app):
    # Current directory of this file
    dir_path = os.path.dirname(os.path.realpath(__file__))

    # Loop into the files of that directory
    for f in os.listdir(dir_path):

        # Select file if it is a directory
        blueprint_path = os.path.join(dir_path, f)
        if os.path.isfile(blueprint_path):
            continue

        # Find the python file inside the directory with the same name
        blueprint_file = os.path.join(blueprint_path, f + '.py')
        if not os.path.isfile(blueprint_file):
            continue

        # Try to register that blueprint
        register_blueprint(app, f)

def register_blueprint(app, webhook_name):
    module_name = '{}.{}.{}'.format('blueprint', webhook_name, webhook_name)
    module = importlib.import_module(module_name)

    try:
        webhook = getattr(module, webhook_name + '_webhook')
        app.register_blueprint(webhook, url_prefix='/' + webhook_name)

    except:
        pass # No webhook found in the module
