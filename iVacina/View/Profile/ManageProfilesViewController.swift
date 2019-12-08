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
    
    //let uid = Auth.auth().currentUser
    var profileController: ProfileController = ProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CARREGANDO DADOS DO USUARIO LOGADO
        //self.profileController.getUserInfo()
        //self.nameTextField.text = self.profileController.pessoa?.nome
        //self.emailTextField.text = self.profileController.pessoa?.email
        
        //PERSONALIZANDO A VIEW
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height / 2
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.logOut.formatarBotao()
        self.logOut.backgroundColor = UIColor.green
        
        //ASSINANDO DELEGATE E DTSOURCE DA TABLEVIEW E TEXTFIELD
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //REGISTRANDO AS CELULAS CUSTOMIZADAS
        self.collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PersonCollectionViewCell")
        
        //GET IMAGE DO USER DEFAULTS PARA SETAR NA IMAGE VIEW
        self.getPictureFromUserDefaults()
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
    
    
    func getPictureFromUserDefaults(){
        
        let userDefaults = UserDefaults.standard
        
        if let imageData = userDefaults.data(forKey: "imagePerfil"),
           let image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage {
            
            self.photoImageView.image = image
        }
        
    }
    
}



//MARK: - EXTENSION DA COLLETION VIEW - DELEGATE AND DATASOURCE

extension ManageProfilesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profileController.getNumberOfRowsInSectionForCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell : PersonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as? PersonCollectionViewCell {
            
            //cell.setupCell(pessoa: self.profileController.getPessoa(indexPath: indexPath))
            
            return cell
        }
        else {
            
            return UICollectionViewCell()
            
        }
    }
    
    
}


