from flask import Flask, render_template
from os import environ

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route('/page')
def index():
    return render_template('index.html', title='Pagina de Inicio')

if __name__ == "__main__":
    port = int(environ.get("FLASK_PORT_ENV", 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
