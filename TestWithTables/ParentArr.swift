//
//  DiscussionArr.swift
//  Disco3
//
//  Created by Laura Post on 4/16/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import Foundation
import os.log

class ParentArr: Codable {
    
    //MARK: Properties
    var discussions: [Discussion]
    var classes: [Class]
    
    init () {
        self.discussions = [Discussion]()
        self.classes = [Class]()
    }
    
    /**
     * Archive this MeetClass object
     * @param: fileName to which to archive this object
     */
    func archive (fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(encodedData, toFile: archiveURL.path)
            if isSuccessfulSave {
                print("Data successfully saved to file.")
            }
            else {
                print("Failed to save data.")
            }
        }
        catch {
            print("Failed to save data.")
        }
    }
    
    /**
     * Recover the previously archived Discussion object
     * @param: fileName from which to recover the previously archived file
     */
    func restore(fileName: String) {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(fileName)
        if let recoveredDataCoded = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Data {
            do {
                let recoveredData = try PropertyListDecoder().decode(ParentArr.self, from: recoveredDataCoded)
                os_log("Data successfully recovered from file.", log: OSLog.default, type: .debug)
                
                discussions = recoveredData.discussions
                classes = recoveredData.classes
                
            } catch {
                os_log("Failed to recover data", log: OSLog.default, type: .error)
            }
        } else {
            os_log("Failed to recover data", log: OSLog.default, type: .error)
        }
    }
    
}
