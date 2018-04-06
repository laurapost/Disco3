//
//  class.swift
//  Disco3
//
//  Created by Laura Post on 3/20/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log

class Class {
    
    //MARK: Properties
    var name: String
    var studentNames: Array<String>
    
    //Initializer
    init (name: String, studentNames: Array<String>) {
        self.name = name
        self.studentNames = studentNames
    }
    
}
