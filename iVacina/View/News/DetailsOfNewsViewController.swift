//
//  DetailsOfNewsViewController.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsOfNewsViewController: UIViewController {
    
    @IBOutlet private weak var imagem: UIImageView!
    @IBOutlet private weak var source: UILabel!
    @IBOutlet private weak var timeToRead: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var btnsource: UIButton!
    @IBOutlet private weak var NewsTableView: UITableView!
    
    var selectedNew : NewsElement?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupCell()
        
        
        //registering Custom Cells
//        self.NewsTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.NewsTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        self.NewsTableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        
        self.NewsTableView.delegate = self
        self.NewsTableView.dataSource = self
        
    }
    
    @IBAction func btnGotoSource(_ sender: UIButton) {
        
        let alerta : UIAlertController = UIAlertController(title: "Aviso", message: "Você será direcionado para \(String(describing: self.selectedNew?.source?.name ?? "")), deseja continuar?", preferredStyle: .alert)
        
        let alertaCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        let alertaContinue = UIAlertAction(title: "Ok", style: .default) { (UIAlertActionContinue) in
            
            if let url = URL(string: self.selectedNew?.url ?? "") {
                UIApplication.shared.open(url)
            }
            
        }
        
        alerta.addAction(alertaCancel)
        alerta.addAction(alertaContinue)
        
        self.present(alerta, animated: true, completion: nil)
        
    }
    
    func setupCell(){
        
        self.titleLabel.text = self.selectedNew?.title
//        self.descriptionLabel.text = self.selectedNew?.articleDescription ?? ""
        self.timeToRead.text = "1 min"
        self.source.text = self.selectedNew?.source?.name ?? ""
//        self.contentLabel.text = self.selectedNew?.content ?? ""
        
        if let urlString = self.selectedNew?.urlToImage {
            print(urlString)
            self.imagem.af_setImage(withURL: URL(string: urlString)!,
                                    placeholderImage: UIImage(named: "loading"),
                                    filter: nil,
                                    imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
                                    runImageTransitionIfCached: false) {response in
                                        // Check if the image isn't already cached
                                        // if response.response != nil {
                                        //
                                        //}
                                        
            }
            
        }
        
    }
    
    
    @IBAction func clicouBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension DetailsOfNewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
//        case 0:
//            self.NewsTableView.rowHeight = 114
//            let cell : TitleTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell)!
//
//            cell.selectedNew = self.selectedNew
//
//            return cell
        case 0:
            self.NewsTableView.rowHeight = 99
            let cell : DescriptionTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as? DescriptionTableViewCell)!
            
            cell.selectedNew = self.selectedNew
            
            return cell
            
        case 1:
            self.NewsTableView.rowHeight = 153
            let cell : ContentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as? ContentTableViewCell)!
            
            cell.selectedNew = self.selectedNew
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
        
    }
    
}
