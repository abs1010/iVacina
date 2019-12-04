//
//  ProfileViewController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseDatabase
//let uid = Auth.auth().currentUser?.uid

protocol ProfileViewControllerDelegate {
    func setGrupo(grupo: Grupo)
}

class ProfileViewController: UIViewController {
    var delegate : ProfileViewControllerDelegate?
    var removerDepois : RemoverDepois = RemoverDepois()
    
    @IBOutlet private weak var imagem: UIImageView!
    @IBOutlet private weak var nomeTextField: UITextField!
    @IBOutlet private weak var profileTableView: UITableView!
    
    var profileController: ProfileController = ProfileController()
    
    var selectedUser: Person?
    
    //Carrega grupo Adulto por padrao
    var group: Grupo = .Adulto
    
    override func viewDidLoad() {
        self.selectedUser?.email = "temp@globo.com"
        //PERSONALIZACAO DA VIEW
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        self.imagem.image = UIImage(named: "loading")
        self.imagem.layer.cornerRadius = self.imagem.frame.size.height / 2
        
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
        //Calling the saving method
        self.profileController.saveInfo(person: self.removerDepois.getTempPerson())
        
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
        print("\(tipoSanguineo) foi selecionado hein!")
    }
    
}

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
    
    func changeOfState(state: Bool, string: String) {
        //self.selectedUser = self.removerDepois.getTempPerson()
        print("O Estado do botao é \(state) da \(string)")
        self.removerDepois.tempUser.hipertenso = state
        print(self.removerDepois.tempUser.hipertenso)
    }
    
}
