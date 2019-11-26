//
//  CadastroViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        self.botaoCriarConta.setGradientToButton(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        
        self.nomeTextField.formatarTextField()
        self.emailTextField.formatarTextField()
        self.senhaTextField.formatarTextField()
        self.senha2TextField.formatarTextField()
        self.botaoCriarConta.formatarBotao()
    }
    
    
    @IBAction func clicouCriarConta(_ sender: UIButton) {
        if let email = emailTextField.text,
            let senha = senhaTextField.text,
            let senha2 = senha2TextField.text {
            
            if senha == senha2 {
                Auth.auth().createUser(withEmail: email, password: senha) { (authResult, error) in
                    if error == nil {
                        self.registrarUsuario()
                    } else {
                        Alert().showAlert(title: "Erro", message: error?.localizedDescription , vc: self)
                    }
                }
                
            } else {
                Alert().showAlert(title: "Erro", message: "Verificar senha: os valores informados não são iguais", vc: self)
            }
        }
        
    }
    
    
    @IBAction func clicouCancelar(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func registrarUsuario(){
        let nome = nomeTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let senha = senhaTextField.text ?? ""
            
            let context = Database.database().reference()
            
            let postObject = ["nome": nome, "email": email, "senha": senha]
            
            let formattedEmail = email.replacingOccurrences(of: ".", with: ",")
            
            context.child("user/profile").child(formattedEmail).setValue(postObject) { (error, context) in
                if error == nil {
                    self.goToHome()
                    print("Passei por aqui ")
                } else {
                    if let error = error {
                    print("Erro ao criar referencia do usuário no Firebase: \(error.localizedDescription)")
                    }
                }
            }
        
    }
    
    func goToHome() {
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        
        guard let vc: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
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
    
}
