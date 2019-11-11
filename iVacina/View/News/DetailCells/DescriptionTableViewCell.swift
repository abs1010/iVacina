//
//  DescriptionTableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var selectedNew : NewsElement?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.descriptionLabel.text = self.selectedNew?.articleDescription ?? ""
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
