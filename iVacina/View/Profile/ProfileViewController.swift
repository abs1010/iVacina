//
//  ProfileViewController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var profileTableView: UITableView!
    
    var profileController: ProfileController = ProfileController()
    
    var selectedUser: Person?
    var group: Grupo = .Adulto
    //var selectedUser: Person = Person(nome: "Alan Silva", email: "abs10@globomail.com", imagem: "palmeiras", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: true, doadorOrgaos: true, pcd: false, vacinasCrianca: [[ .gripe : true, .caxumba : false ]], vacinasAdolescente: [[ .gripe : true]], vacinasAdulto: [[ .duplaAdultoDT : false, .gripe : true, .meningiteBACWY : true, .hpv : true, .pneumonia : true, .herpesZoster : true, .febreAmarela : false, .hepatiteB : true, .tripliceViral : false, .hepatiteA : true, .varicela : false]], vacinasIdoso: [[ .gripe : true]], vacinasGestante: [[ .gripe : true]], dependentes: ["Davi de Franca"])
    
    override func viewDidLoad() {
        self.selectedUser?.grupo = .Adulto
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "CadastroVacinaCustomCell", bundle: nil), forCellReuseIdentifier: "cadastroVacinaCustomCell")
        self.profileTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        
        self.imagem.image = UIImage(named: "loading")
        self.imagem.layer.cornerRadius = self.imagem.frame.size.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.nomeTextField.text = self.profileController.getPessoa()?.nome
        self.imagem.image = UIImage(named: self.profileController.getPessoa()?.imagem ?? "")
    }
    
    @IBAction func btnVoltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return 2
        case 1:
            switch self.group {
            case .Crianca:
                return vacinasCriancaEnum.allCases.count
            case .Adolescente:
                return vacinasAdolescenteEnum.allCases.count
            case .Adulto:
                return vacinasAdultoEnum.allCases.count
            case .Idoso:
                return vacinasIdosoEnum.allCases.count
            case .Gestante:
                return vacinasGestanteEnum.allCases.count
            }
            
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            if indexPath.row == 0 {
            
            let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
            cell.cellTitle.text = "Grupo"
            
           return cell
                
            }
            if indexPath.row == 1 {
             
             let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
             cell.cellTitle.text = "Tipo Sanguíneo "
             
            return cell
                 
             }
            
        case 1:

                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.setupCell(grupo: group, indexPath: indexPath)
                
                return cell ?? UITableViewCell()
            
        default:
            
            return UITableViewCell()
        
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
       
        case 0:
            return "Dados Pessois"
        case 1:
            return "Marque as vacinas que tomou"
        default:
            return ""
        }
            
    }
    
}
