//
//  ViewController.swift
//  iVacina
//
//  Created by Alan Silva on 20/09/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Criando as Outlets
    @IBOutlet weak var botaoEntrar: UIButton!
    @IBOutlet weak var botaoCriarConta: UIButton!
    @IBOutlet weak var botaoFacebook: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    

    //Colocar a Status Bar em branco
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setar a cor na View
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.botaoCriarConta.setGradientToBtn(colorOne: Colors.azulClaroCustom, colorTwo: Colors.azulEscuroCustom)
        
        formatarBotao(botao: botaoEntrar)
        formatarBotao(botao: botaoCriarConta)
        formatarBotao(botao: botaoFacebook)
        formatarTextField(textField: emailTextField)
        formatarTextField(textField: senhaTextField)
        
        
    }
   
    
    
    func formatarBotao(botao: UIButton){
        botao.layer.cornerRadius = botao.frame.size.height/2
        botao.layer.masksToBounds = true
    }
    
    func formatarTextField(textField: UITextField){
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.layer.masksToBounds = true
        textField.backgroundColor = Colors.lightGrey
    }
}

