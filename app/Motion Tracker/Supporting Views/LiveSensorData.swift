//
//  LiveSensorData.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct LiveSensorData: View {
    
    var sensorName: String
    var sensorX: Double
    var sensorY: Double
    var sensorZ: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(sensorName)
                    .padding(.bottom, 5.0)
                    .font(.headline)
                
                Text("x: \(sensorX, specifier: "%f")")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(.leading)
                
                Text("y: \(sensorY, specifier: "%f")")
                    .font(.subheadline)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                
                Text("z: \(sensorZ, specifier: "%f")")
                    .font(.subheadline)
                    .foregroundColor(Color.green)
                    .padding(.leading)
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct LiveSensorData_Previews: PreviewProvider {
    static var previews: some View {
        LiveSensorData(sensorName: "Attitude", sensorX: 0.000, sensorY: 0.000, sensorZ: 0.000)
    }
}
