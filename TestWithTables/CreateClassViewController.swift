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
    
    var studentNames = [String]()
    
    var roster: Class?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
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
        let newStudent = addStudentTextField.text
        studentNames.append(newStudent!)
        let indexPath = IndexPath(row: studentNames.count - 1, section: 0)
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
        let arr: [String] = studentNames
        roster = Class(name: name, studentNames: arr)
    }
}

extension CreateClassViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let student = studentNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? StudentTableViewCell
        cell?.studentName.text = student
        return cell!
        
    }

}
