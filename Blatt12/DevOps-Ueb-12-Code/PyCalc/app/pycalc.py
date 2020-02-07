#!/usr/bin/env python3
# https://flask-restful.readthedocs.io

from flask import Flask
from flask_restful import Resource, Api, reqparse
import time,sys, os

app = Flask(__name__)
api = Api(app)

class Calc(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument("a", type=int)
        parser.add_argument("b", type=int)
        args = parser.parse_args()
        res = args["a"] + args["b"]
        print("Calc: sleep",res, file=sys.stderr)
        time.sleep(res)
        return { "app":"calc", "result": res }, 200

api.add_resource(Calc, '/calc')

if __name__ == '__main__':
        app.run(host="0.0.0.0", threaded=False, debug=True)
