//
//  ContentTableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet weak var btnSource: UIButton!
    
    var selectedNew : NewsElement?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentLabel.text = self.selectedNew?.content ?? ""
        
        self.btnSource.setGradientToButton(colorOne: .azulEscuroCustom, colorTwo: .azulClaroCustom)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
