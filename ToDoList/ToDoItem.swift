//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import Foundation

class ToDoItem {
    // MARK: properties
    var completed: Bool
    var itemDescription: String?
    
    // MARK: initialization
    init?(completed: Bool, itemDescription: String?)
    {
        if let itemInfo = itemDescription {
            self.completed = completed
            self.itemDescription = itemInfo
        }
        else {
            return nil
        }
    }
    
}
