//
//  ProfileViewController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var imagem: UIImageView!
    @IBOutlet private weak var nomeTextField: UITextField!
    @IBOutlet private weak var profileTableView: UITableView!
    
    var profileController: ProfileController = ProfileController()
    var manager: ManageProfilesViewController = ManageProfilesViewController()
    //Carrega grupo Adulto por padrao e busca user logado
    var titular: Titular?
    var dependente: Pessoa?
    var group: Grupo = .Adulto
    var bloodType : TipoSanguineo?
    var saveInfo : ProfileProvider = ProfileProvider()
    //let uid = Auth.auth().currentUser
    private var uid : User?
    
    override func viewDidLoad() {
        
        self.uid = Auth.auth().currentUser
        
        //PERSONALIZACAO DA VIEW
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.imagem.image = UIImage(named: "loading")
        self.imagem.layer.cornerRadius = self.imagem.frame.size.height / 2
        self.nomeTextField.becomeFirstResponder()
        
        //ASSINANDO DELEGATE E DTSOURCE DA TABLEVIEW E TEXTFIELD
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.nomeTextField.delegate = self
        
        //REGISTRANDO AS CELULAS CUSTOMIZADAS
        self.profileTableView.register(UINib(nibName: "CadastroVacinaCustomCell", bundle: nil), forCellReuseIdentifier: "cadastroVacinaCustomCell")
        self.profileTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        
    }
    
    //MARK: - GET ACCESS TO CAMERA AND PHOTO LIBRARY
    
    @IBAction func openCameraOrLibrary(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Adicionar foto", message: "Selecione uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.getImage(fromSourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - BUTTONS DA NAVIGATION
    
    @IBAction func btnVoltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSalvar(_ sender: UIBarButtonItem) {
        
        if self.nomeTextField.text == "" {
            
            let alert = UIAlertController(title: "Atencão!", message: "Informe o nome!", preferredStyle: .alert)
            
            let btnOk = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(btnOk)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if self.bloodType == nil {
            
            let alert = UIAlertController(title: "Atencão!", message: "Escolha um tipo sanguíneo.", preferredStyle: .alert)
            
            let btnOk = UIAlertAction(title: "Ok", style: .default)
            
            //            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            //            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //            blurEffectView.frame = view.bounds
            //            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //            view.addSubview(blurEffectView)
            //blurEffectView.removeFromSuperview()
            alert.addAction(btnOk)
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else {
            
            //Save the pic from the ImageView
            let userDefaults = UserDefaults.standard
            if let image = self.imagem.image {
                let imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
                userDefaults.set(imageData, forKey: self.uid?.email ?? "")
                
            }
            
            userDefaults.synchronize()
            
            //Saving name, group, blood type.
            self.saveInfo.tempUser.nome = self.nomeTextField.text
            self.saveInfo.tempUser.grupo = self.group
            self.saveInfo.tempUser.tipoSanguineo = self.bloodType ?? TipoSanguineo.A
            
            //Calling the saving method
            if manager.isUserNil() {
            //    self.profileController.saveInfo(person: self.saveInfo.tempUser)
            }
            //else{
                
            //   self.saveInfo.addDependente(dependente: self.saveInfo.tempUser)
                self.profileController.saveInfo(person: self.saveInfo.tempUser)
            //}
            
            //Mostra Aviso
            let alert = UIAlertController(title: "iVacina", message: "Dados Salvos com sucesso!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - NUMBER OF ROWS IN SECTION
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 6
        case 1:
            switch self.group {
            case .Crianca:
                return vacinasCriancaEnum.allCases.count - 1
            case .Adolescente:
                return vacinasAdolescenteEnum.allCases.count - 1
            case .Adulto:
                return vacinasAdultoEnum.allCases.count - 1
            case .Idoso:
                return vacinasIdosoEnum.allCases.count - 1
            case .Gestante:
                return vacinasGestanteEnum.allCases.count - 1
            }
            
        default:
            return 0
        }
        
    }
    
    //MARK: - CELL FOR ROW DA TABLE VIEW
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            if indexPath.row == 0 {
                
                let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
                
                cell.setupCell(indexPath: indexPath)
                
                return cell
                
            }
            if indexPath.row == 1 {
                
                let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
                
                cell.setupCell(indexPath: indexPath)
                
                return cell
                
            }
            
            if indexPath.row == 2 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                
                cell?.setupCellHeader(indexPath: indexPath)
                cell?.delegate = self
                
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 3 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.setupCellHeader(indexPath: indexPath)
                cell?.delegate = self
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 4 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.setupCellHeader(indexPath: indexPath)
                cell?.delegate = self
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 5 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.setupCellHeader(indexPath: indexPath)
                cell?.delegate = self
                
                return cell ?? UITableViewCell()
                
            }
            
        case 1:
            
            let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
            cell?.setupCell(grupo: group, indexPath: indexPath)
            cell?.delegate = self
            
            return cell ?? UITableViewCell()
            
        default:
            
            return UITableViewCell()
            
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 0:
            return "Dados Pessoais"
        case 1:
            return "Marque as vacinas que tomou"
        default:
            return ""
        }
        
    }
    
    //MARK: - DID SELECT
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Chama ViewController de Grupo
        if indexPath.row == 0 && indexPath.section == 0 {
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GruposViewController") as? GruposViewController {
                
                vc.delegate = self
                
                self.present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        //Chama ViewController de Tipo Sanguineo
        if indexPath.row == 1 && indexPath.section == 0 {
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TipoSanguineoViewController") as? TipoSanguineoViewController {
                
                vc.delegate = self
                
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        
    }
    
}

//MARK: - EXTENSION PARA PROTOCOLO DE GRUPO (GruposViewController)

extension ProfileViewController : nameGruposViewControllerDelegate {
    
    func selectedGroup(grupo: Grupo?) {
        self.group = grupo!
        self.profileTableView.reloadData()
    }
    
}

//MARK: - EXTENSION PARA PROTOCOLO DE GRUPO (GruposViewController)

extension ProfileViewController : TipoSanguineoViewControllerDelegate {
    
    func selectedTipoSanguineo(tipoSanguineo: TipoSanguineo) {
        self.bloodType = tipoSanguineo
    }
    
}

//MARK: - EXTENSION DE UITEXTFIELD
extension ProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isEqual(self.nomeTextField){
            self.nomeTextField.resignFirstResponder()
        }
        
        return true
        
    }
    
}

//MARK: - EXTENSION DA CAMERA

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.imagem.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - EXTENSION DE CADASTROVACINACUSTOMCELL

extension ProfileViewController : CadastroVacinaCustomCellDelegate {
    
    func changeOfState(state: Bool, string: String, index: IndexPath) {
        
        print("O Estado do botao é \(state) da \(string) do grupo \(self.group) e index: \(index.row) e section : \(index.section)")
        
        switch index.section {
        case 0:
            
            switch index.row {
            case 0:
                self.saveInfo.tempUser.grupo = self.group
            case 1:
                self.saveInfo.tempUser.tipoSanguineo = self.bloodType!
            case 2:
                self.saveInfo.tempUser.hipertenso = state
            case 3:
                self.saveInfo.tempUser.diabetico = state
            case 4:
                self.saveInfo.tempUser.doadorOrgaos = state
            case 5:
                self.saveInfo.tempUser.pcd = state
            default:
                print("default")
            }
            
        case 1:
            
            switch self.group {
            case .Crianca:
                self.saveInfo.tempUser.listaVacinas[index.row].status = state
            case .Adolescente:
                self.saveInfo.tempUser.listaVacinas[index.row + 20].status = state
            case .Adulto:
                self.saveInfo.tempUser.listaVacinas[index.row + 28].status = state
            case .Idoso:
                self.saveInfo.tempUser.listaVacinas[index.row + 39].status = state
            case .Gestante:
                self.saveInfo.tempUser.listaVacinas[index.row + 44].status = state
            }
            
        default:
            print("default")
            
        }
        
    }
    
}


