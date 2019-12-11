//
//  CadastroViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit


class CadastroViewController: BaseViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var senha2TextField: UITextField!
    @IBOutlet weak var botaoCriarConta: UIButton!
    @IBOutlet weak var botaoMostrarSenha: UIButton!
    
    private var cadastroController: CadastroController?
    
    //Colocar a Status Bar em branco
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cadastroController == nil {
            cadastroController = CadastroController()
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.nomeTextField.delegate = self
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        self.senha2TextField.delegate = self
        
        self.senhaTextField.isSecureTextEntry = true
        self.senha2TextField.isSecureTextEntry = true
        self.botaoMostrarSenha.setImage(UIImage(systemName: "eye"), for: .normal)
        
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.botaoCriarConta.setGradientToButton(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        
        self.nomeTextField.formatarTextField()
        self.emailTextField.formatarTextField()
        self.senhaTextField.formatarTextField()
        self.senha2TextField.formatarTextField()
        self.botaoCriarConta.formatarBotao()
        
        self.emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func clicouCriarConta(_ sender: UIButton) {
        
        self.showLoading()
        
        if let nome = nomeTextField.text,
            let email = emailTextField.text,
            let senha = senhaTextField.text,
            let senha2 = senha2TextField.text {
            
            if senha == senha2 {
                self.cadastroController?.delegate = self
                self.cadastroController?.createUserWithFirebase(nome: nome, email: email, senha: senha)
            } else {
                Alert().showAlert(title: "Erro", message: "Verificar senha: os valores informados não são iguais", vc: self)
            }
        }
    }
    
    @IBAction func clicouCancelar(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clicouMostrarSenha(_ sender: UIButton) {
        switch senhaTextField.isSecureTextEntry {
        case true:
            self.senhaTextField.isSecureTextEntry = false
            self.senha2TextField.isSecureTextEntry = false
            self.botaoMostrarSenha.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        case false:
            self.senhaTextField.isSecureTextEntry = true
            self.senha2TextField.isSecureTextEntry = true
            self.botaoMostrarSenha.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @objc func dismissKeyboard(){
        self.nomeTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.senhaTextField.resignFirstResponder()
        self.senha2TextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
    
        view.frame.origin.y = -30
            
        } else {
            view.frame.origin.y = 0
        }
    }
}

extension CadastroViewController: CadastroControllerDelegate{
    
    func sucessCreateUser() {
        
        cadastroController?.isLoggedIn(value: true)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        guard let vc: MainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
        self.hideLoading()
    }
    
    func failCreateUser(error: Error?) {
        
        self.hideLoading()
        Alert().showAlert(title: "Erro", message: error?.localizedDescription, vc: self)
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

