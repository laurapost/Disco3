//
//  CreateStudentViewController.swift
//  Disco3
//
//  Created by Laura Post on 3/14/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log

class CreateStudentViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK- Properties
    
    var student: Student?
    
    @IBOutlet weak var studentTextField: UITextField!
    
    
    @IBOutlet weak var saveStudent: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveStudent else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = studentTextField.text ?? ""
        //set the student to be passed to collectionviewcontroller after the unwind segue
        student = Student(name: name, number: 0)
    }

}
