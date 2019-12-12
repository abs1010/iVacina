//
//  CadastroVacinaCustomCell.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

protocol CadastroVacinaCustomCellDelegate : class {
    func changeOfState(state: Bool, string: String, index: IndexPath)
}

class CadastroVacinaCustomCell: UITableViewCell {
    
    var profileViewController : ProfileViewController = ProfileViewController()
    
    @IBOutlet weak var vacinaLabel: UILabel!
    @IBOutlet weak var vacinaSwitch: UISwitch!
    
    weak var delegate : CadastroVacinaCustomCellDelegate?
    var index : IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vacinaSwitch.isOn = false
        self.vacinaSwitch.backgroundColor = .azulClaroCustom
        self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
    }
    
    @IBAction func changedStateOnSwitch(_ sender: UISwitch) {
        
        self.delegate?.changeOfState(state: sender.isOn, string: self.vacinaLabel.text!, index: index)
        
        if sender.isOn {
            //print("Liguei...\(self.vacinaLabel.text)")
            self.vacinaSwitch.backgroundColor = .azulEscuroCustom
            self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
        }
        else {
            //print("Desliguei huhu...\(self.vacinaLabel.text)")
            self.vacinaSwitch.backgroundColor = .azulClaroCustom
            self.vacinaSwitch.layer.cornerRadius = self.vacinaSwitch.frame.height / 2
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //========================================
    func setupCellForEdition(titular: Titular, indexPath: IndexPath, grupo: Grupo){
        
        self.index = indexPath
        if grupo == .Crianca {
            
            
        }
        
        if grupo == .Adolescente {
            
            
        }
        
        if grupo == .Adulto {
            
            switch indexPath.section {
            case 0:
                
                if indexPath.row == 2 {
                    self.vacinaLabel.text = "Hipertenso(a)"
                    self.vacinaSwitch.isOn = titular.hipertenso
                }
                if indexPath.row == 3 {
                    self.vacinaLabel.text = "Diabético(a)"
                    self.vacinaSwitch.isOn = titular.diabetico
                }
                if indexPath.row == 4 {
                    self.vacinaLabel.text = "Doador(a) de Órgãos"
                    self.vacinaSwitch.isOn = titular.doadorOrgaos
                }
                if indexPath.row == 5 {
                    self.vacinaLabel.text = "PCD"
                    self.vacinaSwitch.isOn = titular.pcd
                }
                
            case 1:
                
                //var inicio = 28
                //var fim = 38
                //for i in titular.listaVacinas
                
                if indexPath.row == 0 {
                    self.vacinaLabel.text = "VACINAS"
                    self.vacinaSwitch.isOn = titular.listaVacinas[0].status
                }
                
                
                
                
            default:
                self.vacinaLabel.text = "Problema ao carregar vacinas"
            }
            
            //             if indexPath.row == 2 && indexPath.section == 0 {
            //                self.vacinaLabel.text = "Hipertenso(a)"
            //                self.vacinaSwitch.isOn = titular.hipertenso
            //             }
            //             if indexPath.row == 3 && indexPath.section == 0 {
            //                self.vacinaLabel.text = "Diabético(a)"
            //                self.vacinaSwitch.isOn = titular.diabetico
            //             }
            //             if indexPath.row == 4 && indexPath.section == 0 {
            //                self.vacinaLabel.text = "Doador(a) de Órgãos"
            //                self.vacinaSwitch.isOn = titular.doadorOrgaos
            //             }
            //             if indexPath.row == 5 && indexPath.section == 0 {
            //                self.vacinaLabel.text = "PCD"
            //                self.vacinaSwitch.isOn = titular.pcd
            //             }
            
            
        }
        
        if grupo == .Idoso {
            
        }
        
        if grupo == .Gestante {
            
            
        }
        
        
    }
    
    //========================================
    func setupCellHeader(indexPath: IndexPath){
        self.index = indexPath
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
        self.index = indexPath
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
