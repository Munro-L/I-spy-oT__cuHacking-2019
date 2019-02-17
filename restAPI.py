from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from json import loads

app = Flask(__name__)
api = Api(app)

fullData = []
currData = []
locationData = []
locked = 0
alarm = False

class LogTemps(Resource):
    def get(self):
        return {"data": fullData, "code": 0}

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
                result = {"data": currData.pop(0), "code": 0}
                return result
            else:
                return {"data": fullData, "code": 0}
        else:
            return {"data": [], "code": -1}

class GetLast(Resource):
    def get(self):
        if len(fullData) > 0:
            return {"data": fullData[-1], "code": 0}
        else :
            return {"data": [], "code": -1}

class Alarm(Resource):
    def post(self):
        global press
        body = loads(request.data)
        if body == None:
            return {'status': 'fail'}
        press = body.get("press")
        if press == None:
            return {'status': 'fail'}
        if press == 0:
            alarm = False
        elif press == 1:
            alarm = True
        else:
            return {'status', 'fail'}
        return {'status': 'success'}
    def get(self):
        return {'alarm': press}


class Location(Resource):
    def post(self):
        body = loads(request.data)
        if body == None:
            return {'status': 'fail'}
        longitude = body.get('long')
        latitude = body.get('lat')
        if longitude == None or latitude == None:
            return {'status': 'fail'}
        locationData.append({"lat": latitude, "long": longitude})
        return {'status', 'success'}
    def get(self):
        return {'data': locationData}


api.add_resource(LogTemps, '/logTemps')
api.add_resource(GetSingleTemp, '/logTemps/getOne')
api.add_resource(GetLast, "/logTemps/getLast")
api.add_resource(Alarm, '/alarm')
api.add_resource(Location, '/location')

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)
