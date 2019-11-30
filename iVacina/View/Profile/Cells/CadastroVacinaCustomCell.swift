//
//  CadastroVacinaCustomCell.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class CadastroVacinaCustomCell: UITableViewCell {
    
    @IBOutlet weak var vacinaLabel: UILabel!
    @IBOutlet weak var vacinaSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vacinaSwitch.isOn = false
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(vacina: Vacina?){
        if let _vacina =  vacina{
            self.vacinaLabel.text = _vacina.nome
            self.vacinaSwitch.isOn = _vacina.status
        }
    }
    
    func setupCell(grupo: Grupo, indexPath: IndexPath){
        
        if grupo == .Crianca {
            
            let raw : String = "\(vacinasCriancaEnum(rawValue: indexPath.row) ?? vacinasCriancaEnum.none)"
            self.vacinaLabel.text = raw
            
        }
        
        if grupo == .Adulto {
            
            let raw : String = "\(vacinasAdultoEnum(rawValue: indexPath.row) ?? vacinasAdultoEnum.none)"
            self.vacinaLabel.text = raw
            
        }
        
    }
    
}
