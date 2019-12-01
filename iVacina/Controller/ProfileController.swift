//
//  ProfileController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

class ProfileController {
    var pessoa: Pessoa?
    var profileViewController : ProfileViewController?
    
    var grupoArray : [String] = ["Criança", "Adoslecente", "Adulto", "Idoso", "Gestante"]
    
    func getTamanhoListaVacina() -> Int{
        return self.pessoa?.listaVacina.count ?? 0
    }
    
    func getTamanhoListaProximaVacina() -> Int{
        return self.pessoa?.listaProximaVacina.count ?? 0
    }
    
    func setPessoa(pessoa: Pessoa?){
        if let _pessoa = pessoa{
            self.pessoa = _pessoa
        }
    }
    
    func getPessoa() -> Pessoa?{
        return self.pessoa
    }
}
