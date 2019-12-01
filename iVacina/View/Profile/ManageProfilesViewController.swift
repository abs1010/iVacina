//
//  ManageProfilesViewController.swift
//  iVacina
//
//  Created by Alan Silva on 25/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ManageProfilesViewController: UIViewController {
    
    enum tipoVacina {
        case duplaAdultoDT
        case gripe
        case meningiteBACWY
        case hpv
        case pneumonia
        case herpesZoster
        case febreAmarela
        case hepatiteB
        case tripliceViral
        case hepatiteA
        case varicela
    }
   
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagControl: UIPageControl!
    
    
    
    @IBOutlet weak var btnTrocarSenha: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
    
        self.btnTrocarSenha.formatarBotao()
        self.btnTrocarSenha.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedChangePass(_ sender: UIButton) {
        
        //Chamar metodo do Firebase
        
        
    }
    
    
    @IBAction func tappedAddDependent(_ sender: UIButton) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
               
               self.present(vc, animated: true, completion: nil)
               
           }

    }
    

}
