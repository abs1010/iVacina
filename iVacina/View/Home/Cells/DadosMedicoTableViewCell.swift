//
//  DadosMedicoTableViewCell.swift
//  iVacina
//
//  Created by Bruna Ferreira on 22/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class DadosMedicoTableViewCell: UITableViewCell {

    @IBOutlet weak var grupoLabel: UILabel!
    @IBOutlet weak var idadeLabel: UILabel!
    @IBOutlet weak var tipoSanguineoLabel: UILabel!
    @IBOutlet weak var hipertensoLabel: UILabel!
    @IBOutlet weak var diabeticoLabel: UILabel!
    @IBOutlet weak var doadorLabel: UILabel!
    @IBOutlet weak var alergiaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(pessoa: Pessoa?){
        if let _pessoa = pessoa {
            let grupo: String
            switch _pessoa.grupo {
            case .Adolescente:
                grupo = "Adolescente"
            case .Adulto:
                grupo = "Adulto"
            case .Crianca:
                grupo = "Criança"
            default:
                grupo = "Idoso"
            }
            self.grupoLabel.text = grupo
//            self.idadeLabel.text = String(_pessoa.idade ?? 0)
//            self.tipoSanguineoLabel.text = _pessoa.tipoSanguineo
            self.hipertensoLabel.text = (_pessoa.hipertenso ?? true) ? "Sim" : "Não"
            self.diabeticoLabel.text = (_pessoa.diabetico ?? true) ? "Sim" : "Não"
            self.doadorLabel.text = (_pessoa.doadorOrgaos ?? true) ? "Sim" : "Não"
//            self.alergiaLabel.text = _pessoa.alergias
        }
    }
    
}
