//
//  File.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import Foundation

struct Pessoa {
    var nome: String
    var listaVacina: [Vacina]
    var listaProximaVacina: [Vacina]
    var grupo: Grupo
    var imagem: String
    var idade: Int?
    var tipoSanguineo: String?
    var hipertenso: Bool?
    var diabetico: Bool?
    var doadorOrgaos: Bool?
    var alergias: String?
}
