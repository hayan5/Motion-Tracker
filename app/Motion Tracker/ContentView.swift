//
//  ContentView.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var motionManager: MotionManager
    
    var body: some View {
        NavigationView {
            HomeView(motionManager: motionManager)
            .navigationBarTitle("Motion Tracker", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: MovementsView()) {
                        Image(systemName: "folder")
                        .resizable()
                        .frame(width: 25.0, height: 20.0)
                }
            )
        }
        .onAppear() {
            self.motionManager.service.connect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContentView(motionManager: MotionManager()).environment(\.managedObjectContext, context)
    }
}
