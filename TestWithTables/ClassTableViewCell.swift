//
//  ClassTableViewCell.swift
//  Disco3
//
//  Created by Laura Post on 3/20/18.
//  Copyright © 2018 Laura Post. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    @IBOutlet weak var className: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
