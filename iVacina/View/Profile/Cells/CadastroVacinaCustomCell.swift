//
//  CadastroVacinaCustomCell.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

protocol CadastroVacinaCustomCellDelegate : class {
    func changeOfState(state: Bool, string: String)
}

class CadastroVacinaCustomCell: UITableViewCell {
    
    var profileViewController : ProfileViewController = ProfileViewController()
    
    @IBOutlet weak var vacinaLabel: UILabel!
    @IBOutlet weak var vacinaSwitch: UISwitch!
    
    //private var index : Int
    
    var delegate : CadastroVacinaCustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vacinaSwitch.isOn = false
        self.vacinaSwitch.backgroundColor = .azulClaroCustom
        self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
    }
    
    @IBAction func changedStateOnSwitch(_ sender: UISwitch) {
        
        self.delegate?.changeOfState(state: true, string: self.vacinaLabel.text!)
        
        if sender.isOn {
            print("Liguei...\(self.vacinaLabel.text)")
            self.vacinaSwitch.backgroundColor = .azulEscuroCustom
            self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
        }
        else {
            print("Desliguei huhu...\(self.vacinaLabel.text)")
            self.vacinaSwitch.backgroundColor = .azulClaroCustom
            self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
            
        }
        
        //        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
        //
        //              vc.delegate = self
        //
        //          }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCellHeader(indexPath: IndexPath){
        
        if indexPath.row == 2 && indexPath.section == 0 {
            self.vacinaLabel.text = "Hipertenso(a)"
        }
        if indexPath.row == 3 && indexPath.section == 0 {
            self.vacinaLabel.text = "Diabético(a)"
        }
        if indexPath.row == 4 && indexPath.section == 0 {
            self.vacinaLabel.text = "Doador(a) de Órgãos"
        }
        if indexPath.row == 5 && indexPath.section == 0 {
            self.vacinaLabel.text = "PCD"
        }
        
    }
    
    func setupCell(grupo: Grupo, indexPath: IndexPath){

        if grupo == .Crianca {
            
            let raw : String = "\(vacinasCriancaEnum(rawValue: indexPath.row) ?? vacinasCriancaEnum.none)"
            self.vacinaLabel.text = raw.replacingOccurrences(of: "_", with: " ")
            
        }
        
        if grupo == .Adolescente {
            
            let raw : String = "\(vacinasAdolescenteEnum(rawValue: indexPath.row) ?? vacinasAdolescenteEnum.none)"
            self.vacinaLabel.text = raw.replacingOccurrences(of: "_", with: " ")
            
        }
        
        if grupo == .Adulto {
            
            let raw : String = "\(vacinasAdultoEnum(rawValue: indexPath.row) ?? vacinasAdultoEnum.none)"
            
            self.vacinaLabel.text = raw.replacingOccurrences(of: "_", with: " ")
            
        }
        
        
        if grupo == .Idoso {
            
            let raw : String = "\(vacinasIdosoEnum(rawValue: indexPath.row) ?? vacinasIdosoEnum.none)"
            self.vacinaLabel.text = raw.replacingOccurrences(of: "_", with: " ")
            
        }
        
        if grupo == .Gestante {
            
            let raw : String = "\(vacinasGestanteEnum(rawValue: indexPath.row) ?? vacinasGestanteEnum.none)"
            self.vacinaLabel.text = raw.replacingOccurrences(of: "_", with: " ")
            
        }
        
    }
    
}
