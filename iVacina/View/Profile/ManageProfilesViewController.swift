//
//  ManageProfilesViewController.swift
//  iVacina
//
//  Created by Alan Silva on 25/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class ManageProfilesViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagControl: UIPageControl!
    
    
    
    @IBOutlet weak var btnTrocarSenha: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //temp
        self.nameTextField.text = "Bruna Marcela"
        self.emailTextField.text = "seuemail.com.br"
        //

        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.btnTrocarSenha.formatarBotao()
        self.btnTrocarSenha.backgroundColor = UIColor.green
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    
    
    @IBAction func tappedChangePass(_ sender: UIButton) {
        
        //Chamar metodo do Firebase
        
        
    }
    
    
    @IBAction func tappedAddDependent(_ sender: UIButton) {
        
      //  if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
               
      //         self.present(vc, animated: true, completion: nil)
               
    //       }

    }
    

}

extension ManageProfilesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) {
        
        return cell
        }
        else {
            
            return UICollectionViewCell()
            
        }
    }
    
    
}


