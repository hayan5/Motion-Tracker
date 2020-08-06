//
//  MovementsView.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct MovementsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Movement.entity(),
        sortDescriptors: []
    ) var movements: FetchedResults<Movement>
    
    var body: some View {
        List {
            ForEach(movements) { movement in
                HStack {
                    VStack(alignment: .leading) {
                        MovementRow(data: movement)
                    }
                }
            }.onDelete { indexSet in
                for index in indexSet {
                    self.managedObjectContext.delete(self.movements[index])
                }
            }
        }
        .navigationBarTitle("Recordings", displayMode: .large)
        .navigationBarItems(trailing:
            NavigationLink(destination: RecordingView( motionManager: MotionManager())) {
                    Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
            }
        )
    }
}

struct MovementsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MovementsView().environment(\.managedObjectContext, context)
    }
}
