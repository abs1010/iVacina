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

enum vacinasCriancaEnum: Int, CaseIterable {
    case gripe = 0
    case caxumba = 1
    case none
}

enum vacinasAdolescenteEnum: Int, CaseIterable {
    case gripe = 0
    case tripliceViral = 1
    case hepatiteA = 2
    case varicela = 3
    case none
}

enum vacinasAdultoEnum: Int, CaseIterable {
    case duplaAdultoDT = 0
    case gripe = 1
    case meningiteBACWY = 2
    case hpv = 3
    case pneumonia = 4
    case herpesZoster = 5
    case febreAmarela = 6
    case hepatiteB = 7
    case tripliceViral = 8
    case hepatiteA = 9
    case varicela = 10
    case none
}

enum vacinasIdosoEnum: Int, CaseIterable {
    case gripe = 0
    case caxumba = 1
    case none
}

enum vacinasGestanteEnum: Int, CaseIterable {
    case hpv = 0
    case gripe  = 1
    case caxumba = 2
}

struct Dependente {
    
    var nome: String?
    var imagem: String?
    var grupo: Grupo
    var tipoSanguineo: TipoSanguineo
    var hipertenso: Bool?
    var diabetico: Bool?
    var doadorOrgaos: Bool?
    var pcd: Bool?
    var vacinasCrianca: [[vacinasCriancaEnum? : Bool?]]
    var vacinasAdolescente: [[vacinasAdolescenteEnum? : Bool?]]
    var vacinasAdulto: [[vacinasAdultoEnum? : Bool?]]
    var vacinasIdoso: [[vacinasIdosoEnum? : Bool?]]
    var vacinasGestante: [[vacinasGestanteEnum? : Bool?]]
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
    var vacinasAdolescente: [[vacinasAdolescenteEnum? : Bool?]]
    var vacinasAdulto: [[vacinasAdultoEnum? : Bool?]]
    var vacinasIdoso: [[vacinasIdosoEnum? : Bool?]]
    var vacinasGestante: [[vacinasGestanteEnum? : Bool?]]
    var dependentes: [String]
    
    init(nome: String?, email: String?, imagem: String?, grupo: Grupo, tipoSanguineo: TipoSanguineo, hipertenso: Bool?, diabetico: Bool?, doadorOrgaos: Bool?, pcd: Bool?, vacinasCrianca: [[vacinasCriancaEnum? : Bool?]], vacinasAdolescente: [[vacinasAdolescenteEnum? : Bool?]], vacinasAdulto: [[vacinasAdultoEnum? : Bool?]], vacinasIdoso: [[vacinasIdosoEnum? : Bool?]], vacinasGestante: [[vacinasGestanteEnum? : Bool?]], dependentes: [String]) {
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
        self.vacinasAdolescente = vacinasAdolescente
        self.vacinasAdulto = vacinasAdulto
        self.vacinasIdoso = vacinasIdoso
        self.vacinasGestante = vacinasGestante
        self.dependentes = dependentes
    }
    
}

