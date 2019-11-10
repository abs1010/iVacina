//
//  MapsEstabelecimentos.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

struct PostoDeSaudeElement: Codable {
    let nomeFantasia: String
    let tipoUnidade: TipoUnidade
    let vinculoSUS: TemVinculoSUS
    let descricaoCompleta: String
    let logradouro, numero, bairro, cidade: String
    let uf, cep: String
    let telefone: String?
    let turnoAtendimento: TurnoAtendimento
    let lat, long: Double

    enum CodingKeys: String, CodingKey {
        case nomeFantasia, tipoUnidade
        case vinculoSUS = "vinculoSus"
        case descricaoCompleta, logradouro, numero, bairro, cidade, uf, cep, telefone, turnoAtendimento, lat, long
    }
}

enum TemVinculoSUS: String, Codable {
    case não = "Não"
    case sim = "Sim"
}

enum TipoUnidade: String, Codable {
    case clinicaEspecializada = "CLINICA ESPECIALIZADA"
    case consultórioParticular = "CONSULTÓRIO PARTICULAR"
    case policlinica = "POLICLINICA"
}

enum TurnoAtendimento: String, Codable {
    case atendimentoCOMTurnosIntermitentes = "Atendimento com turnos intermitentes."
    case atendimentoNOSTurnosDaManhãEÀTarde = "Atendimento nos turnos da manhã e à tarde."
    case atendimentoSomenteÀTarde = "Atendimento somente à tarde."
    case atendimentosNOSTurnosDaManhãTardeENoite = "Atendimentos nos turnos da manhã, tarde e noite."
}

typealias PostoDeSaude = [PostoDeSaudeElement]

