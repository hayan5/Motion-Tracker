//
//  MovementRow.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import SwiftUI

struct MovementRow: View {
    @Environment(\.managedObjectContext) var context
    
    let data: Movement
    static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd-HH:mm"
      return formatter
    }()
    
    
    var body: some View {
        
        return NavigationLink(destination: MovementDetail(data: data)) {
            HStack {
                VStack(alignment: .leading) {
                    data.name.map(Text.init)
                        .font(.headline)
                        .padding(/*@START_MENU_TOKEN@*/.bottom, 5.0/*@END_MENU_TOKEN@*/)
                    data.date.map { Text(Self.dateFormatter.string(from: $0))
                        .font(.subheadline)
                        .fontWeight(.thin)
                    }
                        .padding(.leading)
                }
                Spacer()
            }
            .padding(.all)
        }
    }
}

struct MovementRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MovementRow(data: Movement()).environment(\.managedObjectContext, context).previewLayout(.fixed(width: 350, height: 70))
    }
}
