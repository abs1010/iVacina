//
//  OptionTableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 29/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var btnLista: UIButton!
    
    func setupCell(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
