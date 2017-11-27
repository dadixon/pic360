//
//  InputTableViewCell.swift
//  pic360app
//
//  Created by Domonique Dixon on 11/24/17.
//  Copyright © 2017 pic360. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(text: String, placeholder: String) {
        nameLabel.text = text
        
        textField.placeholder = placeholder
        textField.accessibilityLabel = placeholder
    }

}
