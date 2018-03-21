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
    var students: Array<Student>
    
    //Initializer
    init (name: String, students: Array<Student>) {
        self.name = name
        self.students = students
    }
    
}
