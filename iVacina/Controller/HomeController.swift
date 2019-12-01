//
//  HomeController.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import Foundation

protocol HomeControllerDelegate : class {
    func loggedUserToView(email: String)
}

class HomeController {

    var provider: LoginViewController?
    weak var delegate: HomeControllerDelegate?
    
    func setupController(){
        self.provider = LoginViewController()
        self.provider?.delegate = self
    }
    
    var listaPessoa: [Pessoa]?
    var pessoa: Pessoa?
    
    func carregarPessoas() {
        self.listaPessoa = [Pessoa(nome: "Bruna", listaVacina: [Vacina(nome: "Gripe", status: true), Vacina(nome: "Sarampo", status: false)],listaProximaVacina: [Vacina(nome: "Catapora", status: false)],grupo: .Adulto, imagem: "bruna")]
        self.listaPessoa?.append(Pessoa(nome: "Leonardo", listaVacina: [Vacina(nome: "Gripe", status: true)], listaProximaVacina: [Vacina(nome: "Sarampo", status: false)],grupo: .Adulto, imagem: "leonardo"))
        self.listaPessoa?.append(Pessoa(nome: "Bia", listaVacina: [Vacina(nome: "Sarampo", status: true)],listaProximaVacina: [Vacina(nome: "Gripe", status: false)], grupo: .Adulto, imagem: "bia"))
        self.pessoa = self.listaPessoa?[0]
    }
    
    func setPessoa(index: Int){
        self.pessoa = self.listaPessoa?[index]
    }
    
    func getTamanhoListaPessoa() -> Int {
        self.pessoa = self.listaPessoa?[0]
        return self.listaPessoa?.count ?? 0
    }
        
    func getPessoaSelecionada(index: Int) -> Pessoa {
        self.pessoa = self.listaPessoa?[index]
        return self.pessoa ?? Pessoa(nome: "", listaVacina: [],listaProximaVacina: [], grupo: .Crianca, imagem: "")
    }
    
    func getTamanhoListaVacina() -> Int {
        return self.pessoa?.listaVacina.count ?? 0
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
    
    func getStatusBarProgress() -> Float {
        return self.getPorcentagemVacinas()
    }
    
    func getStatusBarLabel() -> String {
        return String(format: "%.0f", (self.getPorcentagemVacinas()*100)) + "%"
    }
}

extension HomeController : LoginViewControllerDelegate {
    
    func loggedUser(email: String) {
        self.delegate?.loggedUserToView(email: email)
        print("Passou Home Controller\(email)")
    }
}
