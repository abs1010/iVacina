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
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.azulEscuroCustom.cgColor
        self.layer.borderWidth = 0.5

    }

    func setupCell(pessoa: Titular, indexPath: IndexPath){
        
        if indexPath.row == 0 {
        
        self.nameLabel.text = pessoa.nome
        self.grupoLabel.text = String("\(pessoa.grupo)")
        self.typeLabel.text = "Titular"
        
        let userDefaults = UserDefaults.standard
        
        if let imageData = userDefaults.data(forKey: String("\(pessoa.imagem)")),
            let image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage {
            
            self.profileImageView.image = image
        }
        
        }
        else {
            
            self.nameLabel.text = pessoa.dependentes[indexPath.row - 1]?.nome
            self.grupoLabel.text = String("\(pessoa.dependentes[indexPath.row - 1]?.grupo)")
            self.typeLabel.text = "Dependente \(indexPath.row - 1)"
            
            let userDefaults = UserDefaults.standard
            
            if let imageData = userDefaults.data(forKey: String("\(pessoa.dependentes[indexPath.row - 1]?.imagem)")),
                let image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage {
                
                self.profileImageView.image = image
            }
            
        }
    }
    
}
