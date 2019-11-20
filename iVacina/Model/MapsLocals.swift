//
//  MapsLocals.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 11/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import MapKit

struct PostoDeSaudeElement: Codable {
    let codCnes: Int
    let codUnidade: String
    let codIbge: Int
    let cnpj, nomeFantasia: String
    let natureza: Natureza
    let tipoUnidade: TipoUnidade
    let esferaAdministrativa: EsferaAdministrativa
    let vinculoSUS: TemAtendimentoAmbulatorial
    let retencao: Retencao
    let fluxoClientela: FluxoClientela
    let origemGeografica: OrigemGeografica
    let temAtendimentoUrgencia, temAtendimentoAmbulatorial, temCentroCirurgico, temObstetra: TemAtendimentoAmbulatorial
    let temNeoNatal, temDialise: TemAtendimentoAmbulatorial
    let descricaoCompleta: String
    let tipoUnidadeCnes: TipoUnidadeCnes
    let categoriaUnidade: CategoriaUnidade
    let logradouro, numero, bairro: String
    let cidade: Cidade
    let uf: Uf
    let cep: String
    let telefone: String?
    let turnoAtendimento: TurnoAtendimento
    let lat, long: Double
    
        var address: String {
            return "\(self.logradouro), \(self.numero) \n\(self.bairro) - \(self.cep) \n\(self.cidade) - \(self.uf)"
        }
    
        var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }

    enum CodingKeys: String, CodingKey {
        case codCnes, codUnidade, codIbge, cnpj, nomeFantasia, natureza, tipoUnidade, esferaAdministrativa
        case vinculoSUS = "vinculoSus"
        case retencao, fluxoClientela, origemGeografica, temAtendimentoUrgencia, temAtendimentoAmbulatorial, temCentroCirurgico, temObstetra, temNeoNatal, temDialise, descricaoCompleta, tipoUnidadeCnes, categoriaUnidade, logradouro, numero, bairro, cidade, uf, cep, telefone, turnoAtendimento, lat, long
    }
}

enum CategoriaUnidade: String, Codable {
    case atençãoEspecífica = "ATENÇÃO ESPECÍFICA"
    case clínica = "CLÍNICA"
    case consultório = "CONSULTÓRIO"
    case postoDeSaúde = "POSTO DE SAÚDE"
}

enum Cidade: String, Codable {
    case saoPaulo = "SAO PAULO"
}

enum EsferaAdministrativa: String, Codable {
    case estadual = "Estadual"
    case municipal = "Municipal"
    case privada = "Privada"
}

enum FluxoClientela: String, Codable {
    case atendimentoDeDemandaEspontânea = "Atendimento de demanda espontânea"
    case atendimentoDeDemandaEspontâneaEReferenciada = "Atendimento de demanda espontânea e referenciada"
}

enum Natureza: String, Codable {
    case administraçãoDiretaDaSaúde = "Administração Direta da Saúde"
    case empresa = "Empresa"
}

enum OrigemGeografica: String, Codable {
    case cnesGeo = "CNES_GEO"
    case pmaq = "PMAQ"
}

enum Retencao: String, Codable {
    case unidadePessoaFísica = "Unidade Pessoa Física"
    case unidadePrivadaLucrativa = "Unidade Privada Lucrativa***"
    case unidadePública = "Unidade Pública"
}

enum TemAtendimentoAmbulatorial: String, Codable {
    case não = "Não"
    case sim = "Sim"
}

enum TipoUnidade: String, Codable {
    case clinicaEspecializada = "CLINICA ESPECIALIZADA"
    case consultórioParticular = "CONSULTÓRIO PARTICULAR"
    case postoDeSaúde = "POSTO DE SAÚDE"
    case saúdeMental = "SAÚDE MENTAL"
}

enum TipoUnidadeCnes: String, Codable {
    case centroDeAtencaoPsicossocial = "CENTRO DE ATENCAO PSICOSSOCIAL"
    case centroDeSaudeUnidadeBasica = "CENTRO DE SAUDE/UNIDADE BASICA"
    case clinicaEspecializadaAmbulatorioDeEspecialidade = "CLINICA ESPECIALIZADA/AMBULATORIO DE ESPECIALIDADE"
    case consultorioIsolado = "CONSULTORIO ISOLADO"
}

enum TurnoAtendimento: String, Codable {
    case atendimentoNOSTurnosDaManhãEÀTarde = "Atendimento nos turnos da manhã e à tarde."
    case atendimentosNOSTurnosDaManhãTardeENoite = "Atendimentos nos turnos da manhã, tarde e noite."
}

enum Uf: String, Codable {
    case sp = "SP"
}

typealias PostoDeSaude = [PostoDeSaudeElement]

//struct PostoDeSaudeElement: Codable {
//    let nomeFantasia: String
//    let tipoUnidade: TipoUnidade
//    let vinculoSUS: TemVinculoSUS
//    let descricaoCompleta: String
//    let logradouro, numero, bairro, cidade: String
//    let uf, cep: String
//    let telefone: String?
//    let turnoAtendimento: TurnoAtendimento
//    let lat, long: Double
//
//    var address: String {
//        return "\(self.logradouro), \(self.numero) \n\(self.bairro) - \(self.cep) \n\(self.cidade) - \(self.uf)"
//    }
//
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: lat, longitude: long)
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case nomeFantasia, tipoUnidade
//        case vinculoSUS = "vinculoSus"
//        case descricaoCompleta, logradouro, numero, bairro, cidade, uf, cep, telefone, turnoAtendimento, lat, long
//    }
//}
//
//enum TemVinculoSUS: String, Codable {
//    case não = "Não"
//    case sim = "Sim"
//}
//
//enum TipoUnidade: String, Codable {
//    case clinicaEspecializada = "CLINICA ESPECIALIZADA"
//    case consultórioParticular = "CONSULTÓRIO PARTICULAR"
//    case policlinica = "POLICLINICA"
//}
//
//enum TurnoAtendimento: String, Codable {
//    case atendimentoCOMTurnosIntermitentes = "Atendimento com turnos intermitentes."
//    case atendimentoNOSTurnosDaManhãEÀTarde = "Atendimento nos turnos da manhã e à tarde."
//    case atendimentoSomenteÀTarde = "Atendimento somente à tarde."
//    case atendimentosNOSTurnosDaManhãTardeENoite = "Atendimentos nos turnos da manhã, tarde e noite."
//}
//
//typealias PostoDeSaude = [PostoDeSaudeElement]



class MapsLocals: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
    
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    
    super.init()
        
    }
    
    init(json: PostoDeSaudeElement){
        
        self.title = json.nomeFantasia
        self.subtitle = json.address
        self.coordinate = json.coordinate
    }
}

