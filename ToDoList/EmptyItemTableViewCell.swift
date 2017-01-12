//
//  EmptyItemTableViewCell.swift
//  ToDoList
//
//  Created by Shanelle Roman on 1/12/17.
//  Copyright © 2017 Shanelle Roman. All rights reserved.
//

import UIKit

class EmptyItemTableViewCell: UITableViewCell {
    @IBOutlet weak var emptyDescription: UITextField!

    @IBOutlet weak var addButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
