//
//  EsqueceuSenhaController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 07/12/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol EsqueceuSenhaControllerDelegate: class {
    func resetPasswordSucess()
    func resetPasswordFail(error: Error?)
}

class EsqueceuSenhaController {
    
    weak var delegate: EsqueceuSenhaControllerDelegate?
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                self.delegate?.resetPasswordSucess()
            } else {
                self.delegate?.resetPasswordFail(error: error)
                print(error?.localizedDescription ?? "Erro ao resetar senha")
            }
        }
    }
}
