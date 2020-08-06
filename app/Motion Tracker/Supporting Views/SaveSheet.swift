//
//  SaveSheet.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct SaveSheet: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject var motionManager: MotionManager
    
    @State var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recording")) {
                    TextField("Name", text: $name)
                }
                
                Button(action : {
                    self.saveRecording()
                }) {
                    Text("Save Recording")
                }
            }
        }
    }
    
    func saveRecording() {
        guard self.name != "" else {return}
        
        let fileFormat = DateFormatter()
        fileFormat.dateFormat = "y-MM-dd-HH:mm"
        
        
        let newMovement = Movement(context: self.managedObjectContext)
        newMovement.id = UUID()
        newMovement.name = self.name
        newMovement.date = Date()
        newMovement.time = Times(times: self.motionManager.data.time)
        newMovement.attitude = Vectors(vectors: self.motionManager.data.attitude)
        newMovement.gyro = Vectors(vectors: self.motionManager.data.gyro)
        newMovement.gravity = Vectors(vectors: self.motionManager.data.gravity)
        newMovement.acc = Vectors(vectors: self.motionManager.data.acc)
        newMovement.duration = self.motionManager.duration
        
        do {
            try self.managedObjectContext.save()
            print("Data Saved")
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SaveSheet_Previews: PreviewProvider {
    static var previews: some View {
        return SaveSheet(motionManager: MotionManager())
    }
}
