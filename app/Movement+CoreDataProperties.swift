//
//  Movement+CoreDataProperties.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//
//

import Foundation
import CoreData


extension Movement: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movement> {
        return NSFetchRequest<Movement>(entityName: "Movement")
    }

    @NSManaged public var acc: Vectors?
    @NSManaged public var attitude: Vectors?
    @NSManaged public var gravity: Vectors?
    @NSManaged public var gyro: Vectors?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var duration: Double
    @NSManaged public var time: Times?
    @NSManaged public var id: UUID?

}
