//
//  Time.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import Foundation
import CoreData


public class Times: NSObject, NSCoding, Identifiable {
    
    public var times: [Time] = []
    
    enum Key: String {
        case times = "times"
    }
    
    init(times: [Time]) {
        self.times = times
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(times, forKey: Key.times.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mTimes = aDecoder.decodeObject(forKey: Key.times.rawValue) as! [Time]
        
        self.init(times: mTimes)
    }
}


public class Time: NSObject, NSCoding, Identifiable {
    
    public var currentTime: Double = 0.0
    
    enum Key:String {
        case currentTime = "currentTime"
    }
    
    init(currentTime: Double) {
        self.currentTime = currentTime
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(currentTime, forKey: Key.currentTime.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mCurrentTime = aDecoder.decodeDouble(forKey: Key.currentTime.rawValue)
        
        self.init(currentTime: mCurrentTime)
    }
}

