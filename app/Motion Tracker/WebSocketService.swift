//
//  WebSocketService.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 8/2/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import Foundation

struct JsonDataVector : Codable {
    let x : Double
    let y : Double
    let z : Double
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}

struct JsonData : Codable {
    let attitude : JsonDataVector
    let gyro : JsonDataVector
    let gravity : JsonDataVector
    let acc : JsonDataVector
    let mag : JsonDataVector
    let time : Date
    
    init(attitude: Vector, gyro: Vector, gravity: Vector, acc: Vector, mag: Vector, time: Date) {
        self.attitude = JsonDataVector(x: attitude.x, y: attitude.y, z: attitude.z)
        self.gyro = JsonDataVector(x: gyro.x, y: gyro.y, z: gyro.z)
        self.gravity = JsonDataVector(x: gravity.x, y: gravity.y, z: gravity.z)
        self.acc = JsonDataVector(x: acc.x, y: acc.y, z: acc.z)
        self.mag = JsonDataVector(x: mag.x, y: mag.y, z: mag.z)
        self.time = time
        
    }
}

class WebSocketService : ObservableObject {
    
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    
    private var IP = "192.168.1.255"
    
    private let baseURL = URL(string: "ws://192.168.1.151:8080/")!
    
    
    
    func connect() {
        
        stop()
        webSocketTask = urlSession.webSocketTask(with: baseURL)
        webSocketTask?.resume()
        
        sendMessage(msg: "******** IOS WebSocket Connected ********")
    }
    
    func stop(){
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    private func sendMessage(msg: String) {
       
        
        let message = URLSessionWebSocketTask.Message.string(msg)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket couldnt send message because: \(error)")
            }
        }
    }
    
    func sendData(attitude: Vector, gyro: Vector, gravity: Vector, acc: Vector, mag: Vector, time: Date) {
        let data = JsonData(attitude: attitude, gyro: gyro, gravity: gravity, acc: acc, mag: mag, time: time)
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            webSocketTask?.send(message) { error in
                if let error = error {
                    print("WebSocket couldnt send message because: \(error)")
                }
            }
        } catch { print(error) }
    }
    
}
