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
    var grupoArray : [String] = ["Criança", "Adoslecente", "Adulto", "Idoso", "Gestante"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.grupoTableView.delegate = self
        self.grupoTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension GruposViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.grupoArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    
}
