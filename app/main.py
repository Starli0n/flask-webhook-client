from flask import Flask
import blueprint.autoregister as autoregister

app = Flask(__name__)
autoregister.blueprint(app)

@app.route('/')
def hello():
    return 'Flask webhook client'
