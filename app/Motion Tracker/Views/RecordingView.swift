//
//  RecordingView.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct RecordingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var motionManager: MotionManager
    
    @State var recordDuration: Double = 5.0
    
    
    var durationSlider: some View {
        VStack {
            Text("Record Duration: \(recordDuration,  specifier: "%.1f")")
                .font(.headline)
            Slider(value: $recordDuration, in: 0...10, step: 0.1)
                .padding(.horizontal, 30.0)
        }
    }
    
    var recordButton: some View {
        HStack {
            if motionManager.status != .recording {
                Button(action: {
                    self.motionManager.setDuration(duration: self.recordDuration);
                    self.motionManager.startRecording();
                }) {
                        Text("Start")
                            .fontWeight(.semibold)
                            .font(.title)
                            .multilineTextAlignment(.center)
                }
                .frame(minWidth: 0, maxWidth: 200)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
            } else if motionManager.status == .recording {
                Button(action: {
                        self.motionManager.stopRecording()}) {
                            Text("Stop")
                                .fontWeight(.semibold)
                                .font(.title)
                                .multilineTextAlignment(.center)
                }
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(String(format:"%.1f",self.motionManager.timeElapsed))
                durationSlider
                recordButton
            }
            .sheet(isPresented: $motionManager.showSaveSheet) {
                SaveSheet(motionManager: self.motionManager).environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return RecordingView(motionManager: MotionManager()).environment(\.managedObjectContext, context)
    }
}
