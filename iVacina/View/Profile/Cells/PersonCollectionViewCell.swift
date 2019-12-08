//
//  PersonCollectionViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 06/12/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var grupoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
         self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.azulEscuroCustom.cgColor
        self.layer.borderWidth = 0.5

    }

    func setupCell(pessoa: Pessoa){
     
        self.profileImageView.image = UIImage(named: String("\(pessoa.imagem)"))
        self.nameLabel.text = pessoa.nome
        self.grupoLabel.text = String("\(pessoa.grupo)")
        
    }
    
}
