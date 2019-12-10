//
//  HomeDataProvider.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol HomeProviderProtocol: class {
    func successOnLoadingHomeProvider(titular: Titular?)
    func errorOnLoadingHomeProvider(error: Error?)
}

class HomeDataProvider {
    
    private let uid = Auth.auth().currentUser
    var titular: Titular?
    weak var delegate: HomeProviderProtocol?
    
    func loadPersonFromFirebase(){
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
                switch dictUser["tipoSanguineo"] as? String {
                   case "A":
                    self.titular?.tipoSanguineo = .A
                   case "A_":
                       self.titular?.tipoSanguineo = .A_
                   case "B":
                       self.titular?.tipoSanguineo = .B
                   case "B_":
                       self.titular?.tipoSanguineo = .B_
                   case "O":
                       self.titular?.tipoSanguineo = .O
                   default:
                       self.titular?.tipoSanguineo = .O_
                   }
                
                
               var listaVacinaFirebaseTitular: Array = dictUser["vacinas"] as? Array ?? []
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
                   
                   var nome: String = vacina!["nome"] as! String
                   var status: Bool = false
                   
                   if vacina!["status"] as! String == "true" {
                       status = true
                   }

                   var newVacina: Vacina = Vacina(nome: nome, grupo: grupo, status: status)
                   indexVacinaTitular = indexVacinaTitular + 1
                   listaVacinaTitular.append(newVacina)
               }
                
                self.titular?.listaVacinas = listaVacinaTitular
                
                //Pegando dados dependentes!
                var listaDependenteFirebase: Array = dictUser["dependentes"] as? Array ?? []
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
                    
                    
                    var listaVacinaFirebase: Array = information?["vacinas"] as? Array ?? []
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
                        
                        var nome: String = vacina!["nome"] as! String
                        var status: Bool = false
                        
                        if vacina!["status"] as! String == "true" {
                            status = true
                        }

                        var newVacina: Vacina = Vacina(nome: nome, grupo: grupo, status: status)
                        indexVacina = indexVacina + 1
                        listaVacina.append(newVacina)
                    }
                    
                    
                    var pessoa: Pessoa = Pessoa(nome: information?["name"] as? String , imagem: information?["imagem"] as? String, grupo: grupo, tipoSanguineo: tipoSanguineo, hipertenso: information?["hipertenso"] as? Bool ?? false, diabetico: information?["diabetico"] as? Bool ?? false, doadorOrgaos: information?["doadorOrgaos"] as? Bool ?? false, pcd: information?["pcd"] as? Bool ?? false, listaVacinas: listaVacina)
                    
                    
                    
                    index = index + 1
                    listaDependente.append(pessoa)
                }
                
                self.titular?.dependentes = listaDependente
            }
            
            
            self.delegate?.successOnLoadingHomeProvider(titular: self.titular)
        }
        
    }
}
