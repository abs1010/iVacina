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
        //remover - temporario
        let dependente1: Dependente = Dependente(nome: "Davi Silva", imagem: "davi.jpg", grupo: .Crianca, tipoSanguineo: .B_, hipertenso: false, diabetico: true, doadorOrgaos: true, pcd: false, vacinasCrianca: [[.DTP : true]], vacinasAdolescente: [[ .Hepatite_B : true]], vacinasAdulto: [[ vacinasAdultoEnum.Dupla_Adulto_DT : false, .Gripe : true, .Meningite_BACWY : true, .Hepatite_B : true]], vacinasIdoso: [[ .Hepatite_B : false]], vacinasGestante: [[ vacinasGestanteEnum.dTpa : false]])
         let dependente2: Dependente = Dependente(nome: "Davi Silva", imagem: "davi.jpg", grupo: .Crianca, tipoSanguineo: .B_, hipertenso: false, diabetico: true, doadorOrgaos: true, pcd: false, vacinasCrianca: [[.DTP : true]], vacinasAdolescente: [[ .Hepatite_B : true]], vacinasAdulto: [[ vacinasAdultoEnum.Dupla_Adulto_DT : false, .Gripe : true, .Meningite_BACWY : true, .Hepatite_B : true]], vacinasIdoso: [[ .Hepatite_B : false]], vacinasGestante: [[ vacinasGestanteEnum.dTpa : false]])

        let tempUser: Person = Person(nome: "Alan Silva", email: "abs10@globomail.com", imagem: "alan.jpg", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: true, doadorOrgaos: true, pcd: false,
            vacinasCrianca: [[ .BCG : true,
                               .Hepatite_B : false,
                               .Penta_1_Dose : true,
                               .Poliomielite_1_Dose : false,
                               .Poliomielite_2_Dose : true,
                               .Poliomielite_3_Dose : false,
                               .Pneumococica_10 : true,
                               .Rotavirus_Humano_1_Dose : false,
                               .Meningococica_C : true,
                               .Penta_2_Dose : false,
                               .Pneumococica_10_Valente : true,
                               .Rotavirus_Humano_2_Dose : false,
                               .Febre_Amarela : true,
                               .Triplice_Viral : false,
                               .Pneumococica_Reforco : true,
                               .Meningococica_Reforco : false,
                               .Hepatite_A : true,
                               .Tetra_Viral : false,
                               .DTP : true,
                               .Varicela : false]],
            vacinasAdolescente: [[ .HPV_1_Dose : true,
                                   .HPV_2_Dose : true,
                                   .Meningococica_C : true,
                                   .Hepatite_B : true,
                                   .Febre_Amarela_1_Dose : true,
                                   .Dupla_Adulto_DT : true,
                                   .Triplice_Viral : true,
                                   .Pneumococica_23_Valente : true]],
            vacinasAdulto: [[.Dupla_Adulto_DT : true,
                             .Gripe : true,
                             .Meningite_BACWY : true,
                             .Hpv : true,
                             .Pneumonia : true,
                             .Herpes_Zoster : true,
                             .Febre_Amarela : true,
                             .Hepatite_B : true,
                             .Triplice_Viral : true,
                             .Hepatite_A : true,
                             .Varicela : true]],
            vacinasIdoso: [[ .Hepatite_B : true,
                             .Febre_Amarela : true,
                             .Dupla_Adulto_DT : true,
                             .Pneumococica_23_Valente : true,
                             .Gripe_Anual : true]],
            vacinasGestante: [[.Hepatite_B : true,
                               .Dupla_Adulto_DT : true,
                               .dTpa : true,
                               .Influenza : true]],
            dependentes: [dependente1, dependente2])

        //Calling the saving method
        self.profileController.saveInfo(person: tempUser)
        
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
