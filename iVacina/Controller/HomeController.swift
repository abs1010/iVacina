//
//  HomeController.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//  

import Foundation

protocol HomeControllerDelegate: class {
    func successOnLoadingHomeController()
    func errorOnLoadingHomeController(error: Error?)
}

class HomeController {
    
    private var titular: Titular?
    private var selectedPerson: Int?
    weak var delegate: HomeControllerDelegate?
    var homeProvider: HomeDataProvider?
    
    func loadPerson() {
        self.homeProvider = HomeDataProvider()
        self.homeProvider?.delegate = self
        self.selectedPerson = 0
        self.homeProvider?.loadPersonFromFirebase()
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
            result = getVacinaGrupo(grupo: .Crianca).count
        case .Adolescente:
            result = getVacinaGrupo(grupo: .Adolescente).count
        case .Adulto:
            result = getVacinaGrupo(grupo: .Adulto).count
        case .Idoso:
            result = getVacinaGrupo(grupo: .Idoso).count
        case .Gestante:
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

extension HomeController: HomeProviderProtocol {
    func successOnLoadingHomeProvider(titular: Titular?) {
        self.titular = titular
        self.delegate?.successOnLoadingHomeController()
    }
    
    func errorOnLoadingHomeProvider(error: Error?) {
        self.delegate?.errorOnLoadingHomeController(error: error)
    }
}
