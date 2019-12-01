//
//  GruposViewController.swift
//  iVacina
//
//  Created by Alan Silva on 30/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class GruposViewController: UIViewController {

    @IBOutlet weak var grupoTableView: UITableView!

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
        return self.controller?.grupoArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.controller?.grupoArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true) {
            
            print("Clicou na \(indexPath.row) linha")
            
            //self.controller?.profileViewController = ProfileViewController()
            self.controller?.profileViewController?.group = .Crianca
            self.controller?.profileViewController?.profileTableView.reloadData()
        }
        
    }
    
    
}
