//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import Foundation
import os.log


// Class representing one item on the the to do list
class ToDoItem: NSObject, NSCoding {
    
    // MARK: properties
    var completed: Bool
    var itemDescription: String?
    let timeCreated: NSDate?
    var timeCompleted: NSDate?
    var priority: Int
    
    //MARK: archiving paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("toDoItems")
    
    
    // MARK: initialization
    init?(completed: Bool, itemDescription: String?, timeCreated: NSDate?, timeCompleted: NSDate?, priority: Int)
    {
        if let itemInfo = itemDescription {
            self.completed = completed
            self.itemDescription = itemInfo
            self.timeCreated = timeCreated
            self.timeCompleted = nil
            self.priority = priority
        }
        else {
            return nil
        }
    }
    
    //MARK: methods
    func formatTime(time: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: time as Date)
    }
    
    //MARK: NSEncoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(completed, forKey: "completed")
        aCoder.encode(itemDescription, forKey: "description")
        aCoder.encode(timeCreated, forKey: "timeCreated")
        aCoder.encode(timeCompleted, forKey: "timeCompleted")
        aCoder.encode(priority, forKey: "priority")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let itemDescription = aDecoder.decodeObject(forKey: "description") as? String else {
            os_log("Unable to decode the description for a Todo object.", log: OSLog.default, type: .debug)
            return nil
        }
    
        let priorityValue = aDecoder.decodeCInt(forKey: "priority")
        let completed = aDecoder.decodeBool(forKey: "completed")
        let timeCreated = aDecoder.decodeObject(forKey: "timeCreated") as? NSDate
        let timeCompleted = aDecoder.decodeObject(forKey: "timeCreated") as? NSDate
        self.init(completed: completed, itemDescription: itemDescription, timeCreated: timeCreated, timeCompleted: timeCompleted, priority: Int(priorityValue))
    }
    
}
