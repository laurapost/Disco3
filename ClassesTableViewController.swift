//
//  ClassesTableViewController.swift
//  Disco3
//
//  Created by Laura Post on 3/20/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log

    var classes = [Class]()

class ClassesTableViewController: UITableViewController {

    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "classCell"
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ClassTableViewCell else {
            
            fatalError("The dequed cell is not an instance of ClassTableViewCell")
        }
        //Fetched the appropriate class object for the data sourcec layout (had to use roster instead of class, but it is a class object)
        let roster = classes[indexPath.row]
        
        cell.className.text = roster.name

        // Configure the cell...

        return cell
    }

    //MARK: Actions
    @IBAction func unwindToClassList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateClassViewController, let roster = sourceViewController.roster {
            // Add a new class
            let newIndexPath = IndexPath(row: classes.count, section: 0)
            classes.append(roster)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
