//
//  CadastroController.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol CadastroControllerDelegate: class {
    func sucessCreateUser()
    func failCreateUser(error: Error?)
}

class CadastroController {
    
    weak var delegate: CadastroControllerDelegate?
    
    func createUserWithFirebase(nome: String, email: String, senha: String) {
        
        Auth.auth().createUser(withEmail: email, password: senha) { (authResult, error) in
            if error == nil {
                self.registrarUsuario(nome: nome, email: email, senha: senha)
            } else {
                self.delegate?.failCreateUser(error: error)
            }
        }
    }
    
    func registrarUsuario(nome: String, email: String, senha: String){
        
        let context = Database.database().reference()
        
        let postObject = ["nome": nome, "email": email, "senha": senha]
        
        let formattedEmail = email.replacingOccurrences(of: ".", with: ",")
        
        context.child("user/profile").child(formattedEmail).setValue(postObject) { (error, context) in
            if error == nil {
                self.delegate?.sucessCreateUser()
            } else {
                if let error = error {
                    print("Erro ao criar referencia do usuário no Firebase: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func isLoggedIn(value: Bool){
        UserDefaults.standard.setLoggedInState(value: value)
    }
}
