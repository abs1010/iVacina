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
    
    func getTamanhoListaVacina() -> Int{
        return self.pessoa?.listaVacina.count ?? 0
    }
    
    func getTamanhoListaProximaVacina() -> Int{
        return self.pessoa?.listaProximaVacina.count ?? 0
    }
    
    func setPessoa(pessoa: Pessoa?){
        if let _pessoa = pessoa{
            self.pessoa = _pessoa
        }
    }
    
    func getPessoa() -> Pessoa?{
        return self.pessoa
    }
    
    func saveInfo(person: Person?){
        
        //Aponta par o banco de dados
        let context = Database.database().reference()
        
        //personalData
        let nome = person?.nome
        let email = person?.email
        let imagem = person?.imagem
        let grupo = String("\(person?.grupo)")
        let tipoSanguineo = person?.nome
        let hipertenso = person?.hipertenso
        let diabetico = person?.diabetico
        let doadorOrgaos = person?.doadorOrgaos
        let pcd = person?.pcd
        
        let personalData:[String : Any] = ["name" : nome ?? "",
                                           "email" : email ?? "",
                                           "imagem" : imagem ?? "",
                                           "grupo" : grupo,
                                           "tipoSanguineo" : tipoSanguineo ?? "",
                                           "hipertenso" : hipertenso ?? "",
                                           "diabetico" : diabetico ?? "",
                                           "doadorOrgaos" : doadorOrgaos ?? "",
                                           "pcd" : pcd ?? ""]
        
        //Vacinas Crianca
        let BCG_CR                     = person?.vacinasCrianca[0][.BCG]
        let Hepatite_B_CR              = person?.vacinasCrianca[0][.Hepatite_B]
        let Penta_1_Dose_CR            = person?.vacinasCrianca[0][.Penta_1_Dose]
        let Poliomielite_1_Dose_CR     = person?.vacinasCrianca[0][.Poliomielite_1_Dose]
        let Poliomielite_2_Dose_CR     = person?.vacinasCrianca[0][.Poliomielite_2_Dose]
        let Poliomielite_3_Dose_CR     = person?.vacinasCrianca[0][.Poliomielite_3_Dose]
        let Pneumococica_10_CR         = person?.vacinasCrianca[0][.Pneumococica_10]
        let Rotavirus_Humano_1_Dose_CR = person?.vacinasCrianca[0][.Rotavirus_Humano_1_Dose]
        let Meningococica_C_CR         = person?.vacinasCrianca[0][.Meningococica_C]
        let Penta_2_Dose_CR            = person?.vacinasCrianca[0][.Penta_2_Dose]
        let Pneumococica_10_Valente_CR = person?.vacinasCrianca[0][.Pneumococica_10_Valente]
        let Rotavirus_Humano_2_Dose_CR = person?.vacinasCrianca[0][.Rotavirus_Humano_2_Dose]
        let Febre_Amarela_CR           = person?.vacinasCrianca[0][.Febre_Amarela]
        let Triplice_Viral_CR          = person?.vacinasCrianca[0][.Triplice_Viral]
        let Pneumococica_Reforco_CR    = person?.vacinasCrianca[0][.Pneumococica_Reforco]
        let Meningococica_Reforco_CR   = person?.vacinasCrianca[0][.Meningococica_Reforco]
        let Hepatite_A_CR              = person?.vacinasCrianca[0][.Hepatite_A]
        let Tetra_Viral_CR             = person?.vacinasCrianca[0][.Tetra_Viral]
        let DTP_CR                     = person?.vacinasCrianca[0][.DTP]
        let Varicela_CR                = person?.vacinasCrianca[0][.Varicela]
        
        let vacinasCrianca:[String : Any] = [ "BCG" : BCG_CR! ?? "",
                                              "Hepatite_B" : Hepatite_B_CR! ?? "",
                                              "Penta_1_Dose" : Penta_1_Dose_CR! ?? "",
                                              "Poliomielite_1_Dose" : Poliomielite_1_Dose_CR! ?? "",
                                              "Poliomielite_2_Dose" : Poliomielite_2_Dose_CR! ?? "",
                                              "Poliomielite_3_Dose" : Poliomielite_3_Dose_CR! ?? "",
                                              "Pneumococica_10" : Pneumococica_10_CR! ?? "",
                                              "Rotavirus_Humano_1_Dose" : Rotavirus_Humano_1_Dose_CR! ?? "",
                                              "Meningococica_C" : Meningococica_C_CR! ?? "",
                                              "Penta_2_Dose" : Penta_2_Dose_CR! ?? "",
                                              "Pneumococica_10_Valente" : Pneumococica_10_Valente_CR! ?? "",
                                              "Rotavirus_Humano_2_Dose" : Rotavirus_Humano_2_Dose_CR! ?? "",
                                              "Febre_Amarela" : Febre_Amarela_CR! ?? "",
                                              "Triplice_Viral" : Triplice_Viral_CR! ?? "",
                                              "Pneumococica_Reforco" : Pneumococica_Reforco_CR! ?? "",
                                              "Meningococica_Reforco" : Meningococica_Reforco_CR! ?? "",
                                              "Hepatite_A" : Hepatite_A_CR! ?? "",
                                              "Tetra_Viral" : Tetra_Viral_CR! ?? "",
                                              "DTP" : DTP_CR! ?? "",
                                              "Varicela" : Varicela_CR! ?? ""]
        
        //Vacinas Adolescente
        let HPV_1_Dose_AD              = person?.vacinasAdolescente[0][.HPV_1_Dose]
        let HPV_2_Dose_AD              = person?.vacinasAdolescente[0][.HPV_2_Dose]
        let Meningococica_C_AD         = person?.vacinasAdolescente[0][.Meningococica_C]
        let Hepatite_B_AD              = person?.vacinasAdolescente[0][.Hepatite_B]
        let Febre_Amarela_1_Dose_AD    = person?.vacinasAdolescente[0][.Febre_Amarela_1_Dose]
        let Dupla_Adulto_DT_AD         = person?.vacinasAdolescente[0][.Dupla_Adulto_DT]
        let Triplice_Viral_AD          = person?.vacinasAdolescente[0][.Triplice_Viral]
        let Pneumococica_23_Valente_AD = person?.vacinasAdolescente[0][.Pneumococica_23_Valente]

        let vacinasAdolescente:[String : Any] = [ "HPV_1_Dose" : HPV_1_Dose_AD! ?? "",
                                                  "HPV_2_Dose" : HPV_2_Dose_AD! ?? "",
                                                  "Meningococica_C" : Meningococica_C_AD! ?? "",
                                                  "Hepatite_B" : Hepatite_B_AD! ?? "",
                                                  "Febre_Amarela_1_Dose" : Febre_Amarela_1_Dose_AD! ?? "",
                                                  "Dupla_Adulto_DT" : Dupla_Adulto_DT_AD! ?? "",
                                                  "Triplice_Viral" : Triplice_Viral_AD! ?? "",
                                                  "Pneumococica_23_Valente" : Pneumococica_23_Valente_AD! ?? ""]
        
        //Vacinas Adulto
        let Dupla_Adulto_DT_ADU        = person?.vacinasAdulto[0][.Dupla_Adulto_DT]
        let Gripe_ADU                  = person?.vacinasAdulto[0][.Gripe]
        let Meningite_BACWY_ADU        = person?.vacinasAdulto[0][.Meningite_BACWY]
        let Hpv_ADU                    = person?.vacinasAdulto[0][.Hpv]
        let Pneumonia_ADU              = person?.vacinasAdulto[0][.Pneumonia]
        let Herpes_Zoster_ADU          = person?.vacinasAdulto[0][.Herpes_Zoster]
        let Febre_Amarela_ADU          = person?.vacinasAdulto[0][.Febre_Amarela]
        let Hepatite_B_ADU             = person?.vacinasAdulto[0][.Hepatite_B]
        let Triplice_Viral_ADU         = person?.vacinasAdulto[0][.Triplice_Viral]
        let Hepatite_A_ADU             = person?.vacinasAdulto[0][.Hepatite_A]
        let Varicela_ADU               = person?.vacinasAdulto[0][.Varicela]

        let vacinasAdulto:[String : Any] = [ "Dupla_Adulto_DT" : Dupla_Adulto_DT_ADU! ?? "",
                                             "Gripe" : Gripe_ADU! ?? "",
                                             "Meningite_BACWY" : Meningite_BACWY_ADU! ?? "",
                                             "Hpv" : Hpv_ADU! ?? "",
                                             "Pneumonia" : Pneumonia_ADU! ?? "",
                                             "Herpes_Zoster" : Herpes_Zoster_ADU! ?? "",
                                             "Febre_Amarela" : Febre_Amarela_ADU! ?? "",
                                             "Hepatite_B" : Hepatite_B_ADU! ?? "",
                                             "Triplice_Viral" : Triplice_Viral_ADU! ?? "",
                                             "Hepatite_A" : Hepatite_A_ADU! ?? "",
                                             "Varicela" : Varicela_ADU! ?? ""]
        
//
//        enum vacinasIdosoEnum: Int, CaseIterable {
//            case Hepatite_B = 0
//            case Febre_Amarela = 1
//            case Dupla_Adulto_DT = 2
//            case Pneumococica_23_Valente = 3
//            case Gripe_Anual = 4
//            case none
//        }
//
//        enum vacinasGestanteEnum: Int, CaseIterable {
//            case Hepatite_B = 0
//            case Dupla_Adulto_DT = 1
//            case dTpa = 2
//            case Influenza = 3
//            case none
//        }
//
        
        
        
        

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
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE ADOLESCENTE
        context.child("user/profile").child(formattedEmail).child("vacinasAdolescente").setValue(vacinasAdolescente) { (error, context) in
            if error == nil {
                print("Dados das vacinas de ADOLESCENTE de \(email ?? "") salvos com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE ADULTO
        context.child("user/profile").child(formattedEmail).child("vacinasAdulto").setValue(vacinasAdulto) { (error, context) in
            if error == nil {
                print("Dados das vacinas de ADULTO de \(email ?? "") salvos com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE IDOSO
        context.child("user/profile").child(formattedEmail).child("vacinasIdoso").setValue(vacinasCrianca) { (error, context) in
            if error == nil {
                print("Dados das vacinas de \(email ?? "") salvos com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //GRAVANDO AS VACINAS DE GESTANTE
        context.child("user/profile").child(formattedEmail).child("vacinasGestante").setValue(vacinasCrianca) { (error, context) in
            if error == nil {
                print("Dados das vacinas de \(email ?? "") salvos com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        
//DEPENDENTES
        
        let nomedependente = "Davi Silva"

        
        context.child("user/profile").child(formattedEmail).child("dependentes/\(nomedependente)").setValue(vacinasCrianca) { (error, context) in
            if error == nil {
                print("Dados das vacinas de \(email) salvos com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error.debugDescription)")
            }

        }
        
        
    }
    
}
