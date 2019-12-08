//
//  StatusCustomCell.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import UIKit

class StatusCustomCell: UITableViewCell {

    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(vacina: Vacina?) {
        if let _vacina = vacina {
            let imageName: String
            self.descricaoLabel.text = _vacina.nome
            if _vacina.status {
                 imageName = "ok"
            } else {
                imageName = "pendente"
            }
            self.statusImage.image = UIImage(named: imageName)
        }
    }
    
}
