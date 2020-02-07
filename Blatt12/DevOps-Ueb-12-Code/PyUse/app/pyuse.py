#!/usr/bin/env python3
# verwendet pycalc-Dienst zum Addieren, 
# addiert Requestparameter x mit sich selbst

from flask import Flask
from flask_restful import Resource, Api, reqparse
import requests
import time,sys, os

app = Flask(__name__)
api = Api(app)

CALCURL = "http://pyapp_pycalc.pyapp_pynet:5000/calc?a={a}&b={b}"

class Dabbel(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument("x", type=int)
        args = parser.parse_args()
        x = args["x"]
        print("Dabbel:",x,file=sys.stderr)
        try:
            req = requests.get(CALCURL.format(a=x, b=x))
            res = req.text
        except Exception as exc:
            res = str(exc)
        return { "app":"pyuse", "result": str(res) }, 200

api.add_resource(Dabbel, '/dabbel')

if __name__ == '__main__':
        app.run(host="0.0.0.0", port=6000, threaded=False, debug=True)
