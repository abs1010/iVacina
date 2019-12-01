//
//  TipoSanguineoViewController.swift
//  iVacina
//
//  Created by Alan Silva on 30/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

protocol TipoSanguineoViewControllerDelegate {
    func selectedTipoSanguineo (tipoSanguineo: TipoSanguineo)
}

class TipoSanguineoViewController: UIViewController {
    
    @IBOutlet weak var tipoSanguineoTableView: UITableView!
    
    var delegate: TipoSanguineoViewControllerDelegate!
    
    var controller : ProfileController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller = ProfileController()
        self.tipoSanguineoTableView.delegate = self
        self.tipoSanguineoTableView.dataSource = self
        
    }
    
}

//MARK: - EXTENSION OF TABLE VIEW (DELEGATE AND DATASOURCE)

extension TipoSanguineoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.controller?.tipoSanguineoArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .A_)
            print("Sangue selecionado: \(TipoSanguineo.A_)")
        case 1:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .B_)
            print("Sangue selecionado: \(TipoSanguineo.B_)")
        case 2:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .O_)
            print("Sangue selecionado: \(TipoSanguineo.O_)")
        case 3:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .A)
            print("Sangue selecionado: \(TipoSanguineo.A)")
        case 4:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .B)
            print("Sangue selecionado: \(TipoSanguineo.B)")
        case 5:
            self.delegate.selectedTipoSanguineo(tipoSanguineo: .O)
            print("Sangue selecionado: \(TipoSanguineo.O)")
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
