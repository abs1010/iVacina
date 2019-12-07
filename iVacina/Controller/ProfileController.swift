//
//  ProfileController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ProfileController {
    
   // private let uid = Auth.auth().currentUser
    
    var pessoa: Titular?
    private var saveModelController : Salvar?
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
    
    func getNumberOfRowsInSectionForCells() -> Int{
        
        let dep : Int = self.pessoa?.dependentes.count ?? 0
        //1 titular + dependentes
        let total = 1 + dep
        
        return total
    }
    
    func getPessoa(indexPath: IndexPath) -> Pessoa {
        
        //if indexPath.row == 0 {
            
        return self.saveModelController!.tempUser
            
        //}
        
        //return
        
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
    
//    func getUserInfo() -> Titular {
//
//        let email = "alan@gmail.com"
//        //if let email = self.uid?.email {
//
//            let formattedEmail = email.replacingOccurrences(of: ".", with: ",")
//
//            let user = Database.database().reference().child("user/profile/\(formattedEmail)")
//
//            user.observe(.value) { (userInformation) in
//
//                if let dictUser = userInformation.value as? [String:Any]{
//                    self.pessoa?.nome = dictUser["name"] as? String
//                    self.pessoa?.email = dictUser["email"] as? String
//                    //self.pessoa.grupo = dictUser["grupo"] as? String
//                    //self.pessoa?.tipoSanguineo = dictUser["grupo"] as? String
//                    self.pessoa?.hipertenso = dictUser["hipertenso"] as! Bool
//                    self.pessoa?.diabetico = dictUser["diabetico"] as! Bool
//                    self.pessoa?.doadorOrgaos = dictUser["doadorOrgaos"] as! Bool
//                    self.pessoa?.pcd = dictUser["pcd"] as! Bool
//
//                }
//
//            }
//
//      //  }
//
//        return self.pessoa ?? self.saveModelController!.tempUser
//
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

