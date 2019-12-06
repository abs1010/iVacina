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
    
    private var grupoArray : [String] = ["Criança", "Adolescente", "Adulto", "Idoso", "Gestante"]
    private var tipoSanguineoArray : [String] = ["A-", "B-", "O-", "A+", "B+", "O+"]
    
    func getIndexOfGroup(indexPath: IndexPath) -> String{
        return grupoArray[indexPath.row]
    }
    
    func getIndexOfBloodType(indexPath: IndexPath) -> String{
          return tipoSanguineoArray[indexPath.row]
      }
    
    func getNumberOfRowsInSectionForGroup() -> Int{
        return grupoArray.count
    }
    
    func getNumberOfRowsInSectionForBloodType() -> Int{
          return tipoSanguineoArray.count
      }
    
    func getImageToSet(index: IndexPath) -> String {
        
        if index.row == 0 {
            return "crianca"
        }
        if index.row == 1 {
            return "adolescente"
        }
        if index.row == 2 {
            return "adulto"
        }
        if index.row == 3 {
            return "idoso"
        }
        if index.row == 4 {
            return "gestante"
        }
        
        return ""
    }
    
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
    
    func saveInfo(person: Titular) {
        
        //Aponta par o banco de dados
        let context = Database.database().reference()
        
        //personalData
        let personalData:[String : Any] = ["name"          : person.nome ?? "",
                                           "email"         : person.email ?? "",
                                           "imagem"        : person.imagem ?? "",
                                           "grupo"         : String("\(person.grupo)"),
                                           "tipoSanguineo" : String("\(person.tipoSanguineo)"),
                                           "hipertenso"    : person.hipertenso,
                                           "diabetico"     : person.diabetico,
                                           "doadorOrgaos"  : person.doadorOrgaos,
                                           "pcd"           : person.pcd]
        
        
        //GRAVANDO OS DADOS PESSOAS
        let formattedEmail = (person.email?.replacingOccurrences(of: ".", with: ","))!
        context.child("user/profile").child(formattedEmail).setValue(personalData) { (error, context) in
            if error == nil {
                print("Dados pessoais de \(person.email ?? "") salvos com sucesso")
            }else{
                print("Deu erro: \(error.debugDescription)")
            }
            
        }
        //VACINAS
        var seq = 0
        
        for vacina in person.listaVacinas {
            
            let setVacina:[String : Any] = ["nome"    : vacina.nome,
                                            "grupo"   : String("\(vacina.grupo)"),
                                            "status"  : String("\(vacina.status)")]
            
            context.child("user/profile").child(formattedEmail).child("vacinas/\(seq)").setValue(setVacina) { (error, context) in
                if error == nil {
                    print("\(vacina) salva")
                }else{
                    print("Deu merda: \(error.debugDescription)")
                }
            }
            seq += 1
        }
        
        //DEPENDENTES
        var seqDep = 0//contador de dependentes
        for _ in person.dependentes {
            
            //personalData
            let dependentData:[String : Any] = ["name"          : person.dependentes[seqDep]?.nome ?? "",
                                                "imagem"        : person.dependentes[seqDep]?.imagem ?? "",
                                                "grupo"         : String("\(person.dependentes[seqDep]?.grupo)"),
                                                "tipoSanguineo" : String("\(person.dependentes[seqDep]?.tipoSanguineo)"),
                                                "hipertenso"    : person.dependentes[seqDep]?.hipertenso ?? "",
                                                "diabetico"     : person.dependentes[seqDep]?.diabetico ?? "",
                                                "doadorOrgaos"  : person.dependentes[seqDep]?.doadorOrgaos ?? "",
                                                "pcd"           : person.dependentes[seqDep]?.pcd ?? ""]
            
            
            //GRAVANDO DADOS PESSOAIS DO DEPENDENTE
            context.child("user/profile").child(formattedEmail).child("dependentes/\(seqDep)").setValue(dependentData) { (error, context) in
                if error == nil {
                    print("Dependente salvo")
                }else{
                    print("Deu merda: \(error.debugDescription)")
                }
            }
            
            //GRAVANDO AS VACINAS DEPENDENTE
            var seqVacDep = 0
            for vacina in person.dependentes[seqDep]!.listaVacinas {

                let setVacina:[String : Any] = ["nome"    : vacina.nome,
                                                "grupo"   : String("\(vacina.grupo)"),
                                                "status"  : String("\(vacina.status)")]

                context.child("user/profile").child(formattedEmail).child("dependentes/\(seqDep)/vacinas/\(seqVacDep)").setValue(setVacina) { (error, context) in
                    if error == nil {}
                    else{print("Deu merda: \(error.debugDescription)")}
                }
                seqVacDep += 1
            }
            
            
            seqDep += 1//acrescentando ao contador de dependentes
            
        }
    }
    
}

