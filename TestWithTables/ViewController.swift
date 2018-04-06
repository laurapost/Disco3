//
//  CreateViewController.swift
//  TestWithTables
//
//  Created by Laura Post on 12/15/17.
//  Copyright © 2017 Laura Post. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    var discussion: Discussion?
    var periods: [Class] = classes
    var students: [Student] = []

    
    //MARK: Pickerview functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return periods[row].name
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periods.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let studentNames: [String]
        studentNames = periods[row].studentNames
        for student in studentNames {
            let newStudent = Student(name: student, number: 0, teacherComments: "")
            students.append(newStudent)
        }
        discussion = Discussion(name: nameTextField.text!, className: periods[row].name, students: students)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push), this view controller needs to be dismissed in two different ways
        let isPresentingInAddDiscussionMode = presentingViewController is UINavigationController
       
        if isPresentingInAddDiscussionMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller")
        }
    }
    
    //method that lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        discussion?.name = nameTextField.text!
    }
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input
        nameTextField.delegate = self
       
        //Enable the Save button only if the text field has a valid discussion name
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Private Methods
    private func updateSaveButtonState() {
        //Disable the Save button is the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

