//
//  MovementDetail.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct MovementDetail: View {
    var data: Movement

    @State private var isShareSheetShowing = false
    
    
    var body: some View {
        NavigationView {
            Button(action: shareButton) {
                HStack() {
                    Text("\(data.date!)")
                    Text("Export CSV")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    func shareButton() {
        let fileFormat = DateFormatter()
        fileFormat.dateFormat = "yy-MM-dd"
//        let fileDate = fileFormat.string(from: data.date!)
        let fileName = "\(data.name ?? "export").csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        var csvText = "time,attitude_x,attitude_y,attitude_z,gyro_x,gyro_y,gyro_z,gravity_x,gravity_y,gravity_z,acc_x,acc_y,acc_z\n"
        
        for (i,acc) in data.acc!.vectors.enumerated() {
            csvText += "\(data.time!.times[i].currentTime),\(data.attitude!.vectors[i].x),\(data.attitude!.vectors[i].y),\(data.attitude!.vectors[i].z),\(data.gyro!.vectors[i].x),\(data.gyro!.vectors[i].y),\(data.gyro!.vectors[i].z),\(data.gravity!.vectors[i].x),\(data.gravity!.vectors[i].y),\(data.gravity!.vectors[i].z),\(acc.x),\(acc.y),\(acc.z)\n"
        }
        
        do {
            try csvText.write(to:path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("failed to create file")
            print("\(error)")
        }
        print(path ?? "not fount")
        
        var filesToShare = [Any]()
        filesToShare.append(path!)
        
        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        
        isShareSheetShowing.toggle()
        
    }
}

struct MovementDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovementDetail(data: Movement())
    }
}
