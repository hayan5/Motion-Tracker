//
//  Vector.swift
//  Motion Tracker
//
//  Created by Harrison Ayan on 7/17/20.
//  Copyright © 2020 Harrison Ayan. All rights reserved.
//

import Foundation
import CoreData


public class Vectors: NSObject, NSCoding, Identifiable {
    
    public var vectors: [Vector] = []
    
    enum Key: String {
        case vectors = "vectors"
    }
    
    init(vectors: [Vector]) {
        self.vectors = vectors
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(vectors, forKey: Key.vectors.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mVectors = aDecoder.decodeObject(forKey: Key.vectors.rawValue) as! [Vector]
        
        self.init(vectors: mVectors)
    }
}


public class Vector: NSObject, NSCoding, Identifiable {
    
    public var x: Double = 0.0
    public var y: Double = 0.0
    public var z: Double = 0.0
    
    enum Key:String {
        case x = "x"
        case y = "y"
        case z = "z"
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(x, forKey: Key.x.rawValue)
        aCoder.encode(y, forKey: Key.y.rawValue)
        aCoder.encode(z, forKey: Key.z.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mx = aDecoder.decodeDouble(forKey: Key.x.rawValue)
        let my = aDecoder.decodeDouble(forKey: Key.y.rawValue)
        let mz = aDecoder.decodeDouble(forKey: Key.z.rawValue)
        
        self.init(x: mx, y: my, z: mz)
    }
}

