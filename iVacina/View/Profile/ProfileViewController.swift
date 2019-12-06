//
//  ProfileViewController.swift
//  iVacina
//
//  Created by Bruna Ferreira on 23/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var imagem: UIImageView!
    @IBOutlet private weak var nomeTextField: UITextField!
    @IBOutlet private weak var profileTableView: UITableView!
    
    var profileController: ProfileController = ProfileController()
    
    var selectedUser: Person?
    
    //Carrega grupo Adulto por padrao
    var group: Grupo = .Adulto
    
    override func viewDidLoad() {
        
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
        
        print("Clicou no botao")
//        let tempUser: Person = Person(nome: "Alan Silva", email: "abs10@globomail.com", imagem: "palmeiras", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: true, doadorOrgaos: true, pcd: false, vacinasCrianca: [[.DTP : true]], vacinasAdolescente: [[ .Hepatite_B : true]], vacinasAdulto: [[ vacinasAdultoEnum.Dupla_Adulto_DT : false, .Gripe : true, .Meningite_BACWY : true, .Hepatite_B : true]], vacinasIdoso: [[ .Hepatite_B : true]], vacinasGestante: [[ vacinasGestanteEnum.dTpa : true]], dependentes: ["Davi de Franca"])
        
//        saveInfo(field: tempUser)
        
    }
    
    func saveInfo(field: Person){
        
        //aponta par o banco de dados
        let context = Database.database().reference()
        
        //fields
        let nome = "Alan Teste"
        let email = "abs101010@gmail.com"//self.selectedUser?.email
        let imagem = "palmeiras"//UIImage(named: "palmeiras")
        let grupo = "adulto"//self.group
        let tipoSanguineo = field.nome
        let hipertenso = field.hipertenso
        let diabetico = field.diabetico
        let doadorOrgaos = field.doadorOrgaos
        let pcd = field.pcd
        
        //        vacinasCrianca: [[ .gripe : true, .caxumba : false ]],
        //        vacinasAdolescente: [[ .gripe : true]],
        //        vacinasAdulto: [[ .duplaAdultoDT : false, .gripe : true, .meningiteBACWY : true, .hpv : true, .pneumonia : true, .herpesZoster : true, .febreAmarela : false, .hepatiteB : true, .tripliceViral : false, .hepatiteA : true, .varicela : false]],
        //        vacinasIdoso: [[ .gripe : true]],
        //        vacinasGestante: [[ .gripe : true]],
        //        dependentes: ["Davi de Franca"])
        
        let postObject:[String : Any] = ["name" : nome,
                                         "email" : email,
                                         "imagem" : imagem,
                                         "grupo" : grupo,
                                         "tipoSanguineo" : tipoSanguineo,
                                         "hipertenso" : hipertenso,
                                         "diabetico" : diabetico,
                                         "doadorOrgaos" : doadorOrgaos,
                                         "pcd" : pcd]
        
        
        let formattedEmail = (email.replacingOccurrences(of: ".", with: ","))
        print("salvando os dados")
        
        context.child("user/profile").child(formattedEmail).setValue(postObject) { (error, context) in
            
            if error == nil {
                print("Foi com sucesso")
                //self.alertOk()
            }else{
                print("Deu erro: \(error)")
            }
            
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
                cell.cellTitle.text = "Grupo"
                
                return cell
                
            }
            if indexPath.row == 1 {
                
                let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
                cell.cellTitle.text = "Tipo Sanguíneo "
                
                return cell
                
            }
            
            if indexPath.row == 2 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.vacinaLabel.text = "Hipertenso(a)"
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 3 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.vacinaLabel.text = "Diabético(a)"
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 4 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.vacinaLabel.text = "Doador de órgãos"
                
                return cell ?? UITableViewCell()
                
            }
            
            if indexPath.row == 5 {
                
                let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
                cell?.vacinaLabel.text = "PCD"
                
                return cell ?? UITableViewCell()
                
            }
            
            
            
        case 1:
            
            let cell: CadastroVacinaCustomCell? = tableView.dequeueReusableCell(withIdentifier: "cadastroVacinaCustomCell", for: indexPath) as? CadastroVacinaCustomCell
            cell?.setupCell(grupo: group, indexPath: indexPath)
            
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
