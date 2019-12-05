//
//  ManageProfilesViewController.swift
//  iVacina
//
//  Created by Alan Silva on 25/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseAuth

class ManageProfilesViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagControl: UIPageControl!
    @IBOutlet weak var logOut: UIButton!
    
    let uid = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //temp
        self.nameTextField.text = self.uid?.displayName
        self.emailTextField.text = self.uid?.email
        //
        
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.logOut.formatarBotao()
        self.logOut.backgroundColor = UIColor.green
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    
    @IBAction func tappedLogOut(_ sender: UIButton) {
        
        //Chamar metodo do Firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        
        guard let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
        
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


