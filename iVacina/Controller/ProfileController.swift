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
    
    var titular: Titular?
    var pessoa: Pessoa?
    
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
        
        return self.titular ?? Titular(nome: "", email: "", imagem: "", grupo: .Adolescente, tipoSanguineo: .A, hipertenso: true, diabetico: true, doadorOrgaos: true, pcd: true, listaVacinas: [], dependentes: [])
        
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
        
        let dep : Int = self.titular?.dependentes.count ?? 0
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
//        var seqDep = 0//contador de dependentes
//        for _ in person.dependentes {
//
//            //personalData
//            let dependentData:[String : Any] = ["name"          : person.dependentes[seqDep]?.nome ?? "",
//                                                "imagem"        : "\(uid?.email ?? "").dep\(seqDep)",
//                                                "grupo"         : "\(person.dependentes[seqDep]?.grupo ?? .Adulto)",
//                                                "tipoSanguineo" : "\(person.dependentes[seqDep]?.tipoSanguineo ?? .A_)",
//                                                "hipertenso"    : person.dependentes[seqDep]?.hipertenso ?? "",
//                                                "diabetico"     : person.dependentes[seqDep]?.diabetico ?? "",
//                                                "doadorOrgaos"  : person.dependentes[seqDep]?.doadorOrgaos ?? "",
//                                                "pcd"           : person.dependentes[seqDep]?.pcd ?? ""]
//
//
//            //GRAVANDO DADOS PESSOAIS DO DEPENDENTE
//            context.child("user/profile").child(formattedEmail).child("dependentes/\(seqDep)").setValue(dependentData) { (error, context) in
//                if error == nil {
//                    print("Dependente salvo")
//                }else{
//                    print("Deu merda: \(error.debugDescription)")
//                }
//            }
//
//            //GRAVANDO AS VACINAS DEPENDENTE
//            var seqVacDep = 0
//            for vacina in person.dependentes[seqDep]!.listaVacinas {
//
//                let setVacina:[String : Any] = ["nome"    : vacina.nome,
//                                                "grupo"   : String("\(vacina.grupo)"),
//                                                "status"  : String("\(vacina.status)")]
//
//                context.child("user/profile").child(formattedEmail).child("dependentes/\(seqDep)/vacinas/\(seqVacDep)").setValue(setVacina) { (error, context) in
//                    if error == nil {}
//                    else{print("Deu merda: \(error.debugDescription)")}
//                }
//                seqVacDep += 1
//            }
//
//
//            seqDep += 1//acrescentando ao contador de dependentes
            
//        }
    }
    
    func getNumberOfDependent() -> Int {
        return self.titular?.dependentes.count ?? 0
    }
    
func saveDependent(dependente: Pessoa, email: String, tmpUser: Titular, index: Int) {
        //Aponta par o banco de dados
        let context = Database.database().reference()
//        let count: Int = tmpUser.dependentes.count
        let count: Int = index
        let dependentData:[String : Any] = ["name"          : dependente.nome ?? "",
                                            "imagem"        : dependente.imagem ?? "",
                                            "grupo"         : "\(dependente.grupo)",
                                            "tipoSanguineo" : "\(dependente.tipoSanguineo)",
                                            "hipertenso"    : dependente.hipertenso ,
                                            "diabetico"     : dependente.diabetico ,
                                            "doadorOrgaos"  : dependente.doadorOrgaos ,
                                            "pcd"           : dependente.pcd ]
        
        
        //GRAVANDO DADOS PESSOAIS DO DEPENDENTE
        let formattedEmail = (email.replacingOccurrences(of: ".", with: ",")) 
    context.child("user/profile").child(formattedEmail).child("dependentes/\(count)").setValue(dependentData) { (error, context) in
            if error == nil {
                print("Dependente salvo")
            }else{
                print("Deu merda: \(error.debugDescription)")
            }
        }
        
        //GRAVANDO AS VACINAS DEPENDENTE
        var seqVacDep = 0
        for vacina in dependente.listaVacinas {
            
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
    
    func getSelectedPerson(index: Int) -> Pessoa {
        if index == 0 {
            return self.titular ?? self.loadNilTitular()
        } else {
            return self.titular?.dependentes[((index ?? 0)-1)] ?? self.loadNilPerson()
        }
    }
    
    func loadNilPerson() -> Pessoa {
        return Pessoa(nome: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: true, diabetico: true, doadorOrgaos: true, pcd: true, listaVacinas: [])
    }
    
    func loadNilTitular() -> Titular {
        return Titular(nome: "", email: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [], dependentes: [])
    }
    
    func getVacinaGrupo(grupo: Grupo, selected: Int) -> [Vacina] {
        var listaVacina: [Vacina] = []
        switch grupo {
        case .Crianca:
            for vacina in self.getSelectedPerson(index: selected).listaVacinas {
                if vacina.grupo == .Crianca{
                    listaVacina.append(vacina)
                }
            }
        case .Adolescente:
            for vacina in self.getSelectedPerson(index: selected).listaVacinas {
                if vacina.grupo == .Adolescente{
                    listaVacina.append(vacina)
                }
            }
        case .Adulto:
            for vacina in self.getSelectedPerson(index: selected).listaVacinas {
                if vacina.grupo == .Adulto{
                    listaVacina.append(vacina)
                }
            }
        case .Idoso:
            for vacina in self.getSelectedPerson(index: selected).listaVacinas {
                if vacina.grupo == .Idoso{
                    listaVacina.append(vacina)
                }
            }
        case .Gestante:
            for vacina in self.getSelectedPerson(index: selected).listaVacinas {
                if vacina.grupo == .Gestante{
                    listaVacina.append(vacina)
                }
            }
        }
        return listaVacina
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
