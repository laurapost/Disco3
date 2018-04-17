//
//  ClassesTableViewController.swift
//  Disco3
//
//  Created by Laura Post on 3/20/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit
import os.log

    var classes = ParentArr()

class ClassesTableViewController: UITableViewController {

    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use the edit button item provided by table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        classes.restore(fileName: "SavedName")
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
        return classes.classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "classCell"
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ClassTableViewCell else {
            
            fatalError("The dequed cell is not an instance of ClassTableViewCell")
        }
        //Fetched the appropriate class object for the data sourcec layout (had to use roster instead of class, but it is a class object)
        let roster = classes.classes[indexPath.row]
        
        cell.className.text = roster.name

        // Configure the cell...

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            classes.classes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            classes.archive(fileName: "SavedName")
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "viewDiscussion" :
            os_log("Viewing discussions", log: OSLog.default, type: .debug)
        
        case "addClass" :
            os_log("Adding a new class.", log: OSLog.default, type: .debug)
            
        case "showEdit" :
            guard let EditClassViewController = segue.destination as? CreateClassViewController else {
                fatalError("Unexpected destination")
            }
            guard let selectedClassCell = sender as? ClassTableViewCell else {
                fatalError("Unexpected destination")
            }
            guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
                fatalError("The selected cell is not being displayed on the table")
            }
            let selectedClass = classes.classes[indexPath.row]
            EditClassViewController.roster = selectedClass
            
            default:
            fatalError("Unexpected Segue indentifier")
        }

    }


    //MARK: Actions
    @IBAction func unwindToClassList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateClassViewController, let roster = sourceViewController.roster {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update a selected class
                classes.classes[selectedIndexPath.row] = roster
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                classes.archive(fileName: "SavedName")
            }
            else {
            
            // Add a new class
            let newIndexPath = IndexPath(row: classes.classes.count, section: 0)
            classes.classes.append(roster)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            classes.archive(fileName: "SavedName")
            }
        }
    }
}
