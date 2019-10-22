//
//  News2TableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 19/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class News2TableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.holderView.formatarUIView()
        //formatarUIView(containerView: holderView)
        self.holderView.setGradientToView(colorOne: UIColor.azulClaroCustom, colorTwo: UIColor.azulEscuroCustom)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
