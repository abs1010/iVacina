//
//  REMOVERDEPOIS.swift
//  iVacina
//
//  Created by Alan Silva on 04/12/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

class Salvar {

    let tempUser: Titular = Titular(nome: "Alan Bezerra Silva", email: "alan@gmail.com", imagem: "alan@gmail.com", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false,
        listaVacinas: [Vacina(nome: "BCG", grupo: .Crianca, status: false),
        Vacina(nome: "Hepatite_B", grupo: .Crianca, status: false),
        Vacina(nome: "Penta_1_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Poliomielite_1_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Poliomielite_2_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Poliomielite_3_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Pneumococica_10", grupo: .Crianca, status: false),
        Vacina(nome: "Rotavirus_Humano_1_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Meningococica_C", grupo: .Crianca, status: false),
        Vacina(nome: "Penta_2_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Pneumococica_10_Valente", grupo: .Crianca, status: false),
        Vacina(nome: "Rotavirus_Humano_2_Dose", grupo: .Crianca, status: false),
        Vacina(nome: "Febre_Amarela", grupo: .Crianca, status: false),
        Vacina(nome: "Triplice_Viral", grupo: .Crianca, status: false),
        Vacina(nome: "Pneumococica_Reforco", grupo: .Crianca, status: false),
        Vacina(nome: "Meningococica_Reforco", grupo: .Crianca, status: false),
        Vacina(nome: "Hepatite_A", grupo: .Crianca, status: false),
        Vacina(nome: "Tetra_Viral", grupo: .Crianca, status: false),
        Vacina(nome: "DTP", grupo: .Crianca, status: false),
        Vacina(nome: "Varicela", grupo: .Crianca, status: false),

        Vacina(nome: "HPV_1_Dose", grupo: .Adolescente, status: false),
        Vacina(nome: "HPV_2_Dose", grupo: .Adolescente, status: false),
        Vacina(nome: "Meningococica_C", grupo: .Adolescente, status: false),
        Vacina(nome: "Hepatite_B", grupo: .Adolescente, status: false),
        Vacina(nome: "Febre_Amarela_1_Dose", grupo: .Adolescente, status: false),
        Vacina(nome: "Dupla_Adulto_DT", grupo: .Adolescente, status: false),
        Vacina(nome: "Triplice_Viral", grupo: .Adolescente, status: false),
        Vacina(nome: "Pneumococica_23_Valente", grupo: .Adolescente, status: false),

        Vacina(nome: "Dupla_Adulto_DT", grupo: .Adulto, status: false),
        Vacina(nome: "Gripe", grupo: .Adulto, status: false),
        Vacina(nome: "Meningite_BACWY", grupo: .Adulto, status: false),
        Vacina(nome: "Hpv", grupo: .Adulto, status: false),
        Vacina(nome: "Pneumonia", grupo: .Adulto, status: false),
        Vacina(nome: "Herpes_Zoster", grupo: .Adulto, status: false),
        Vacina(nome: "Febre_Amarela", grupo: .Adulto, status: false),
        Vacina(nome: "Hepatite_B", grupo: .Adulto, status: false),
        Vacina(nome: "Triplice_Viral", grupo: .Adulto, status: false),
        Vacina(nome: "Hepatite_A", grupo: .Adulto, status: false),
        Vacina(nome: "Varicela", grupo: .Adulto, status: false),

        Vacina(nome: "Hepatite_B", grupo: .Idoso, status: false),
        Vacina(nome: "Febre_Amarela", grupo: .Idoso, status: false),
        Vacina(nome: "Dupla_Adulto_DT", grupo: .Idoso, status: false),
        Vacina(nome: "Pneumococica_23_Valente", grupo: .Idoso, status: false),
        Vacina(nome: "Gripe_Anual", grupo: .Idoso, status: false),

        Vacina(nome: "Hepatite_B", grupo: .Gestante, status: false),
        Vacina(nome: "Dupla_Adulto_DT", grupo: .Gestante, status: false),
        Vacina(nome: "dTpa", grupo: .Gestante, status: false),
        Vacina(nome: "Influenza", grupo: .Gestante, status: false)],

        dependentes: [])

    let dependente1 : Pessoa = Pessoa(nome: "Davi Silva", imagem: "alan@gmail.com", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas:
    [Vacina(nome: "BCG", grupo: .Crianca, status: false),
    Vacina(nome: "Hepatite_B", grupo: .Crianca, status: false),
    Vacina(nome: "Penta_1_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Poliomielite_1_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Poliomielite_2_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Poliomielite_3_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Pneumococica_10", grupo: .Crianca, status: false),
    Vacina(nome: "Rotavirus_Humano_1_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Meningococica_C", grupo: .Crianca, status: false),
    Vacina(nome: "Penta_2_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Pneumococica_10_Valente", grupo: .Crianca, status: false),
    Vacina(nome: "Rotavirus_Humano_2_Dose", grupo: .Crianca, status: false),
    Vacina(nome: "Febre_Amarela", grupo: .Crianca, status: false),
    Vacina(nome: "Triplice_Viral", grupo: .Crianca, status: false),
    Vacina(nome: "Pneumococica_Reforco", grupo: .Crianca, status: false),
    Vacina(nome: "Meningococica_Reforco", grupo: .Crianca, status: false),
    Vacina(nome: "Hepatite_A", grupo: .Crianca, status: false),
    Vacina(nome: "Tetra_Viral", grupo: .Crianca, status: false),
    Vacina(nome: "DTP", grupo: .Crianca, status: false),
    Vacina(nome: "Varicela", grupo: .Crianca, status: false),

    Vacina(nome: "HPV_1_Dose", grupo: .Adolescente, status: false),
    Vacina(nome: "HPV_2_Dose", grupo: .Adolescente, status: false),
    Vacina(nome: "Meningococica_C", grupo: .Adolescente, status: false),
    Vacina(nome: "Hepatite_B", grupo: .Adolescente, status: false),
    Vacina(nome: "Febre_Amarela_1_Dose", grupo: .Adolescente, status: false),
    Vacina(nome: "Dupla_Adulto_DT", grupo: .Adolescente, status: false),
    Vacina(nome: "Triplice_Viral", grupo: .Adolescente, status: false),
    Vacina(nome: "Pneumococica_23_Valente", grupo: .Adolescente, status: false),

    Vacina(nome: "Dupla_Adulto_DT", grupo: .Adulto, status: false),
    Vacina(nome: "Gripe", grupo: .Adulto, status: false),
    Vacina(nome: "Meningite_BACWY", grupo: .Adulto, status: false),
    Vacina(nome: "Hpv", grupo: .Adulto, status: false),
    Vacina(nome: "Pneumonia", grupo: .Adulto, status: false),
    Vacina(nome: "Herpes_Zoster", grupo: .Adulto, status: false),
    Vacina(nome: "Febre_Amarela", grupo: .Adulto, status: false),
    Vacina(nome: "Hepatite_B", grupo: .Adulto, status: false),
    Vacina(nome: "Triplice_Viral", grupo: .Adulto, status: false),
    Vacina(nome: "Hepatite_A", grupo: .Adulto, status: false),
    Vacina(nome: "Varicela", grupo: .Adulto, status: false),

    Vacina(nome: "Hepatite_B", grupo: .Idoso, status: false),
    Vacina(nome: "Febre_Amarela", grupo: .Idoso, status: false),
    Vacina(nome: "Dupla_Adulto_DT", grupo: .Idoso, status: false),
    Vacina(nome: "Pneumococica_23_Valente", grupo: .Idoso, status: false),
    Vacina(nome: "Gripe_Anual", grupo: .Idoso, status: false),

    Vacina(nome: "Hepatite_B", grupo: .Gestante, status: false),
    Vacina(nome: "Dupla_Adulto_DT", grupo: .Gestante, status: false),
    Vacina(nome: "dTpa", grupo: .Gestante, status: false),
    Vacina(nome: "Influenza", grupo: .Gestante, status: false)])

     let dependente2 : Pessoa = Pessoa(nome: "Carol Silva", imagem: "carol.jpg", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas:
    [Vacina(nome: "BCG", grupo: .Crianca, status: false),
     Vacina(nome: "Hepatite_B", grupo: .Crianca, status: false),
     Vacina(nome: "Penta_1_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Poliomielite_1_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Poliomielite_2_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Poliomielite_3_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Pneumococica_10", grupo: .Crianca, status: false),
     Vacina(nome: "Rotavirus_Humano_1_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Meningococica_C", grupo: .Crianca, status: false),
     Vacina(nome: "Penta_2_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Pneumococica_10_Valente", grupo: .Crianca, status: false),
     Vacina(nome: "Rotavirus_Humano_2_Dose", grupo: .Crianca, status: false),
     Vacina(nome: "Febre_Amarela", grupo: .Crianca, status: false),
     Vacina(nome: "Triplice_Viral", grupo: .Crianca, status: false),
     Vacina(nome: "Pneumococica_Reforco", grupo: .Crianca, status: false),
     Vacina(nome: "Meningococica_Reforco", grupo: .Crianca, status: false),
     Vacina(nome: "Hepatite_A", grupo: .Crianca, status: false),
     Vacina(nome: "Tetra_Viral", grupo: .Crianca, status: false),
     Vacina(nome: "DTP", grupo: .Crianca, status: false),
     Vacina(nome: "Varicela", grupo: .Crianca, status: false),

     Vacina(nome: "HPV_1_Dose", grupo: .Adolescente, status: false),
     Vacina(nome: "HPV_2_Dose", grupo: .Adolescente, status: false),
     Vacina(nome: "Meningococica_C", grupo: .Adolescente, status: false),
     Vacina(nome: "Hepatite_B", grupo: .Adolescente, status: false),
     Vacina(nome: "Febre_Amarela_1_Dose", grupo: .Adolescente, status: false),
     Vacina(nome: "Dupla_Adulto_DT", grupo: .Adolescente, status: false),
     Vacina(nome: "Triplice_Viral", grupo: .Adolescente, status: false),
     Vacina(nome: "Pneumococica_23_Valente", grupo: .Adolescente, status: false),

     Vacina(nome: "Dupla_Adulto_DT", grupo: .Adulto, status: false),
     Vacina(nome: "Gripe", grupo: .Adulto, status: false),
     Vacina(nome: "Meningite_BACWY", grupo: .Adulto, status: false),
     Vacina(nome: "Hpv", grupo: .Adulto, status: false),
     Vacina(nome: "Pneumonia", grupo: .Adulto, status: false),
     Vacina(nome: "Herpes_Zoster", grupo: .Adulto, status: false),
     Vacina(nome: "Febre_Amarela", grupo: .Adulto, status: false),
     Vacina(nome: "Hepatite_B", grupo: .Adulto, status: false),
     Vacina(nome: "Triplice_Viral", grupo: .Adulto, status: false),
     Vacina(nome: "Hepatite_A", grupo: .Adulto, status: false),
     Vacina(nome: "Varicela", grupo: .Adulto, status: false),

     Vacina(nome: "Hepatite_B", grupo: .Idoso, status: false),
     Vacina(nome: "Febre_Amarela", grupo: .Idoso, status: false),
     Vacina(nome: "Dupla_Adulto_DT", grupo: .Idoso, status: false),
     Vacina(nome: "Pneumococica_23_Valente", grupo: .Idoso, status: false),
     Vacina(nome: "Gripe_Anual", grupo: .Idoso, status: false),

     Vacina(nome: "Hepatite_B", grupo: .Gestante, status: false),
     Vacina(nome: "Dupla_Adulto_DT", grupo: .Gestante, status: false),
     Vacina(nome: "dTpa", grupo: .Gestante, status: false),
     Vacina(nome: "Influenza", grupo: .Gestante, status: false)])

    func getTempPerson() -> Titular{

        self.tempUser.dependentes.append(dependente1)
        self.tempUser.dependentes.append(dependente2)
        return self.tempUser

    }

}
