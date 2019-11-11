//
//  DetailsOfNewsViewController.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

class DetailsOfNewsViewController: UIViewController {
    
    @IBOutlet private weak var imagem: UIImageView!
    @IBOutlet private weak var source: UILabel!
    @IBOutlet private weak var timeToRead: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var btnsource: UIButton!
    @IBOutlet private weak var contentTextView: UITextView!
    
    var selectedNew : NewsElement?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupCell()
        
        self.btnsource.formatarBotao()
        self.btnsource.setTitle("Ver mais detalhes", for: .normal)
        self.btnsource.setGradientToButton(colorOne: .azulEscuroCustom, colorTwo: .azulClaroCustom)
        
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
      //self.descriptionLabel.text = self.selectedNew?.articleDescription ?? ""
        self.timeToRead.text = "1 min"
        self.source.text = self.selectedNew?.source?.name ?? ""
        self.contentLabel.text = "\(self.selectedNew?.articleDescription ?? "") \n\n \(self.selectedNew?.content ?? "")..."
        
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
