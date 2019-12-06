//
//  ViewController.swift
//  Home
//
//  Created by Bruna Ferreira on 18/10/19.
//  Copyright © 2019 Bruna Ferreira. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate : class {
    func getUserInfo() -> String
}

class HomeViewController: UIViewController {
    
    weak var delegate : HomeViewControllerDelegate?

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var porcentagemLabel: UILabel!
    @IBOutlet weak var barraStatus: UIProgressView!
    
    var homeController: HomeController?// = HomeController()
    var loggedEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.homeController == nil {
           self.homeController = HomeController()
        }
        self.statusLabel.text = self.delegate?.getUserInfo()
        // Do any additional setup after loading the view.
        
//        self.homeCollectionView.dataSource = self
//        self.homeCollectionView.delegate = self
//        self.homeTableView.dataSource = self
//        self.homeTableView.delegate = self
        
        self.homeTableView.register(UINib(nibName: "StatusCustomCell", bundle: nil), forCellReuseIdentifier: "statusCell")
        self.homeTableView.register(UINib(nibName: "DadosMedicoTableViewCell", bundle: nil), forCellReuseIdentifier: "dadosMedicoCell")
        
        view.setGradientBackground(colorOne: Colors.azulEscuroCustom, colorTwo: Colors.azulClaroCustom)
        
        self.calendarLabel.text = self.getDate()
        
//        self.homeController?.carregarPessoas()
        self.homeController?.loadPerson()
    }
    
    @IBAction func editarAcao(_ sender: UIButton) {
//        self.configureProfile()
        self.tabBarController?.selectedIndex = 3
    }
    
    func configureProfile() {
        if let vc = self.tabBarController?.viewControllers?[3] as? ProfileViewController {
            vc.profileController.setPessoa(pessoa: self.homeController.pessoa)
        }
        
        self.barraStatus.setProgress(self.homeController.getStatusBarProgress(), animated: false)
        self.porcentagemLabel.text = self.homeController.getStatusBarLabel()
        
    }
    
    func getDate() -> String {
        let currentDateTime = Date()

        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long

        return formatter.string(from: currentDateTime)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.homeController?.getTamanhoListaPessoa() ?? 0
        return self.homeController?.getPersonNumberOfItemsInSection() ?? 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: PessoaCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "pessoaItem", for: indexPath) as? PessoaCollectionViewCell
        item?.setPessoa(pessoa: (self.homeController?.getPessoaSelecionada(index: indexPath.row))!)
//        item?.setPessoa(pessoa: self.homeController?.getSelectedPerson(index: indexPath.row))
        return item ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeController?.setPessoa(index: indexPath.row)
        let item = collectionView.cellForItem(at: indexPath)
        item?.backgroundColor = Colors.azulClaroCustom
        self.configureProfile()
        self.homeTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath)
        item?.backgroundColor = UIColor.clear
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return self.homeController?.getVaccineNumberOfRowsInSection(grupo: .Crianca) ?? 0
            case 1:
                return self.homeController?.getVaccineNumberOfRowsInSection(grupo: .Adolescente) ?? 0
            case 2:
                return self.homeController?.getVaccineNumberOfRowsInSection(grupo: .Adulto) ?? 0
            case 3:
                return self.homeController?.getVaccineNumberOfRowsInSection(grupo: .Idoso) ?? 0
            default:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatusCustomCell? = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as? StatusCustomCell
        switch indexPath.section {
        case 0:
//            cell?.setStatusVacina(vacina: self.homeController?.pessoa?.listaVacina[indexPath.row])
            cell?.setUpCell(vacina: self.homeController?.getListCrianca()[indexPath.row])
            return cell ?? UITableViewCell()
        case 1:
//            cell?.setStatusVacina(vacina: self.homeController?.pessoa?.listaProximaVacina[indexPath.row])
            cell?.setUpCell(vacina: self.homeController?.getListAdolescente()[indexPath.row])
            return cell ?? UITableViewCell()
        case 2:
            cell?.setUpCell(vacina: self.homeController?.getListAdulto()[indexPath.row])
            return cell ?? UITableViewCell()
        case 3:
            cell?.setUpCell(vacina: self.homeController?.getListIdoso()[indexPath.row])
            return cell ?? UITableViewCell()
        default:
            let cell: DadosMedicoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "dadosMedicoCell", for: indexPath) as? DadosMedicoTableViewCell
            cell?.setCell(pessoa: self.homeController?.pessoa)
            cell?.isUserInteractionEnabled = false
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Vacinas Criança"
        case 1:
           return "Vacinas Adolescente"
        case 2:
            return "Vacinas Adulto"
        case 3:
            return "Vacinas Idoso"
        default:
            return "Dados médico"
        }
    }
    
}
