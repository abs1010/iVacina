//
//  ProfileViewController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    enum tipoVacina {
        case duplaAdultoDT
        case gripe
        case meningiteBACWY
        case hpv
        case pneumonia
        case herpesZoster
        case febreAmarela
        case hepatiteB
        case tripliceViral
        case hepatiteA
        case varicela
    }

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var profileTableView: UITableView!
    
    var profileController: ProfileController = ProfileController()
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "CadastroVacinaCustomCell", bundle: nil), forCellReuseIdentifier: "cadastroVacinaCustomCell")
        self.profileTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        
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
            return 4
        case 2:
            return self.profileController.getTamanhoListaVacina()
            
        default:
            return self.profileController.getTamanhoListaProximaVacina()
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            if indexPath.row == 1 {
            
            let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
            cell.cellTitle.text = "Grupo"
            
           return cell
                
            }
            if indexPath.row == 2 {
             
             let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
             cell.cellTitle.text = "Tipo Sanguíneo "
             
            return cell
                 
             }
            
        case 1:
            return UITableViewCell()
        case 2:
            
            return UITableViewCell()
            
//            //let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
//            //cell?.setCell(vacina: self.profileController.getPessoa()?.listaVacina[indexPath.row])
//            //return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
//            //let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
//            //cell?.setCell(vacina: self.profileController.getPessoa()?.listaProximaVacina[indexPath.row])
//            //return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 1:
            return "Marque as vacinas que tomou"
        default:
            return ""
        }
            
    }
    
}
