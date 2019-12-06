//
//  Vacina.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import Foundation

struct Vacina {
    var grupo: Grupo
    var nome: String
    var grupo: Grupo
    var status: Bool
}

enum vacinasCriancaEnum: Int, CaseIterable {
    case BCG = 0
    case Hepatite_B = 1
    case Penta_1_Dose = 2
    case Poliomielite_1_Dose = 3
    case Poliomielite_2_Dose = 4
    case Poliomielite_3_Dose = 5
    case Pneumococica_10 = 6
    case Rotavirus_Humano_1_Dose = 7
    case Meningococica_C = 8
    case Penta_2_Dose = 9
    case Pneumococica_10_Valente = 10
    case Rotavirus_Humano_2_Dose = 11
    case Febre_Amarela = 12
    case Triplice_Viral = 13
    case Pneumococica_Reforco = 14
    case Meningococica_Reforco = 15
    case Hepatite_A = 16
    case Tetra_Viral = 17
    case DTP = 18
    case Varicela = 19
    case none
}

enum vacinasAdolescenteEnum: Int, CaseIterable {
    case HPV_1_Dose = 0
    case HPV_2_Dose = 1
    case Meningococica_C = 2
    case Hepatite_B = 3
    case Febre_Amarela_1_Dose = 4
    case Dupla_Adulto_DT = 5
    case Triplice_Viral = 6
    case Pneumococica_23_Valente = 7
    case none
}

enum vacinasAdultoEnum: Int, CaseIterable {
    case Dupla_Adulto_DT = 0
    case Gripe = 1
    case Meningite_BACWY = 2
    case Hpv = 3
    case Pneumonia = 4
    case Herpes_Zoster = 5
    case Febre_Amarela = 6
    case Hepatite_B = 7
    case Triplice_Viral = 8
    case Hepatite_A = 9
    case Varicela = 10
    case none
}

enum vacinasIdosoEnum: Int, CaseIterable {
    case Hepatite_B = 0
    case Febre_Amarela = 1
    case Dupla_Adulto_DT = 2
    case Pneumococica_23_Valente = 3
    case Gripe_Anual = 4
    case none
}

enum vacinasGestanteEnum: Int, CaseIterable {
    case Hepatite_B = 0
    case Dupla_Adulto_DT = 1
    case dTpa = 2
    case Influenza = 3
    case none
}
