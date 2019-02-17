from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from json import loads

app = Flask(__name__)
api = Api(app)

fullData = []
currData = []
locked = 0

class LogTemps(Resource):
    def get(self):
        return {"data": fullData}

    def post(self):
        global locked
        body = loads(request.data)
        #body = request.get_json()
        if body == None:
            return {'status': 'fail'}
        temp = body.get("temp")
        timeStamp = body.get("timeStamp")
        if temp == None or timeStamp == None:
            return {'status': 'fail'}
        curr = {'temp': temp, 'timeStamp': timeStamp}
        fullData.append(curr)
        currData.append(curr)
        locked += 1
        return {'status':'success'}

class GetSingleTemp(Resource):
    def get(self):
        global locked
        if locked > 0:
            locked -= 1
            if len(currData) > 0:
                result = {"data": currData.pop(0)}
                return result
            else:
                return {"data": fullData}
        else:
            return {"data": -1}

api.add_resource(LogTemps, '/logTemps')
api.add_resource(GetSingleTemp, '/logTemps/getOne')

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)
