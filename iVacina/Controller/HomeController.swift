//
//  HomeController.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//  

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol HomeControllerDelegate: class {
    func successOnLoadingHomeController()
    func errorOnLoadingHomeController(error: Error?)
}

class HomeController {
    
    private var titular: Titular?
    private var selectedPerson: Int?
    private let uid = Auth.auth().currentUser
    
    weak var delegate: HomeControllerDelegate?
    
    func loadPerson() {
        
//        self.titular = Titular(nome: "Bruna", email: "teste@teste.com", imagem: "", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [Vacina(nome: "Dupla Adulto DT", grupo: .Adulto, status: true), Vacina(nome: "Febre Amarela", grupo: .Adulto, status: true)], dependentes: [Pessoa(nome: "Bia", imagem: "", grupo: .Crianca, tipoSanguineo: .B, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [Vacina(nome: "BCG", grupo: .Crianca, status: true), Vacina(nome: "DTP", grupo: .Crianca, status: false)])])
        
        self.selectedPerson = 0
        self.loadPersonFromFirebase()
    }
    
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
                        indexVacina = indexVacina + 1
                        listaVacina.append(newVacina)
                    }
                    
                    
                    var pessoa: Pessoa = Pessoa(nome: information?["name"] as? String , imagem: information?["imagem"] as? String, grupo: grupo, tipoSanguineo: tipoSanguineo, hipertenso: information?["hipertenso"] as? Bool ?? false, diabetico: information?["diabetico"] as? Bool ?? false, doadorOrgaos: information?["doadorOrgaos"] as? Bool ?? false, pcd: information?["pcd"] as? Bool ?? false, listaVacinas: listaVacina)
                    
                    
                    
                    index = index + 1
                    listaDependente.append(pessoa)
                }
                
                self.titular?.dependentes = listaDependente
            }
            
            
            self.delegate?.successOnLoadingHomeController()
        }
        
    }
    
    func loadNilPerson() -> Pessoa {
        return Pessoa(nome: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: true, diabetico: true, doadorOrgaos: true, pcd: true, listaVacinas: [])
    }
    
    func loadNilTitular() -> Titular {
        return Titular(nome: "", email: "", imagem: "", grupo: .Crianca, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, listaVacinas: [], dependentes: [])
    }
    
    func setPerson(index: Int) {
        self.selectedPerson = index
    }
    
    func getTitular() -> Titular {
        return self.titular ?? self.loadNilTitular()
    }
    
    func getPersonNumberOfItemsInSection() -> Int{
        return (self.getTitular().dependentes.count + 1)
    }
    
    func getVaccineNumberOfRowsInSection() -> Int {
        return self.getSelectedPerson().listaVacinas.count
    }
    
    func getVaccineNumberOfRowsInSection(grupo: Grupo) -> Int {
        var result: Int = 0
        switch grupo {
        case .Crianca:
            //                    result = vacinasCriancaEnum.allCases.count
            result = getVacinaGrupo(grupo: .Crianca).count
        case .Adolescente:
            //                    result = vacinasAdultoEnum.allCases.count
            result = getVacinaGrupo(grupo: .Adolescente).count
        case .Adulto:
            //                    result = vacinasAdultoEnum.allCases.count
            result = getVacinaGrupo(grupo: .Adulto).count
        case .Idoso:
            //                    result = vacinasIdosoEnum.allCases.count
            result = getVacinaGrupo(grupo: .Idoso).count
        case .Gestante:
            //                    result = vacinasGestanteEnum.allCases.count
            result = getVacinaGrupo(grupo: .Gestante).count
        }
        return result
    }
    
    
    func getSelectedPerson() -> Pessoa {
        if self.selectedPerson == 0 {
            return self.getTitular()
        } else {
            return self.getTitular().dependentes[((self.selectedPerson ?? 0)-1)] ?? self.loadNilPerson()
        }
    }
    
    func setSelectedPessoa(index: Int){
        self.selectedPerson = index
    }
    
    func getVacinaGrupo(grupo: Grupo) -> [Vacina] {
        var listaVacina: [Vacina] = []
        switch grupo {
        case .Crianca:
            for vacina in self.getSelectedPerson().listaVacinas {
                if vacina.grupo == .Crianca{
                    listaVacina.append(vacina)
                }
            }
        case .Adolescente:
            for vacina in self.getSelectedPerson().listaVacinas {
                if vacina.grupo == .Adolescente{
                    listaVacina.append(vacina)
                }
            }
        case .Adulto:
            for vacina in self.getSelectedPerson().listaVacinas {
                if vacina.grupo == .Adulto{
                    listaVacina.append(vacina)
                }
            }
        case .Idoso:
            for vacina in self.getSelectedPerson().listaVacinas {
                if vacina.grupo == .Idoso{
                    listaVacina.append(vacina)
                }
            }
        case .Gestante:
            for vacina in self.getSelectedPerson().listaVacinas {
                if vacina.grupo == .Gestante{
                    listaVacina.append(vacina)
                }
            }
        }
        return listaVacina
    }
    
    func getPorcentagemVacinas() -> Float{
        var sizeTomadas: Float = 0.0
        var result: Float
        var tamanhoListas: Int
        
        switch self.getSelectedPerson().grupo {
        case .Crianca:
            for status in self.getVacinaGrupo(grupo: .Crianca) {
                if status.status {
                    sizeTomadas = sizeTomadas + 1.0
                }
            }
            tamanhoListas = self.getVacinaGrupo(grupo: .Crianca).count
        case .Adolescente:
            for status in self.getVacinaGrupo(grupo: .Adolescente) {
                if status.status {
                    sizeTomadas = sizeTomadas + 1.0
                }
            }
            tamanhoListas = self.getVacinaGrupo(grupo: .Adolescente).count
        case .Adulto:
            for status in self.getVacinaGrupo(grupo: .Adulto) {
                if status.status {
                    sizeTomadas = sizeTomadas + 1.0
                }
            }
            tamanhoListas = self.getVacinaGrupo(grupo: .Adulto).count
        case .Idoso:
            for status in self.getVacinaGrupo(grupo: .Idoso) {
                if status.status {
                    sizeTomadas = sizeTomadas + 1.0
                }
            }
            tamanhoListas = self.getVacinaGrupo(grupo: .Idoso).count
        case .Gestante:
            for status in self.getVacinaGrupo(grupo: .Gestante) {
                if status.status {
                    sizeTomadas = sizeTomadas + 1.0
                }
            }
            tamanhoListas = self.getVacinaGrupo(grupo: .Gestante).count
        }
        if sizeTomadas != 0{
            result = sizeTomadas/Float(tamanhoListas)
        } else {
            result = 0.0
        }
        
        return result
    }
    
    func getStatusBarProgress() -> Float {
        return self.getPorcentagemVacinas()
    }
    
    func getStatusBarLabel() -> String {
        return String(format: "%.0f", (self.getPorcentagemVacinas()*100)) + "%"
    }
    
}
