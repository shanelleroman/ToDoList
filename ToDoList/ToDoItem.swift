//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import Foundation

// Class representing one item on the the to do list
class ToDoItem {
    // MARK: properties
    var completed: Bool
    var itemDescription: String?
    let timeCreated: NSDate?
    var timeCompleted: NSDate?
    
    // MARK: initialization
    init?(completed: Bool, itemDescription: String?, timeCreated: NSDate?, timeCompleted: NSDate?)
    {
        if let itemInfo = itemDescription {
            self.completed = false
            self.itemDescription = itemInfo
            self.timeCreated = timeCreated
            self.timeCompleted = nil
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
    
}
