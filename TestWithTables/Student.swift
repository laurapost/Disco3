//
//  Student.swift
//  Disco3
//
//  Created by Laura Post on 3/14/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log


class Student {
    
    //MARK- Properties
    var studentName: String
    var points: Int
    
    //Initializer
    init (name: String, number: Int) {
        self.studentName = name
        self.points = number
    }
    
}
