//
//  NewsViewController.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import SnapKit

class NewsViewController: BaseViewController {
    
    @IBOutlet private weak var listaNewsTableView: UITableView!
    
    var controller: NewsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading
        showLoading()
        
        //Delegate and protocols
        NewsController().loadNews()
        self.controller = NewsController()
        
        self.controller?.delegate = self
        
        self.controller?.loadNews()
        
        //table view Extension
        self.listaNewsTableView.delegate = self
        self.listaNewsTableView.dataSource = self
        
        //registering Custom Cells
        self.listaNewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.listaNewsTableView.register(UINib(nibName: "News2TableViewCell", bundle: nil), forCellReuseIdentifier: "News2TableViewCell")
        
    }
    
}

extension NewsViewController : NewsControllerDelegate {
    func successOnLoadingNewsController() {
        self.listaNewsTableView.reloadData()
        hideLoading()
    }
    
    func errorOnLoadingNewsController(error: Error?) {
        hideLoading()
    }
}


extension NewsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contadorSort = Int.random(in: 2...(self.controller?.numberOfRowsInSection() ?? 0))
        
        
        //CELL PEQUENA
        if indexPath.row == contadorSort { // 3 || indexPath.row == 8 {
            
            self.listaNewsTableView.rowHeight = 166
            let cell : News2TableViewCell = (tableView.dequeueReusableCell(withIdentifier: "News2TableViewCell", for: indexPath) as? News2TableViewCell)!
            
            cell.setupCell(noticia: (self.controller?.loadCurrentNews(indexPath: indexPath))!)
            
            return cell
            
        }
            
            //CELL NORMAL
        else {
            
            self.listaNewsTableView.rowHeight = 400
            self.listaNewsTableView.rowHeight = UITableView.automaticDimension
            let cell : NewsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell)!
            
            cell.setupCell(noticia: (self.controller?.loadCurrentNews(indexPath: indexPath))!)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsOfNewsViewController") as? DetailsOfNewsViewController {
            
            vc.selectedNew = self.controller?.loadCurrentNews(indexPath: indexPath)
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "_DetailsOfNewsViewController") as? _DetailsOfNewsViewController {
//
//                    vc.selectedNew = self.controller?.loadCurrentNews(indexPath: indexPath)
//
//                    self.present(vc, animated: true, completion: nil)
//
//                }

        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         print("fez scroll")
    }
    
    //func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

     //   print("fez scroll")

//        let activityView = UIActivityIndicatorView(style: .gray)
//        activityView.center = self.view.center
//
//        activityView.center = CGPoint(x: 100, y: 20)
//
//        self.view.addSubview(activityView)
//        activityView.startAnimating()
//
//
//        self.controller?.loadNews()
//        self.listaNewsTableView.reloadData()
//        //sleep(2)
//        //activityView.stopAnimating()
//
 //   }
    
}
