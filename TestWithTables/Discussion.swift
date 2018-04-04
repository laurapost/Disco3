//
//  Discussion.swift
//  TestWithTables
//
//  Created by Laura Post on 12/15/17.
//  Copyright © 2017 Laura Post. All rights reserved.
//

import UIKit
import os.log

class Discussion {
   
    //MARK: Properties
    var name: String
    var period: Class
    
    //MARK: Initialize stored properties
    init(name: String, period: Class) {
        self.name = name
        self.period = period
    }
}
