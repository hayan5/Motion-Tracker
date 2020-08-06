//
//  MotionManager.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import Foundation
import CoreMotion


struct motionData {
    var attitude: [Vector] = [Vector(x: 0.0, y: 0.0, z: 0.0)]
    var gyro: [Vector] = [Vector(x: 0.0, y: 0.0, z: 0.0)]
    var gravity: [Vector] = [Vector(x: 0.0, y: 0.0, z: 0.0)]
    var acc: [Vector] = [Vector(x: 0.0, y: 0.0, z: 0.0)]
    var mag: [Vector] = [Vector(x: 0.0, y: 0.0, z: 0.0)]
    var time: [Time] = [Time(currentTime: 0.0)]
}


class MotionManager: ObservableObject {
    
    @Published var data = motionData()
    @Published var timeElapsed = 0.0
    @Published var status: ManagerState = .stopped
    @Published var showSaveSheet = false
    
    var service = WebSocketService()
    var duration = 5.0
    var startTime = Date()
    var timer = Timer()
    var counter = Timer()
    
    let motionManager = CMMotionManager()
    
    enum ManagerState {
        case stopped
        case running
        case recording
    }
    
    
    func setDuration(duration: Double) {
        self.duration = duration
    }
    
    
    func startSensorUpdates() {
        if status == .stopped { status = .running }
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!, withHandler: {
                (motion: CMDeviceMotion?, error: Error?) in self.getMotionData(deviceMotion: motion!)
            })
        }
    }
    
    
    func stopSensorUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
        status = .stopped
    }
    
    
    func getMotionData(deviceMotion: CMDeviceMotion) {
        let attitude = Vector()
        let gyro = Vector()
        let gravity = Vector()
        let acc = Vector()
        let mag = Vector()
        let time = Time()
        
        attitude.x = deviceMotion.attitude.pitch
        attitude.y = deviceMotion.attitude.roll
        attitude.z = deviceMotion.attitude.yaw
        gyro.x = deviceMotion.rotationRate.x
        gyro.y = deviceMotion.rotationRate.y
        gyro.z = deviceMotion.rotationRate.z
        gravity.x = deviceMotion.gravity.x
        gravity.y = deviceMotion.gravity.y
        gravity.z = deviceMotion.gravity.z
        acc.x = deviceMotion.userAcceleration.x
        acc.y = deviceMotion.userAcceleration.y
        acc.z = deviceMotion.userAcceleration.z
        mag.x = deviceMotion.magneticField.field.x
        mag.y = deviceMotion.magneticField.field.y
        mag.z = deviceMotion.magneticField.field.z
        time.currentTime = 0.0
        
        service.sendData(attitude: attitude, gyro: gyro, gravity: gravity, acc: acc, mag: mag, time: Date())
        
        if status == .recording {
            data.attitude.append(attitude)
            data.gyro.append(gyro)
            data.gravity.append(gravity)
            data.acc.append(acc)
            time.currentTime = DateInterval(start: self.startTime, end: Date()).duration
            data.time.append(time)
        } else if status == .running {
            data.attitude[0] = attitude
            data.gyro[0] = gyro
            data.gravity[0] = gravity
            data.acc[0] = acc
            data.mag[0] = mag
            data.time[0] = time
        }
    }
    
    
    func clearSensorData() {
        data.attitude = [Vector(x: 0.0, y: 0.0, z: 0.0)]
        data.gyro = [Vector(x: 0.0, y: 0.0, z: 0.0)]
        data.gravity = [Vector(x: 0.0, y: 0.0, z: 0.0)]
        data.acc = [Vector(x: 0.0, y: 0.0, z: 0.0)]
        data.time = [Time(currentTime: 0.0)]
    }
    
    
    func startRecording() {
        if status == .running {
            self.stopSensorUpdates()
            self.clearSensorData()
        }
        
        status = .recording
        self.startTime = Date()
        self.startSensorUpdates()
        
        counter = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { counter in
            self.timeElapsed += 0.1
        }
        timer = Timer.scheduledTimer(withTimeInterval: self.duration, repeats: false) { timer in
            self.stopRecording()
        }
        
    }
    
    
    func stopRecording() {
        self.stopSensorUpdates()
        showSaveSheet = true
        timeElapsed = 0.0
        timer.invalidate()
        counter.invalidate()
    }
}
