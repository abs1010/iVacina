//
//  GruposViewController.swift
//  iVacina
//
//  Created by Alan Silva on 30/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

protocol nameGruposViewControllerDelegate {
    func selectedGroup (grupo: Grupo?)
}

class GruposViewController: UIViewController {

    @IBOutlet weak var grupoTableView: UITableView!

    var delegate: nameGruposViewControllerDelegate!
    
    var controller : ProfileController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller = ProfileController()
        self.grupoTableView.delegate = self
        self.grupoTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension GruposViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.getNumberOfRowsInSectionForGroup() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.controller?.getIndexOfGroup(indexPath: indexPath)
        cell.detailTextLabel?.text = "Grupo"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.delegate.selectedGroup(grupo: .Crianca)
            print("Grupo selecionado: \(Grupo.Crianca)")
        case 1:
            self.delegate.selectedGroup(grupo: .Adolescente)
            print("Grupo selecionado: \(Grupo.Adolescente)")
        case 2:
            self.delegate.selectedGroup(grupo: .Adulto)
            print("Grupo selecionado: \(Grupo.Adulto)")
        case 3:
            self.delegate.selectedGroup(grupo: .Idoso)
            print("Grupo selecionado: \(Grupo.Idoso)")
        case 4:
            self.delegate.selectedGroup(grupo: .Gestante)
            print("Grupo selecionado: \(Grupo.Gestante)")
        default:
            break
        }
        
        self.dismiss(animated: true) {
            
            print("Clicou na \(indexPath.row) linha")
            
            //PRECISA LIMPAR A TABLEVIEW COM AS MARCACOES DOS SWITCH
            
        }
        
    }
    
    
}
