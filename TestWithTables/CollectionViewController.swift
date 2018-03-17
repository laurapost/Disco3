//
//  CollectionViewController.swift
//  Disco3
//
//  Created by POST, LAURA on 1/9/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var students = [Student]()
    
    //MARK: Actions
@IBAction func unwindToStudentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateStudentViewController, let student = sourceViewController.student {
            //Add a new student
            let newIndexPath = IndexPath(item: students.count, section: 0)
            students.append(student)
            collectionView.insertItems(at: [newIndexPath])
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionViewCell
        let student = students[indexPath.item]
        cell?.studentLabel.text = student.studentName
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
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
