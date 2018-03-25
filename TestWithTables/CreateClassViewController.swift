//
//  CreateClassViewController.swift
//  Disco3
//
//  Created by Laura Post on 3/21/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import SafariServices
import os.log

class CreateClassViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addStudentTextField: UITextField!
    @IBOutlet weak var rosterNameTextField: UITextField!
    
    var students = [Student]()
    
    var roster: Class?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStudentTextField.delegate = self
        rosterNameTextField.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        updateSaveButtonState()
    }

    @IBAction func addStudent(_ sender: Any) {
        insertNewStudent()
    }
    
    func insertNewStudent() {
        let newStudent = Student(name: addStudentTextField.text!, number: 0, teacherComments: "")
        students.append(newStudent)
        let indexPath = IndexPath(row: students.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addStudentTextField.text = ""
        view.endEditing(true)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        //Disable the save button if the text field is empty
        let text = rosterNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = rosterNameTextField.text ?? ""
        let arr: [Student] = students
        roster = Class(name: name, students: arr)
    }
}

extension CreateClassViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? StudentTableViewCell
        cell?.studentName.text = student.studentName
        return cell!
        
    }

}
