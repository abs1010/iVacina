//
//  ManageProfilesViewController.swift
//  iVacina
//
//  Created by Alan Silva on 25/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ManageProfilesViewController: BaseViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagControl: UIPageControl!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    //let uid = Auth.auth().currentUser
    private var uid : User?
    var profileController: ProfileController = ProfileController()
    var titular: Titular?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileController.setupController()
        self.profileController.delegate = self
        self.titular = self.profileController.loadCurrentTitular()
        
        //CARREGANDO DADOS DO USUARIO LOGADO
        self.uid = Auth.auth().currentUser
        self.emailTextField.text = self.uid?.email
        
        //PERSONALIZANDO A VIEW
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height / 2
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.nameTextField.formatarTextField()
        self.emailTextField.formatarTextField()
        self.logOut.formatarBotao()
        self.logOut.backgroundColor = Colors.green
        self.pagControl.numberOfPages = self.profileController.getNumberOfRowsInSectionForCells()
        self.plusButton.setGradientToButton(colorOne: .azulClaroCustom, colorTwo: .azulEscuroCustom)
        self.plusButton.formatarBotao()
        self.plusButton.titleLabel?.textAlignment = .center
        self.plusButton.contentHorizontalAlignment = .center
        self.plusButton.contentVerticalAlignment = .center
        self.plusButton.pulse()
        
        //ASSINANDO DELEGATE E DTSOURCE DA TABLEVIEW E TEXTFIELD
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //REGISTRANDO AS CELULAS CUSTOMIZADAS
        self.collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PersonCollectionViewCell")
        
        //GET IMAGE DO USER DEFAULTS PARA SETAR NA IMAGE VIEW
        self.getPictureFromUserDefaults()
        self.nameTextField.text = self.titular?.nome
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getPictureFromUserDefaults()
        self.plusButton.pulse()
        
        print("Voltou p a profile")
    }
    
    @IBAction func tappedLogOut(_ sender: UIButton) {
        
        //Chamar metodo do Firebase de logout
        self.profileController.isLoggedIn(value: false)
        
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        
        guard let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnPlusButton(_ sender: Any) {
        performSegue(withIdentifier: "VisualizarViewProfile", sender: nil)
    }
    
    func getPictureFromUserDefaults(){
        
        let userDefaults = UserDefaults.standard
        
        if let imageData = userDefaults.data(forKey: self.uid?.email ?? ""),
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
            
            cell.setupCell(pessoa: self.titular ?? self.profileController.loadCurrentTitular(), indexPath: indexPath)
            
            return cell
        }
        else {
            
            return UICollectionViewCell()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigation: NavigationViewController = segue.destination as? NavigationViewController {
            if segue.identifier == "VisualizarViewProfile"{
                if let vc: ProfileViewController = navigation.viewControllers.first as? ProfileViewController {
                    vc.titular = self.titular
                }
            } else {
                if let vc = navigation.viewControllers.first as? ProfileViewController {
                    vc.titular = self.titular
                }
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            print("Clicou em \(indexPath.row)")
            
            if let vc: ProfileViewController = storyboard?.instantiateInitialViewController() as? ProfileViewController {
    
                vc.nomeTextField.text = self.titular?.nome

                
            }
            
            performSegue(withIdentifier: "editProfile", sender: self.titular)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pagControl.currentPage = indexPath.row
    }
    
}

//MARK: - DELEGATE  

extension ManageProfilesViewController : ProfileControllerDelegate {
    
    func successOnLoadingProfileController(titular: Titular?) {
        self.titular = titular
        self.nameTextField.text = titular?.nome
        self.collectionView.reloadData()
        print("Passei pela extension de ProfileViewController")
    }
    
    func errorOnLoadingProfileController(error: Error?) {
        print(error?.localizedDescription ?? "")
        print("DEU MERDA!!! Mas passei pela extension de ProfileViewController")
        
    }
    
    
}


