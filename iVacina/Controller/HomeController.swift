//
//  HomeController.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//  

import Foundation

class HomeController {
    
    var listaPessoa: [Pessoa]?
    var pessoa: Pessoa?
    
    private var person: Person?
    private var selectedPerson: Int?
    
//    func carregarPessoas() {
//        self.listaPessoa = [Pessoa(nome: "Bruna", listaVacina: [Vacina(nome: "Gripe", status: true), Vacina(nome: "Sarampo", status: false)],listaProximaVacina: [Vacina(nome: "Catapora", status: false)],grupo: .Adulto, imagem: "bruna")]
//        self.listaPessoa?.append(Pessoa(nome: "Leonardo", listaVacina: [Vacina(nome: "Gripe", status: true)], listaProximaVacina: [Vacina(nome: "Sarampo", status: false)],grupo: .Adulto, imagem: "leonardo"))
//        self.listaPessoa?.append(Pessoa(nome: "Bia", listaVacina: [Vacina(nome: "Sarampo", status: true)],listaProximaVacina: [Vacina(nome: "Gripe", status: false)], grupo: .Adulto, imagem: "bia"))
//        self.pessoa = self.listaPessoa?[0]
//
//    }
    
    func loadPerson() {
        
        self.person = Person(nome: "Bruna", email: "", imagem: "", grupo: .Adolescente, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false, vacinasCrianca: [:], vacinasAdolescente: [vacinasAdolescenteEnum.Dupla_Adulto_DT : false, vacinasAdolescenteEnum.Febre_Amarela_1_Dose : false, vacinasAdolescenteEnum.Hepatite_B : false, vacinasAdolescenteEnum.HPV_1_Dose : false, vacinasAdolescenteEnum.HPV_2_Dose : false,vacinasAdolescenteEnum.Meningococica_C : false] , vacinasAdulto: [:], vacinasIdoso: [:], vacinasGestante: [:], listaVacina: [], dependentes: [])
        self.selectedPerson = 0
        self.loadVaccine()
        print(person?.vacinasAdolescente[.Dupla_Adulto_DT])
    }
    
    func loadVaccine(){
        self.person?.listaVacina = []
        
        var vaccine: Vacina = Vacina(grupo: .Crianca, nome: "BCG", status: ((self.person?.vacinasCrianca[vacinasCriancaEnum.BCG] ?? false) != nil))
        self.person?.listaVacina.append(vaccine)
        vaccine = Vacina(grupo: .Crianca, nome: "DTP", status: ((self.person?.vacinasCrianca[vacinasCriancaEnum.DTP] ?? false) != nil))
        self.person?.listaVacina.append(vaccine)
        vaccine = Vacina(grupo: .Crianca, nome: "Febre Amarela", status: ((self.person?.vacinasCrianca[vacinasCriancaEnum.Febre_Amarela] ?? false) != nil))
        self.person?.listaVacina.append(vaccine)
        vaccine = Vacina(grupo: .Crianca, nome: "Febre Amarela", status: self.person?.vacinasAdolescente[.Dupla_Adulto_DT])
        self.person?.listaVacina.append(vaccine)
        
    }
    
    func loadNilPerson() -> Person {
        return Person(nome: nil, email: nil, imagem: nil, grupo: .Crianca, tipoSanguineo: .A, hipertenso: nil, diabetico: nil, doadorOrgaos: nil, pcd: nil, vacinasCrianca: [:], vacinasAdolescente: [:], vacinasAdulto: [:], vacinasIdoso: [:], vacinasGestante: [:], listaVacina: [], dependentes: [])
    }
    
    func loadNilDependente() -> Dependente {
        return Dependente(nome: nil, imagem: nil, grupo: .Crianca, tipoSanguineo: .A, hipertenso: nil, diabetico: nil, doadorOrgaos: nil, pcd: nil, vacinasCrianca: [:], vacinasAdolescente: [:], vacinasAdulto: [:], vacinasIdoso: [:], vacinasGestante: [:], listaVacina: [])
    }
    
    func setPessoa(index: Int){
        self.pessoa = self.listaPessoa?[index]
    }
    
    func setPerson(index: Int) {
        self.selectedPerson = index
    }
    
    func getTamanhoListaPessoa() -> Int {
        self.pessoa = self.listaPessoa?[0]
        return self.listaPessoa?.count ?? 0
    }
    
    func getPersonNumberOfItemsInSection() -> Int{
        return ((self.person?.dependentes.count ?? 0) + 1)
    }
        
    func getPessoaSelecionada(index: Int) -> Pessoa {
        self.pessoa = self.listaPessoa?[index]
        return self.pessoa ?? Pessoa(nome: "", listaVacina: [],listaProximaVacina: [], grupo: .Crianca, imagem: "")
    }
    
    func getSelectedPerson() -> Person {
        if let _person = self.person {
           return _person
        }
        return self.loadNilPerson()
    }
    
    func getSelectedDependentes(index: Int) -> Dependente {
        if let _dependentes = self.person?.dependentes {
            return _dependentes[index-1] ?? self.loadNilDependente()
        }
        return self.loadNilDependente()
    }
    
    func getTamanhoListaVacina() -> Int {
        return self.pessoa?.listaVacina.count ?? 0
    }
    
    func getVaccineNumberOfRowsInSection(grupo: Grupo) -> Int {
        var result: Int = 0
        switch grupo {
            case .Crianca:
//                result = 20
                result = self.getListCrianca().count
            case .Adolescente:
//                result = 8
                result = self.getListAdolescente().count
            case .Adulto:
//                result = 11
                result = self.getListAdulto().count
            case .Idoso:
//                result = 5
                result = self.getListIdoso().count
            case .Gestante:
//                result = 4
            result = 0
        }
        return result
    }
    
    func getTamanhoListaProximaVacina() -> Int {
        return self.pessoa?.listaProximaVacina.count ?? 0
    }
    
    func getPorcentagemVacinas() -> Float{
        var sizeTomadas: Float = 0.0
        var result: Float
        var tamanhoListas: Int
        
        for status in self.pessoa?.listaVacina ?? [] {
            if status.status {
                sizeTomadas = sizeTomadas + 1.0
            }
        }
        
        tamanhoListas = (self.pessoa?.listaVacina.count ?? 0) + (self.pessoa?.listaProximaVacina.count ?? 0)
        result = sizeTomadas/Float(tamanhoListas)
        
        return result
    }
    
    func getPercentsOfVaccine() -> Float {
        var vaccineTaken: Float = 0.0
        var result: Float
        var vaccineTotal: Int
        var index: Int = 0
        var listKeys: [String] = []
        
//        switch self.getSelectedPerson(index: self.selectedPerson ?? 0).grupo {
//
//            case .Crianca:
//                for _vaccine in self.getSelectedPerson(index: self.selectedPerson ?? 0).vacinasCrianca {
//                    if self.getSelectedPerson(index: self.selectedPerson ?? 0).vacinasCrianca[vacinasCriancaEnum.BCG]! ?? false {
//                        vaccineTaken = vaccineTaken + 1
//                    }
//                }
//            case .Adolescente:
//
//            case .Adulto:
//                for _vaccine in vaccine {
//
//                }
//            case .Idoso:
//                for _vaccine in vaccine {
//
//                }
//            case .Gestante:
//                for _vaccine in vaccine {
//
//                }
//        default:
//            return 0.0
//        }
        return 0.0
    }
        
        
//        for status in self.pessoa?.listaVacina ?? [] {
//            if status.status {
//                sizeTomadas = sizeTomadas + 1.0
//            }
//        }
//
//        tamanhoListas = (self.pessoa?.listaVacina.count ?? 0) + (self.pessoa?.listaProximaVacina.count ?? 0)
//        result = sizeTomadas/Float(tamanhoListas)
        
        
    
    func getStatusBarProgress() -> Float {
        return self.getPorcentagemVacinas()
    }
    
    func getStatusBarLabel() -> String {
        return String(format: "%.0f", (self.getPorcentagemVacinas()*100)) + "%"
    }
    
    func getListCrianca() -> [Vacina] {
        var list: [Vacina] = []
        for vaccine in self.person?.listaVacina ?? []{
            if let _vaccine = vaccine {
                if _vaccine.grupo == Grupo.Crianca{
                    list.append(_vaccine)
                }
            }
        }
        return list
    }
    
    func getListAdolescente() -> [Vacina] {
        var list: [Vacina] = []
        for vaccine in self.person?.listaVacina ?? []{
            if let _vaccine = vaccine {
                if _vaccine.grupo == Grupo.Adolescente{
                    list.append(_vaccine)
                }
            }
        }
        return list
    }
    
    func getListAdulto() -> [Vacina] {
        var list: [Vacina] = []
        for vaccine in self.person?.listaVacina ?? []{
            if let _vaccine = vaccine {
                if _vaccine.grupo == Grupo.Adulto{
                    list.append(_vaccine)
                }
            }
        }
        return list
    }

    func getListIdoso() -> [Vacina] {
        var list: [Vacina] = []
        for vaccine in self.person?.listaVacina ?? []{
            if let _vaccine = vaccine {
                if _vaccine.grupo == Grupo.Idoso{
                    list.append(_vaccine)
                }
            }
        }
        return list
    }
}
