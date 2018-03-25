//
//  CreateClassViewController.swift
//  Disco3
//
//  Created by Laura Post on 3/21/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import SafariServices

class CreateClassViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addStudentTextField: UITextField!
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStudentTextField.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
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
