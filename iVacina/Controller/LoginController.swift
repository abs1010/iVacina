//
//  LoginController.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginControllerDelegate: class {
    func loginSucess(email: String)
    func loginFail(error: Error?)
}

class LoginController {
    
    weak var delegate: LoginControllerDelegate?
    
    func loginWithFirebase(email: String, senha: String){
        
        Auth.auth().signIn(withEmail: email, password: senha) { (authResult, error) in
            if error == nil {
                self.delegate?.loginSucess(email: email)
                
            } else {
                self.delegate?.loginFail(error: error)
            }
        }
    }
    
    func isLoggedIn(value: Bool){
        UserDefaults.standard.setLoggedInState(value: value)
    }
    
}
