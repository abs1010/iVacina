//
//  EsqueceuSenhaViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import Foundation

class EsqueceuSenhaViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var enviarBtn: UIButton!
    
    private var esqueceuSenhaController: EsqueceuSenhaController?
    
    //Colocar a Status Bar em branco
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if esqueceuSenhaController == nil {
            esqueceuSenhaController = EsqueceuSenhaController()
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.enviarBtn.setGradientToButton(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        self.enviarBtn.formatarBotao()
        self.emailTxt.formatarTextField()
        
        self.emailTxt.keyboardType = UIKeyboardType.emailAddress
    }
    
    @IBAction func clicouEnviar(_ sender: Any) {
        
        if let email = emailTxt.text {
            esqueceuSenhaController?.resetPassword(email: email)
        }
        self.esqueceuSenhaController?.delegate = self
    }
    
    
    @IBAction func clicouCancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        self.emailTxt.resignFirstResponder()
    }
}

extension EsqueceuSenhaViewController: EsqueceuSenhaControllerDelegate {
    func resetPasswordSucess() {
        self.view.endEditing(true)
        Alert().showAlert(title: "Sucesso", message: "Um email foi enviado para que você possa recuperar sua senha", vc: self)
    }
    
    func resetPasswordFail(error: Error?) {
        self.view.endEditing(true)
        Alert().showAlert(title: "Erro", message: error?.localizedDescription, vc: self)
    }
}
