import websocket
import json
from threading import Thread
import numpy as np
class Network:
    def __init__(self):
        self.data = np.zeros(3)
        websocket.enableTrace(True)
        self.ws = websocket.WebSocketApp('ws://192.168.1.151:8080/',
            on_message = lambda ws, msg: self.on_message(ws, msg),
            on_error   = lambda ws, msg: self.on_error(ws, msg),
            on_close   = lambda ws:      self.on_close(ws),
            on_open    = lambda ws:      self.on_open(ws)
        ) 

    def on_message(self, ws, message):
        msg = json.loads(message)
        
        self.data[0] = msg['gyro']['x']
        self.data[1] = msg['gyro']['y']
        self.data[2] = msg['gyro']['z']
        # print(msg)

    def on_error(self, ws, error):
        print(error)

    def on_close(self, ws):
        print("### closed ###")

    def on_open(self, ws):
        ws.send("Hello %d")

    def run(self):
        self.ws.run_forever()
        return


