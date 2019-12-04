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
    @IBOutlet weak var groupLabel: UILabel!
    
    var controller : ProfileViewController?
    
    func setupCell(indexPath: IndexPath){
        
        //self.controller?.delegate = self
        
        if indexPath.row == 0 && indexPath.section == 0 {
            self.cellTitle.text = "Grupo"
        }
        if indexPath.row == 1 && indexPath.section == 0 {
            self.cellTitle.text = "Tipo Sanguíneo"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.controller?.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension OptionTableViewCell : ProfileViewControllerDelegate {
    func setGrupo(grupo: Grupo) {
        self.groupLabel.text = String("\(grupo)")
    }
    
}
