//
//  ProfileController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ProfileController {
    var pessoa: Pessoa?
    var profileViewController : ProfileViewController?
    
    var grupoArray : [String] = ["Criança", "Adoslecente", "Adulto", "Idoso", "Gestante"]
    var tipoSanguineoArray : [String] = ["A-", "B-", "O-", "A+", "B+", "O+"]
    
//    func getTamanhoListaVacina() -> Int{
//        return self.pessoa?.listaVacina.count ?? 0
//    }
//
//    func getTamanhoListaProximaVacina() -> Int{
//        return self.pessoa?.listaProximaVacina.count ?? 0
//    }
//
//    func setPessoa(pessoa: Pessoa?){
//        if let _pessoa = pessoa{
//            self.pessoa = _pessoa
//        }
//    }
//
//    func getPessoa() -> Pessoa?{
//        return self.pessoa
//    }
    
    func saveInfo(person: Titular?){
        
        //Aponta par o banco de dados
        let context = Database.database().reference()
        
        //personalData
        let nome = person?.nome
        let email = person?.email
        let imagem = person?.imagem
        let grupo = ("\(person?.grupo ?? .Adulto)")
        let tipoSanguineo = person?.nome
        let hipertenso = person?.hipertenso
        let diabetico = person?.diabetico
        let doadorOrgaos = person?.doadorOrgaos
        let pcd = person?.pcd
        
        //Vacinas Crianca
        let BCG_CR                     = person?.vacinasCrianca[.BCG]
        let Hepatite_B_CR              = person?.vacinasCrianca[.Hepatite_B]
        let Penta_1_Dose_CR            = person?.vacinasCrianca[.Penta_1_Dose]
        let Poliomielite_1_Dose_CR     = person?.vacinasCrianca[.Poliomielite_1_Dose]
        let Poliomielite_2_Dose_CR     = person?.vacinasCrianca[.Poliomielite_2_Dose]
        let Poliomielite_3_Dose_CR     = person?.vacinasCrianca[.Poliomielite_3_Dose]
        let Pneumococica_10_CR         = person?.vacinasCrianca[.Pneumococica_10]
        let Rotavirus_Humano_1_Dose_CR = person?.vacinasCrianca[.Rotavirus_Humano_1_Dose]
        let Meningococica_C_CR         = person?.vacinasCrianca[.Meningococica_C]
        let Penta_2_Dose_CR            = person?.vacinasCrianca[.Penta_2_Dose]
        let Pneumococica_10_Valente_CR = person?.vacinasCrianca[.Pneumococica_10_Valente]
        let Rotavirus_Humano_2_Dose_CR = person?.vacinasCrianca[.Rotavirus_Humano_2_Dose]
        let Febre_Amarela_CR           = person?.vacinasCrianca[.Febre_Amarela]
        let Triplice_Viral_CR          = person?.vacinasCrianca[.Triplice_Viral]
        let Pneumococica_Reforco_CR    = person?.vacinasCrianca[.Pneumococica_Reforco]
        let Meningococica_Reforco_CR   = person?.vacinasCrianca[.Meningococica_Reforco]
        let Hepatite_A_CR              = person?.vacinasCrianca[.Hepatite_A]
        let Tetra_Viral_CR             = person?.vacinasCrianca[.Tetra_Viral]
        let DTP_CR                     = person?.vacinasCrianca[.DTP]
        let Varicela_CR                = person?.vacinasCrianca[.Varicela]
        
        //Vacinas Adolescente
        let HPV_1_Dose_AD              = person?.vacinasAdolescente[.HPV_1_Dose]
        let HPV_2_Dose_AD              = person?.vacinasAdolescente[.HPV_2_Dose]
        let Meningococica_C_AD         = person?.vacinasAdolescente[.Meningococica_C]
        let Hepatite_B_AD              = person?.vacinasAdolescente[.Hepatite_B]
        let Febre_Amarela_1_Dose_AD    = person?.vacinasAdolescente[.Febre_Amarela_1_Dose]
        let Dupla_Adulto_DT_AD         = person?.vacinasAdolescente[.Dupla_Adulto_DT]
        let Triplice_Viral_AD          = person?.vacinasAdolescente[.Triplice_Viral]
        let Pneumococica_23_Valente_AD = person?.vacinasAdolescente[.Pneumococica_23_Valente]
        
        //Vacinas Adulto
        let Dupla_Adulto_DT_ADU        = person?.vacinasAdulto[.Dupla_Adulto_DT]
        let Gripe_ADU                  = person?.vacinasAdulto[.Gripe]
        let Meningite_BACWY_ADU        = person?.vacinasAdulto[.Meningite_BACWY]
        let Hpv_ADU                    = person?.vacinasAdulto[.Hpv]
        let Pneumonia_ADU              = person?.vacinasAdulto[.Pneumonia]
        let Herpes_Zoster_ADU          = person?.vacinasAdulto[.Herpes_Zoster]
        let Febre_Amarela_ADU          = person?.vacinasAdulto[.Febre_Amarela]
        let Hepatite_B_ADU             = person?.vacinasAdulto[.Hepatite_B]
        let Triplice_Viral_ADU         = person?.vacinasAdulto[.Triplice_Viral]
        let Hepatite_A_ADU             = person?.vacinasAdulto[.Hepatite_A]
        let Varicela_ADU               = person?.vacinasAdulto[.Varicela]
        
        //Vacinas Idoso
        let Hepatite_B_ID              = person?.vacinasIdoso[.Hepatite_B]
        let Febre_Amarela_ID           = person?.vacinasIdoso[.Febre_Amarela]
        let Dupla_Adulto_DT_ID         = person?.vacinasIdoso[.Dupla_Adulto_DT]
        let Pneumococica_23_Valente_ID = person?.vacinasIdoso[.Pneumococica_23_Valente]
        let Gripe_Anual_ID             = person?.vacinasIdoso[.Gripe_Anual]
        
        //Vacinas Gestante
        let Hepatite_B_GES             = person?.vacinasGestante[.Hepatite_B]
        let Dupla_Adulto_DT_GES        = person?.vacinasGestante[.Dupla_Adulto_DT]
        let dTpa_GES                   = person?.vacinasGestante[.dTpa]
        let Influenza_GES              = person?.vacinasGestante[.Influenza]
        
        let personalData:[String : Any] = ["name" : nome ?? "",
                                           "email" : email ?? "",
                                           "imagem" : imagem ?? "",
                                           "grupo" : grupo,
                                           "tipoSanguineo" : tipoSanguineo ?? "",
                                           "hipertenso" : hipertenso ?? "",
                                           "diabetico" : diabetico ?? "",
                                           "doadorOrgaos" : doadorOrgaos ?? "",
                                           "pcd" : pcd ?? ""]
        
        
        let vacinasCrianca:[String : Any] = [ "BCG" : BCG_CR!,
                                              "Hepatite_B" : Hepatite_B_CR!,
                                              "Penta_1_Dose" : Penta_1_Dose_CR!,
                                              "Poliomielite_1_Dose" : Poliomielite_1_Dose_CR!,
                                              "Poliomielite_2_Dose" : Poliomielite_2_Dose_CR!,
                                              "Poliomielite_3_Dose" : Poliomielite_3_Dose_CR!,
                                              "Pneumococica_10" : Pneumococica_10_CR!,
                                              "Rotavirus_Humano_1_Dose" : Rotavirus_Humano_1_Dose_CR!,
                                              "Meningococica_C" : Meningococica_C_CR!,
                                              "Penta_2_Dose" : Penta_2_Dose_CR!,
                                              "Pneumococica_10_Valente" : Pneumococica_10_Valente_CR!,
                                              "Rotavirus_Humano_2_Dose" : Rotavirus_Humano_2_Dose_CR!,
                                              "Febre_Amarela" : Febre_Amarela_CR!,
                                              "Triplice_Viral" : Triplice_Viral_CR!,
                                              "Pneumococica_Reforco" : Pneumococica_Reforco_CR!,
                                              "Meningococica_Reforco" : Meningococica_Reforco_CR!,
                                              "Hepatite_A" : Hepatite_A_CR!,
                                              "Tetra_Viral" : Tetra_Viral_CR!,
                                              "DTP" : DTP_CR!,
                                              "Varicela" : Varicela_CR!]
        
        let vacinasAdolescente:[String : Any] = [ "HPV_1_Dose" : HPV_1_Dose_AD!,
                                                  "HPV_2_Dose" : HPV_2_Dose_AD!,
                                                  "Meningococica_C" : Meningococica_C_AD!,
                                                  "Hepatite_B" : Hepatite_B_AD!,
                                                  "Febre_Amarela_1_Dose" : Febre_Amarela_1_Dose_AD!,
                                                  "Dupla_Adulto_DT" : Dupla_Adulto_DT_AD!,
                                                  "Triplice_Viral" : Triplice_Viral_AD!,
                                                  "Pneumococica_23_Valente" : Pneumococica_23_Valente_AD!]
        
        let vacinasAdulto:[String : Any] = [ "Dupla_Adulto_DT" : Dupla_Adulto_DT_ADU!,
                                             "Gripe" : Gripe_ADU!,
                                             "Meningite_BACWY" : Meningite_BACWY_ADU!,
                                             "Hpv" : Hpv_ADU!,
                                             "Pneumonia" : Pneumonia_ADU!,
                                             "Herpes_Zoster" : Herpes_Zoster_ADU!,
                                             "Febre_Amarela" : Febre_Amarela_ADU!,
                                             "Hepatite_B" : Hepatite_B_ADU!,
                                             "Triplice_Viral" : Triplice_Viral_ADU!,
                                             "Hepatite_A" : Hepatite_A_ADU!,
                                             "Varicela" : Varicela_ADU!]
        
        let vacinasIdoso:[String : Any] = [ "Hepatite_B" : Hepatite_B_ID!,
                                            "Febre_Amarela" : Febre_Amarela_ID!,
                                            "Dupla_Adulto_DT" : Dupla_Adulto_DT_ID!,
                                            "Pneumococica_23_Valente" : Pneumococica_23_Valente_ID!,
                                            "Gripe_Anual" : Gripe_Anual_ID!]
        
        let vacinasGestante:[String : Any] = [ "Hepatite_B" : Hepatite_B_GES!,
                                               "Dupla_Adulto_DT" : Dupla_Adulto_DT_GES!,
                                               "dTpa" : dTpa_GES!,
                                               "Influenza" : Influenza_GES!]
        
        let formattedEmail = (email?.replacingOccurrences(of: ".", with: ","))!
        //GRAVANDO OS DADOS PESSOAS
        context.child("user/profile").child(formattedEmail).setValue(personalData) { (error, context) in
            if error == nil {
                print("Dados pessoais de \(email ?? "") salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE CRIANCA
        context.child("user/profile").child(formattedEmail).child("vacinasCrianca").setValue(vacinasCrianca) { (error, context) in
            if error == nil {
                print("Dados das vacinas de CRIANCA de \(email ?? "") salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE ADOLESCENTE
        context.child("user/profile").child(formattedEmail).child("vacinasAdolescente").setValue(vacinasAdolescente) { (error, context) in
            if error == nil {
                print("Dados das vacinas de ADOLESCENTE de \(email ?? "") salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE ADULTO
        context.child("user/profile").child(formattedEmail).child("vacinasAdulto").setValue(vacinasAdulto) { (error, context) in
            if error == nil {
                print("Dados das vacinas de ADULTO de \(email ?? "") salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE IDOSO
        context.child("user/profile").child(formattedEmail).child("vacinasIdoso").setValue(vacinasIdoso) { (error, context) in
            if error == nil {
                print("Dados das vacinas de IDOSO salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE GESTANTE
        context.child("user/profile").child(formattedEmail).child("vacinasGestante").setValue(vacinasGestante) { (error, context) in
            if error == nil {
                print("Dados das vacinas de GESTANTE salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        
        //DEPENDENTES
        if let arrayDep = person?.dependentes {
            var seq = 0
            
            for dependent in arrayDep {
                
                let nome = dependent?.nome
                let imagem = dependent?.imagem
                let grupo = String("\(dependent?.grupo ?? .Adulto)")
                let tipoSanguineo = dependent?.nome
                let hipertenso = dependent?.hipertenso
                let diabetico = dependent?.diabetico
                let doadorOrgaos = dependent?.doadorOrgaos
                let pcd = dependent?.pcd
                //Vacinas DEPENDENTE Crianca
                let BCG_CR                     = dependent?.vacinasCrianca[.BCG]
                let Hepatite_B_CR              = dependent?.vacinasCrianca[.Hepatite_B]
                let Penta_1_Dose_CR            = dependent?.vacinasCrianca[.Penta_1_Dose]
                let Poliomielite_1_Dose_CR     = dependent?.vacinasCrianca[.Poliomielite_1_Dose]
                let Poliomielite_2_Dose_CR     = dependent?.vacinasCrianca[.Poliomielite_2_Dose]
                let Poliomielite_3_Dose_CR     = dependent?.vacinasCrianca[.Poliomielite_3_Dose]
                let Pneumococica_10_CR         = dependent?.vacinasCrianca[.Pneumococica_10]
                let Rotavirus_Humano_1_Dose_CR = dependent?.vacinasCrianca[.Rotavirus_Humano_1_Dose]
                let Meningococica_C_CR         = dependent?.vacinasCrianca[.Meningococica_C]
                let Penta_2_Dose_CR            = dependent?.vacinasCrianca[.Penta_2_Dose]
                let Pneumococica_10_Valente_CR = dependent?.vacinasCrianca[.Pneumococica_10_Valente]
                let Rotavirus_Humano_2_Dose_CR = dependent?.vacinasCrianca[.Rotavirus_Humano_2_Dose]
                let Febre_Amarela_CR           = dependent?.vacinasCrianca[.Febre_Amarela]
                let Triplice_Viral_CR          = dependent?.vacinasCrianca[.Triplice_Viral]
                let Pneumococica_Reforco_CR    = dependent?.vacinasCrianca[.Pneumococica_Reforco]
                let Meningococica_Reforco_CR   = dependent?.vacinasCrianca[.Meningococica_Reforco]
                let Hepatite_A_CR              = dependent?.vacinasCrianca[.Hepatite_A]
                let Tetra_Viral_CR             = dependent?.vacinasCrianca[.Tetra_Viral]
                let DTP_CR                     = dependent?.vacinasCrianca[.DTP]
                let Varicela_CR                = dependent?.vacinasCrianca[.Varicela]
                //Vacinas DEPENDENTE Adolescente
                let HPV_1_Dose_AD              = dependent?.vacinasAdolescente[.HPV_1_Dose]
                let HPV_2_Dose_AD              = dependent?.vacinasAdolescente[.HPV_2_Dose]
                let Meningococica_C_AD         = dependent?.vacinasAdolescente[.Meningococica_C]
                let Hepatite_B_AD              = dependent?.vacinasAdolescente[.Hepatite_B]
                let Febre_Amarela_1_Dose_AD    = dependent?.vacinasAdolescente[.Febre_Amarela_1_Dose]
                let Dupla_Adulto_DT_AD         = dependent?.vacinasAdolescente[.Dupla_Adulto_DT]
                let Triplice_Viral_AD          = dependent?.vacinasAdolescente[.Triplice_Viral]
                let Pneumococica_23_Valente_AD = dependent?.vacinasAdolescente[.Pneumococica_23_Valente]
                //Vacinas DEPENDENTE Adulto
                let Dupla_Adulto_DT_ADU        = dependent?.vacinasAdulto[.Dupla_Adulto_DT]
                let Gripe_ADU                  = dependent?.vacinasAdulto[.Gripe]
                let Meningite_BACWY_ADU        = dependent?.vacinasAdulto[.Meningite_BACWY]
                let Hpv_ADU                    = dependent?.vacinasAdulto[.Hpv]
                let Pneumonia_ADU              = dependent?.vacinasAdulto[.Pneumonia]
                let Herpes_Zoster_ADU          = dependent?.vacinasAdulto[.Herpes_Zoster]
                let Febre_Amarela_ADU          = dependent?.vacinasAdulto[.Febre_Amarela]
                let Hepatite_B_ADU             = dependent?.vacinasAdulto[.Hepatite_B]
                let Triplice_Viral_ADU         = dependent?.vacinasAdulto[.Triplice_Viral]
                let Hepatite_A_ADU             = dependent?.vacinasAdulto[.Hepatite_A]
                let Varicela_ADU               = dependent?.vacinasAdulto[.Varicela]
                //Vacinas DEPENDENTE Idoso
                let Hepatite_B_ID              = dependent?.vacinasIdoso[.Hepatite_B]
                let Febre_Amarela_ID           = dependent?.vacinasIdoso[.Febre_Amarela]
                let Dupla_Adulto_DT_ID         = dependent?.vacinasIdoso[.Dupla_Adulto_DT]
                let Pneumococica_23_Valente_ID = dependent?.vacinasIdoso[.Pneumococica_23_Valente]
                let Gripe_Anual_ID             = dependent?.vacinasIdoso[.Gripe_Anual]
                //Vacinas DEPENDENTE Gestante
                let Hepatite_B_GES             = dependent?.vacinasGestante[.Hepatite_B]
                let Dupla_Adulto_DT_GES        = dependent?.vacinasGestante[.Dupla_Adulto_DT]
                let dTpa_GES                   = dependent?.vacinasGestante[.dTpa]
                let Influenza_GES              = dependent?.vacinasGestante[.Influenza]
                
                let dependentData:[String : Any] = ["name" : nome ?? "",
                                                    "imagem" : imagem ?? "",
                                                    "grupo" : grupo,
                                                    "tipoSanguineo" : tipoSanguineo ?? "",
                                                    "hipertenso" : hipertenso ?? "",
                                                    "diabetico" : diabetico ?? "",
                                                    "doadorOrgaos" : doadorOrgaos ?? "",
                                                    "pcd" : pcd ?? ""]
                let dependentVacinasCrianca:[String : Any] = [ "BCG" : BCG_CR!,
                                                      "Hepatite_B" : Hepatite_B_CR!,
                                                      "Penta_1_Dose" : Penta_1_Dose_CR!,
                                                      "Poliomielite_1_Dose" : Poliomielite_1_Dose_CR!,
                                                      "Poliomielite_2_Dose" : Poliomielite_2_Dose_CR!,
                                                      "Poliomielite_3_Dose" : Poliomielite_3_Dose_CR!,
                                                      "Pneumococica_10" : Pneumococica_10_CR!,
                                                      "Rotavirus_Humano_1_Dose" : Rotavirus_Humano_1_Dose_CR!,
                                                      "Meningococica_C" : Meningococica_C_CR!,
                                                      "Penta_2_Dose" : Penta_2_Dose_CR!,
                                                      "Pneumococica_10_Valente" : Pneumococica_10_Valente_CR!,
                                                      "Rotavirus_Humano_2_Dose" : Rotavirus_Humano_2_Dose_CR!,
                                                      "Febre_Amarela" : Febre_Amarela_CR!,
                                                      "Triplice_Viral" : Triplice_Viral_CR!,
                                                      "Pneumococica_Reforco" : Pneumococica_Reforco_CR!,
                                                      "Meningococica_Reforco" : Meningococica_Reforco_CR!,
                                                      "Hepatite_A" : Hepatite_A_CR!,
                                                      "Tetra_Viral" : Tetra_Viral_CR!,
                                                      "DTP" : DTP_CR!,
                                                      "Varicela" : Varicela_CR!]
                let dependentVacinasAdolescente:[String : Any] = [ "HPV_1_Dose" : HPV_1_Dose_AD!,
                                                          "HPV_2_Dose" : HPV_2_Dose_AD!,
                                                          "Meningococica_C" : Meningococica_C_AD!,
                                                          "Hepatite_B" : Hepatite_B_AD!,
                                                          "Febre_Amarela_1_Dose" : Febre_Amarela_1_Dose_AD!,
                                                          "Dupla_Adulto_DT" : Dupla_Adulto_DT_AD!,
                                                          "Triplice_Viral" : Triplice_Viral_AD!,
                                                          "Pneumococica_23_Valente" : Pneumococica_23_Valente_AD!]
                let dependentVacinasAdulto:[String : Any] = [ "Dupla_Adulto_DT" : Dupla_Adulto_DT_ADU!,
                                                     "Gripe" : Gripe_ADU!,
                                                     "Meningite_BACWY" : Meningite_BACWY_ADU!,
                                                     "Hpv" : Hpv_ADU!,
                                                     "Pneumonia" : Pneumonia_ADU!,
                                                     "Herpes_Zoster" : Herpes_Zoster_ADU!,
                                                     "Febre_Amarela" : Febre_Amarela_ADU!,
                                                     "Hepatite_B" : Hepatite_B_ADU!,
                                                     "Triplice_Viral" : Triplice_Viral_ADU!,
                                                     "Hepatite_A" : Hepatite_A_ADU!,
                                                     "Varicela" : Varicela_ADU!]
                let dependentVacinasIdoso:[String : Any] = [ "Hepatite_B" : Hepatite_B_ID!,
                                                    "Febre_Amarela" : Febre_Amarela_ID!,
                                                    "Dupla_Adulto_DT" : Dupla_Adulto_DT_ID!,
                                                    "Pneumococica_23_Valente" : Pneumococica_23_Valente_ID!,
                                                    "Gripe_Anual" : Gripe_Anual_ID!]
                let dependentVacinasGestante:[String : Any] = [ "Hepatite_B" : Hepatite_B_GES!,
                                                       "Dupla_Adulto_DT" : Dupla_Adulto_DT_GES!,
                                                       "dTpa" : dTpa_GES!,
                                                       "Influenza" : Influenza_GES!]
                
                //GRAVANDO DADOS PESSOAIS DO DEPENDENTE
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)").setValue(dependentData) { (error, context) in
                    if error == nil {
                        print("Dependente \(nome ?? "") salvo")
                    }else{
                        print("Deu erro: \(error.debugDescription)")
                    }
                }
                
                //GRAVANDO AS VACINAS DEPENDENTE
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)/vacinasCrianca").setValue(dependentVacinasCrianca) { (error, context) in
                    if error == nil {} else{print("Deu erro: \(error.debugDescription)")}}
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)/vacinasAdolescente").setValue(dependentVacinasAdolescente) { (error, context) in
                    if error == nil {} else{print("Deu erro: \(error.debugDescription)")}}
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)/vacinasAdulto").setValue(dependentVacinasAdulto) { (error, context) in
                    if error == nil {} else{print("Deu erro: \(error.debugDescription)")}}
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)/vacinasIdoso").setValue(dependentVacinasIdoso) { (error, context) in
                    if error == nil {} else{print("Deu erro: \(error.debugDescription)")}}
                context.child("user/profile").child(formattedEmail).child("dependentes/\(seq)/vacinasGestante").setValue(dependentVacinasGestante) { (error, context) in
                    if error == nil {} else{print("Deu erro: \(error.debugDescription)")}}
                
                seq += 1
                
            }
        }
        
    }
    
}
