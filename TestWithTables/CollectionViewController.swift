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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

}
