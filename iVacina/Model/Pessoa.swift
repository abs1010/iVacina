//
//  File.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import Foundation

enum Grupo {
    case Crianca, Adolescente, Adulto, Idoso
}

enum TipoSanguineo : String {
    case A_ = "A-"
    case B_ = "B-"
    case O_ = "O-"
    case A  = "A+"
    case B  = "B+"
    case O  = "O+"
}

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
