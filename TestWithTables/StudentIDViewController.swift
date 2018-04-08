//
//  StudentIDViewController.swift
//  Disco3
//
//  Created by Laura Post on 4/5/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit

class StudentIDViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    var student = Student(name: "", number: 0, teacherComments: "")
    
    var showPoint: String?
    var showComment: String?
    
    @IBOutlet weak var points: UILabel!
    
    @IBOutlet weak var comments: UITextView!
    
    
    @IBOutlet weak var stepperVar: UIStepper!
    
    @IBAction func stepper(_ sender: UIStepper) {
        points.text = String(Int(sender.value))
        student.points = Int(points.text!)!
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        points.text = String(student.points)
        comments.text = student.comments
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments.delegate = self
        
        points.text = String(student.points)
        comments.delegate = self
        stepperVar.value = Double(student.points)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: TextView func
    
    func textViewDidEndEditing(_ textView: UITextView) {
        student.comments = textView.text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
