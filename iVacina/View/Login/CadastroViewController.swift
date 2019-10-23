//
//  CadastroViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var senha2TextField: UITextField!
    @IBOutlet weak var botaoCriarConta: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nomeTextField.delegate = self
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        self.senha2TextField.delegate = self
        

        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.botaoCriarConta.setGradientToBtn(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        
        self.nomeTextField.formatarTextField()
        self.emailTextField.formatarTextField()
        self.senhaTextField.formatarTextField()
        self.senha2TextField.formatarTextField()
        self.botaoCriarConta.formatarBotao()
        
        self.botaoCriarConta.isEnabled = false
    }

    
    @IBAction func clicouCancelar(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension CadastroViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nomeTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            senhaTextField.becomeFirstResponder()
        case senhaTextField:
            senha2TextField.becomeFirstResponder()
        case senha2TextField:
            senha2TextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let nome = self.nomeTextField.text, let email = self.emailTextField.text, let senha = self.senhaTextField.text, let senha2 = self.senha2TextField.text {
            if !nome.isEmpty && !email.isEmpty && !senha.isEmpty && !senha2.isEmpty {
                self.botaoCriarConta.isEnabled = true
            }
        }
    }
}
