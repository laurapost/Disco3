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
        
        //Enable the save button only if the text field has a valid name
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing
        saveStudent.isEnabled = false
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: - Navigation

    @IBAction func cancelStudent(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveStudent else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = studentTextField.text ?? ""
        //set the student to be passed to collectionviewcontroller after the unwind segue
        student = Student(name: name, number: 0, teacherComments: "")
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        //Disable the save button if the text field is empty
        let text = studentTextField.text ?? ""
        saveStudent.isEnabled = !text.isEmpty
    }

}
