//
//  File.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import Foundation

enum Grupo {
    case Crianca
    case Adolescente
    case Adulto
    case Idoso
    case Gestante
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

enum vacinasCriancaEnum {
    case gripe
    case caxumba
}

enum vacinasAdultoEnum {
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

class Person {
    
    var nome: String?
    var email: String?
    var imagem: String?
    var grupo: Grupo
    var tipoSanguineo: TipoSanguineo
    var hipertenso: Bool?
    var diabetico: Bool?
    var doadorOrgaos: Bool?
    var pcd: Bool?
    var vacinasCrianca: [[vacinasCriancaEnum? : Bool?]]
//    var vacinasAdolescente:
    var vacinasAdulto: [[vacinasAdultoEnum? : Bool?]]
//    var vacinasIdoso:
//    var vacinasGestante:
    
    init(nome: String?, email: String?, imagem: String?, grupo: Grupo, tipoSanguineo: TipoSanguineo, hipertenso: Bool?, diabetico: Bool?, doadorOrgaos: Bool?, pcd: Bool?, vacinasCrianca: [[vacinasCriancaEnum? : Bool?]], vacinasAdulto: [[vacinasAdultoEnum? : Bool?]]) {
        self.nome = nome
        self.email = email
        self.imagem = imagem
        self.grupo = grupo
        self.tipoSanguineo = tipoSanguineo
        self.hipertenso = hipertenso
        self.diabetico = diabetico
        self.doadorOrgaos = doadorOrgaos
        self.pcd = pcd
        self.vacinasCrianca = vacinasCrianca
        self.vacinasAdulto = vacinasAdulto
    }
    
}

