//
//  NewsViewController.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import SnapKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var listaNewsTableView: UITableView!
    
    var controller: NewsController?
    var arrayOfNews: News?
    
    
    //Colocar a Status Bar em branco
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//           return .lightContent
//       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = NewsController()
        
        self.listaNewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.listaNewsTableView.register(UINib(nibName: "News2TableViewCell", bundle: nil), forCellReuseIdentifier: "News2TableViewCell")
        
        //self.view.setGradientToView(colorOne: UIColor.azulEscuroCustom, colorTwo: UIColor.azulClaroCustom)
        
        self.controller?.getAListOfNews(completion: { (response, error) in
            
            if let _response = response {
                
                self.arrayOfNews = _response
                self.listaNewsTableView.delegate = self
                self.listaNewsTableView.dataSource = self
            }
            
        })
        
    }
    
}

extension NewsViewController : UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.arrayOfNews?.count ?? 0
        let contadorSort = Int.random(in: 2...count - 1)
        
        print(contadorSort)
        //if indexPath.row == contadorSort {
        if indexPath.row == 3 || indexPath.row == 8 {
        self.listaNewsTableView.rowHeight = 166
        let cell : News2TableViewCell = (tableView.dequeueReusableCell(withIdentifier: "News2TableViewCell", for: indexPath) as? News2TableViewCell)!
        
        return cell
            
        }
        
        else {
        //---
        self.listaNewsTableView.rowHeight = 400
        let cell : NewsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell)! //{
            
            cell.setupCell(noticia: (self.arrayOfNews?[indexPath.row])!)
            
            return cell
        //}
        
        }
        
       // return UITableViewCell()
        
    }
    
    
}


extension NewsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsOfNewsViewController") as? DetailsOfNewsViewController {
            
            vc.selectedNew = indexPath.row
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
        
    }
    
}
