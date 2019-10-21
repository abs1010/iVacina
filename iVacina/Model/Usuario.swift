//
//  Usuario.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

class Usuario {
    var nome: String
    var email: String
    var senha: String
    
    init(nome: String, email: String, senha: String) {
        self.nome = nome
        self.email = email
        self.senha = senha
    }
}
