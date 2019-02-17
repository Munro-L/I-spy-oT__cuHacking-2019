from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps

app = Flask(__name__)
api = Api(app)

data = []

class LogTemps(Resource):
    def get(self):
        return {"data": data}

    def post(self):
        body = request.get_json()
        if body == None:
            return {'status': 'fail'}
        temp = body.get("temp")
        timeStamp = body.get("timeStamp")
        if temp == None or timeStamp == None:
            return {'status': 'fail'}
        curr = {'temp': temp, 'timeStamp': timeStamp}
        data.append(curr)
        return {'status':'success'}
class GetSingleTemp(Resource):
    def get(self):
        if len(data) > 0:
            return {"data": data[-1]}
        else:
            return {"data": data}

api.add_resource(LogTemps, '/logTemps')
api.add_resource(GetSingleTemp, '/logTemps/getOne')

if __name__ == '__main__':
    app.run()
