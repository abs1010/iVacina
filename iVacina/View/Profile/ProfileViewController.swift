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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.register(UINib(nibName: "CadastroVacinaCustomCell", bundle: nil), forCellReuseIdentifier: "cadastroVacinaCustomCell")
        
        self.nomeTextField.text = self.profileController.getPessoa()?.nome
        self.imagem.image = UIImage(named: self.profileController.getPessoa()?.imagem ?? "")
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return self.profileController.getTamanhoListaVacina()
            
        default:
            return self.profileController.getTamanhoListaProximaVacina()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        case 1:
            let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
            cell?.setCell(vacina: self.profileController.getPessoa()?.listaVacina[indexPath.row])
            return cell ?? UITableViewCell()
        default:
            let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
            cell?.setCell(vacina: self.profileController.getPessoa()?.listaProximaVacina[indexPath.row])
            return cell ?? UITableViewCell()
        }
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
