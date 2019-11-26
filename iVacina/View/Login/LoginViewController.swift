//
//  LoginViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var botaoEntrar: UIButton!
    @IBOutlet weak var botaoCriarConta: UIButton!
    @IBOutlet weak var botaoFacebook: UIButton!
    
    var imagem: UIImage? = UIImage(named: "fb-login-button-pt")
    
    //Colocar a Status Bar em branco
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.botaoCriarConta.setGradientToButton(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        
        self.botaoEntrar.backgroundColor = Colors.green
        self.botaoFacebook.setImage(imagem, for: .normal)
        
        self.botaoCriarConta.formatarBotao()
        self.botaoEntrar.formatarBotao()
        self.emailTextField.formatarTextField()
        self.senhaTextField.formatarTextField()
        
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        
    }
    
    
    @IBAction func clicouCriarConta(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        
        guard let vc: CadastroViewController = storyboard.instantiateViewController(withIdentifier: "CadastroViewController") as? CadastroViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func clicouEntrar(_ sender: UIButton) {
        
        if let email = emailTextField.text, let senha = senhaTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: senha) { (authResult, error) in
                if error == nil {
                    self.goToHome()
                } else {
                    Alert().showAlert(title: "Erro", message: error?.localizedDescription, vc: self)
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            senhaTextField.becomeFirstResponder()
        case senhaTextField:
            senhaTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
}
