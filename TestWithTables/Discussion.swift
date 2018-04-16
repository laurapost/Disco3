//
//  Discussion.swift
//  TestWithTables
//
//  Created by Laura Post on 12/15/17.
//  Copyright © 2017 Laura Post. All rights reserved.
//

import UIKit
import os.log

class Discussion: Codable {
   
    //MARK: Properties
    var name: String
    var className: String
    var students: [Student]
    
    //MARK: Initialize stored properties
    init(name: String, className: String, students: [Student]) {
        self.name = name
        self.className = className
        self.students = students
    }

    
    
}
