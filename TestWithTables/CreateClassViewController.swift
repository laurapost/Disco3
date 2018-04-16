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
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddClassMode = presentingViewController is UINavigationController
        if isPresentingInAddClassMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStudentTextField.delegate = self
        rosterNameTextField.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        updateSaveButtonState()
        
        //Set up views if editing
        if let roster = roster {
            navigationItem.title = roster.name
            rosterNameTextField.text = roster.name
            studentNames = roster.studentNames
        }
    }

    @IBAction func addStudent(_ sender: Any) {
        insertNewStudent()
        classes.archive(fileName: "SavedName")
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
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: Private methods
    func updateSaveButtonState() {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Intentionally blank in order to be able to use UITableViewRowActions
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteHandler: (UITableViewRowAction, IndexPath) -> Void = { _, indexPath in
            self.studentNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            classes.archive(fileName: "SavedName")
        }
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete", handler: deleteHandler)
        // Add more actions here if required
        updateSaveButtonState()
        return [deleteAction]
    }

}
