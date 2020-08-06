//
//  HomeView.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct HomeView: View {
    @ObservedObject var motionManager: MotionManager
   
    
    var playButton: some View {
       HStack {
           Spacer()
           if motionManager.status == .stopped {
               Button(action: {self.motionManager.startSensorUpdates()}) {
                   Image(systemName: "playpause")
                    .resizable()
                    .frame(width: 45.0, height: 30.0)
                    .accentColor(.blue)
                       
               }
               .padding([.bottom, .trailing])
           } else if motionManager.status == .running {
               Button(action: {self.motionManager.stopSensorUpdates()}) {
                   Image(systemName: "playpause")
                    .resizable()
                    .frame(width: 45.0, height: 30.0)
                    .accentColor(.red)
                    
               }
               .padding([.bottom, .trailing])
           }
       }
       .padding([.bottom, .trailing], 15.0)
    }
    var body: some View {
        VStack {
            LiveSensorData(sensorName: "Attitude", sensorX: motionManager.data.attitude[0].x, sensorY: motionManager.data.attitude[0].y, sensorZ: motionManager.data.attitude[0].z)
            LiveSensorData(sensorName: "Gyroscope", sensorX: motionManager.data.gyro[0].x, sensorY: motionManager.data.gyro[0].y, sensorZ: motionManager.data.gyro[0].z)
            LiveSensorData(sensorName: "Accelerometer", sensorX: motionManager.data.acc[0].x, sensorY: motionManager.data.acc[0].y, sensorZ: motionManager.data.acc[0].z)
            LiveSensorData(sensorName: "Gravity", sensorX: motionManager.data.gravity[0].x, sensorY: motionManager.data.gravity[0].y, sensorZ: motionManager.data.gravity[0].z)
            LiveSensorData(sensorName: "Magnetometer", sensorX: motionManager.data.mag[0].x, sensorY: motionManager.data.mag[0].y, sensorZ: motionManager.data.mag[0].z)
            Spacer()
            playButton
        }
        .navigationBarTitle("Motion Tracker", displayMode: .inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(motionManager: MotionManager())
    }
}
