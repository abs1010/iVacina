//
//  ProfileDataProvider.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol ProfileProviderDelegate : class {
    func successOnLoadingProfiles(titular: Titular?)
    func errorOnLoadingProfiles(error: Error?)
}

class ProfileProvider {
    
    weak var delegate : ProfileProviderDelegate?
    private var titular: Titular?
    //private let uid = Auth.auth().currentUser
    private var uid : User?
    
    var tempUser: Titular = Titular(nome: "nome", email: (Auth.auth().currentUser?.email)! , imagem: "imagem", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [
        Vacina(nome: "BCG", grupo: .Crianca, status: false),
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
    
    var dependente : Pessoa = Pessoa(nome: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [
        Vacina(nome: "BCG", grupo: .Crianca, status: false),
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
    
    //MARK: - METODO ADD DEPENDENTE
    
    func addDependente(dependente: Pessoa){
        
        self.tempUser.dependentes.append(dependente)
        
    }
    
    //MARK: - METODO DE OBTER DADOS DO FIREBASE A PARTIR DO E-MAIL LOGADO
    
    func getProfileData(){
        self.uid = Auth.auth().currentUser
        let email = self.uid?.email ?? ""
        let formattedEmail = email.replacingOccurrences(of: ".", with: ",")
        let user = Database.database().reference().child("user/profile/\(formattedEmail)")
        self.titular = Titular(nome: "", email: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [], dependentes: [])
        
        self.titular?.email = email
        user.observe(.value) { (userInformation) in
            if let dictUser = userInformation.value as? [String: Any] {
                self.titular?.nome = dictUser["name"] as? String
                self.titular?.diabetico = dictUser["diabetico"] as? Bool ?? false
                self.titular?.doadorOrgaos = dictUser["doadorOrgaos"] as? Bool ?? false
                self.titular?.hipertenso = dictUser["hipertenso"] as? Bool ?? false
                let grupo: String = dictUser["grupo"] as? String ?? ""
                switch grupo {
                case "Crianca":
                    self.titular?.grupo = .Crianca
                case "Adolescente":
                    self.titular?.grupo = .Adolescente
                case "Adulto":
                    self.titular?.grupo = .Adulto
                case "Idose":
                    self.titular?.grupo = .Idoso
                default:
                    self.titular?.grupo = .Gestante
                }
                self.titular?.imagem = dictUser["imagem"] as? String
                self.titular?.pcd = dictUser["pcd"] as? Bool ?? false
                
                
                let listaVacinaFirebaseTitular: Array = dictUser["vacinas"] as? Array ?? []
                var indexVacinaTitular: Int = 0
                var listaVacinaTitular: [Vacina] = []
                while indexVacinaTitular < listaVacinaFirebaseTitular.count {
                    let vacina = listaVacinaFirebaseTitular[indexVacinaTitular] as? [String:Any]
                    var grupo: Grupo
                    
                    switch vacina!["grupo"] as! String {
                    case "Crianca":
                        grupo = .Crianca
                    case "Adolescente":
                        grupo = .Adolescente
                    case "Adulto":
                        grupo = .Adulto
                    case "Idoso":
                        grupo = .Idoso
                    default:
                        grupo = .Gestante
                    }
                    
                    let nome: String = vacina!["nome"] as! String
                    var status: Bool = false
                    
                    if vacina!["status"] as! String == "true" {
                        status = true
                    }
                    
                    let newVacina: Vacina = Vacina(nome: nome, grupo: grupo, status: status)
                    indexVacinaTitular = indexVacinaTitular + 1
                    listaVacinaTitular.append(newVacina)
                }
                
                self.titular?.listaVacinas = listaVacinaTitular
                
                //Pegando dados dependentes!
                let listaDependenteFirebase: Array = dictUser["dependentes"] as? Array ?? []
                var index: Int = 0
                var listaDependente: [Pessoa] = []
                while index < listaDependenteFirebase.count ?? 0{
                    let information = listaDependenteFirebase[index] as? [String:Any]
                    var grupo: Grupo
                    var tipoSanguineo: TipoSanguineo
                    
                    switch information!["grupo"] as! String {
                    case "Crianca":
                        grupo = .Crianca
                    case "Adolescente":
                        grupo = .Adolescente
                    case "Adulto":
                        grupo = .Adulto
                    case "Idoso":
                        grupo = .Idoso
                    default:
                        grupo = .Gestante
                    }
                    
                    switch information!["tipoSanguineo"] as! String {
                    case "A":
                        tipoSanguineo = .A
                    case "A_":
                        tipoSanguineo = .A_
                    case "B":
                        tipoSanguineo = .B
                    case "B_":
                        tipoSanguineo = .B_
                    case "O":
                        tipoSanguineo = .O
                    default:
                        tipoSanguineo = .O_
                    }
                    
                    
                    let listaVacinaFirebase: Array = information?["vacinas"] as? Array ?? []
                    var indexVacina: Int = 0
                    var listaVacina: [Vacina] = []
                    while indexVacina < listaVacinaFirebase.count {
                        let vacina = listaVacinaFirebase[indexVacina] as? [String:Any]
                        var grupo: Grupo
                        
                        switch vacina!["grupo"] as! String {
                        case "Crianca":
                            grupo = .Crianca
                        case "Adolescente":
                            grupo = .Adolescente
                        case "Adulto":
                            grupo = .Adulto
                        case "Idose":
                            grupo = .Idoso
                        default:
                            grupo = .Gestante
                        }
                        
                        let nome: String = vacina!["nome"] as! String
                        var status: Bool = false
                        
                        if vacina!["status"] as! String == "true" {
                            status = true
                        }
                        
                        let newVacina: Vacina = Vacina(nome: nome, grupo: grupo, status: status)
                        indexVacina = indexVacina + 1
                        listaVacina.append(newVacina)
                    }
                    
                    
                    let pessoa: Pessoa = Pessoa(nome: information?["name"] as? String , imagem: information?["imagem"] as? String, grupo: grupo, tipoSanguineo: tipoSanguineo, hipertenso: information?["hipertenso"] as? Bool ?? false, diabetico: information?["diabetico"] as? Bool ?? false, doadorOrgaos: information?["doadorOrgaos"] as? Bool ?? false, pcd: information?["pcd"] as? Bool ?? false, listaVacinas: listaVacina)
                    
                    
                    
                    index = index + 1
                    listaDependente.append(pessoa)
                }
                
                self.titular?.dependentes = listaDependente
            }
            self.delegate?.successOnLoadingProfiles(titular: self.titular)
        }
        
        self.delegate?.successOnLoadingProfiles(titular: titular)
        self.tempUser = self.titular!
    }
    
    
}
