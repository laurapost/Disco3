//
//  Discussion.swift
//  TestWithTables
//
//  Created by Laura Post on 12/15/17.
//  Copyright © 2017 Laura Post. All rights reserved.
//

import UIKit
import os.log

class Discussion: NSObject, NSCoding {
   
    //MARK: Properties
    var name: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("discussions")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
    }
    
    //MARK: Initialize stored properties
    init(name: String) {
        self.name = name
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Discussion object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(name: name)
    }
}
