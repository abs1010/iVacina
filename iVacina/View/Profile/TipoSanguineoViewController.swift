////
////  TipoSanguineoViewController.swift
////  iVacina
////
////  Created by Alan Silva on 30/11/19.
////  Copyright © 2019 Alan Silva. All rights reserved.
////
//
//import UIKit
//
//class TipoSanguineoViewController: UIViewController {
//
//    @IBOutlet weak var tipoSanguineoTableView: UITableView!
//        var tipoSanguineoArray : [String] = ["Criança", "Adoslecente", "Adulto", "Idoso", "Gestante"]
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            self.tipoSanguineoTableView.delegate = self
//            self.tipoSanguineoTableView.dataSource = self
//
//            // Do any additional setup after loading the view.
//        }
//
//    }
//
//    extension TipoSanguineoViewController : UITableViewDelegate, UITableViewDataSource {
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 5
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//            cell.textLabel?.text = self.grupoArray[indexPath.row]
//
//            return cell
//
//        }
//
//
//
//
//    }
