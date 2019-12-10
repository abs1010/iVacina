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

protocol ProfileControllerDelegate : class {
    func successOnLoadingProfileController(titular: Titular?)
    func errorOnLoadingProfileController(error: Error?)
}

class ProfileController {
    
    var pessoa: Titular?
    
    weak var delegate: ProfileControllerDelegate?
    
    //private let uid = Auth.auth().currentUser
    private var uid : User?
    
    private var provider: ProfileProvider?
    
    private var grupoArray : [String] = ["Criança", "Adolescente", "Adulto", "Idoso", "Gestante"]
    private var tipoSanguineoArray : [String] = ["A-", "B-", "O-", "A+", "B+", "O+"]
    
    func setupController(){
        
        self.provider = ProfileProvider()
        self.provider?.delegate = self
        self.provider?.getProfileData()
        
    }
    
    func isLoggedIn(value: Bool){
        UserDefaults.standard.setLoggedInState(value: value)
    }
    
    func loadCurrentTitular() -> Titular {
        
        return self.pessoa!
        
    }
    
    func getNomePessoa() -> String {
        
        return self.pessoa?.nome ?? ""
        
    }
    
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
    
    func saveInfo(person: Titular) {
        
        self.uid = Auth.auth().currentUser
        //Aponta par o banco de dados
        let context = Database.database().reference()
        
        //personalData
        let personalData:[String : Any] = ["name"          : person.nome ?? "",
                                           "email"         : person.email ?? "",
                                           "imagem"        : person.email ?? "",
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
                                                "imagem"        : "\(uid?.email ?? "").dep\(seqDep)",
                                                "grupo"         : "\(person.dependentes[seqDep]?.grupo ?? .Adulto)",
                                                "tipoSanguineo" : "\(person.dependentes[seqDep]?.tipoSanguineo ?? .A_)",
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
    
    func getNumberOfDependent() -> Int {
        return self.pessoa?.dependentes.count ?? 0
    }
    
    func saveDependent(pessoa: Pessoa) {
        //Aponta par o banco de dados
        let context = Database.database().reference()
        let count: Int = self.getNumberOfDependent()
        let dependentData:[String : Any] = ["name"          : pessoa.nome ?? "",
                                            "imagem"        : pessoa.imagem ?? "",
                                            "grupo"         : "\(pessoa.grupo)",
                                            "tipoSanguineo" : "\(pessoa.tipoSanguineo)",
                                            "hipertenso"    : pessoa.hipertenso ,
                                            "diabetico"     : pessoa.diabetico ,
                                            "doadorOrgaos"  : pessoa.doadorOrgaos ,
                                            "pcd"           : pessoa.pcd ]
        
        
        //GRAVANDO DADOS PESSOAIS DO DEPENDENTE
        let formattedEmail = (self.pessoa?.email?.replacingOccurrences(of: ".", with: ",")) ?? ""
    context.child("user/profile").child(formattedEmail).child("dependentes/\(count)").setValue(dependentData) { (error, context) in
            if error == nil {
                print("Dependente salvo")
            }else{
                print("Deu merda: \(error.debugDescription)")
            }
        }
        
        //GRAVANDO AS VACINAS DEPENDENTE
        var seqVacDep = 0
        for vacina in pessoa.listaVacinas ?? [] {
            
            let setVacina:[String : Any] = ["nome"    : vacina.nome,
                                            "grupo"   : String("\(vacina.grupo)"),
                                            "status"  : String("\(vacina.status)")]
            
            context.child("user/profile").child(formattedEmail).child("dependentes/\(count)/vacinas/\(seqVacDep)").setValue(setVacina) { (error, context) in
                if error == nil {}
                else{print("Deu merda: \(error.debugDescription)")}
            }
            seqVacDep += 1
        }
    }
    
}

extension ProfileController : ProfileProviderDelegate {
    
    func successOnLoadingProfiles(titular: Titular?) {
        self.pessoa = titular
        self.delegate?.successOnLoadingProfileController(titular: titular)
    }
    
    func errorOnLoadingProfiles(error: Error?) {
        
        self.delegate?.errorOnLoadingProfileController(error: error)
        
    }
    
}
