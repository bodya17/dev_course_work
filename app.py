from flask import Flask, request, render_template, jsonify
from flask_cors import CORS, cross_origin
import numpy as np
import lssq

app = Flask(__name__)
CORS(app)

@app.route("/")
def index():
    return render_template('index.html')

@app.route('/least_squares', methods=['POST', 'GET'])
def least_squares():
    data = request.data.decode("utf-8").split('|')
    return jsonify(lssq.main(data[0].replace('e', str(np.e)), int(data[1]), float(data[2]), float(data[3]), int(data[4])))

@app.route('/<text>')
def hi(text):
    return text

@app.route('/data')
def data():
    cb = request.args.get('callback')
    print(cb)
    # print(request.args.get('hobby'))
    return cb + "('bye')"

if __name__  == "__main__":
    app.run()
