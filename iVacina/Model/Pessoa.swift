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

class Pessoa {
    
    var nome: String?
    var imagem: String?
    var grupo: Grupo
    var tipoSanguineo: TipoSanguineo
    var hipertenso: Bool
    var diabetico: Bool
    var doadorOrgaos: Bool
    var pcd: Bool
    var listaVacinas: [Vacina]
    
    init(nome: String?, imagem: String?, grupo: Grupo, tipoSanguineo: TipoSanguineo, hipertenso: Bool, diabetico: Bool, doadorOrgaos: Bool, pcd: Bool, listaVacinas: [Vacina]) {
        self.nome = nome
        self.imagem = imagem
        self.grupo = grupo
        self.tipoSanguineo = tipoSanguineo
        self.hipertenso = hipertenso
        self.diabetico = diabetico
        self.doadorOrgaos = doadorOrgaos
        self.pcd = pcd
        self.listaVacinas = listaVacinas

    }
    
}

class Titular : Pessoa {
    
    var email: String?
    var dependentes: [Pessoa?]
    
    init(nome: String?, email: String?, imagem: String?, grupo: Grupo, tipoSanguineo: TipoSanguineo, hipertenso: Bool, diabetico: Bool, doadorOrgaos: Bool, pcd: Bool, listaVacinas: [Vacina], dependentes: [Pessoa?]) {
        self.email = email
        self.dependentes = dependentes
  
        super.init(nome: nome, imagem: imagem, grupo: grupo, tipoSanguineo: tipoSanguineo, hipertenso: hipertenso, diabetico: diabetico, doadorOrgaos: doadorOrgaos, pcd: pcd, listaVacinas: listaVacinas)
        
    }
}

