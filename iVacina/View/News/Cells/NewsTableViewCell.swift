//
//  TableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var briefingLabel: UILabel!
    @IBOutlet private weak var releaseTimeLabel: UILabel!
    @IBOutlet private weak var holderView: UIView!
    @IBOutlet private weak var imagem: UIImageView!
    
    
    func getReadingTime(noticia: NewsElement) -> String {
        
       if noticia.publishedAt?.count ?? 0 >= 300 {
        return "3 minutos"
       }else if
        noticia.publishedAt?.count ?? 0 >= 200 {
        return "2 minutos"
        }
       else {
        return "1 minuto"
        }
    
    }
    
    
    func setupCell(noticia: NewsElement){
        self.titleLabel.text = noticia.title
        self.briefingLabel.text = noticia.articleDescription
        self.sourceLabel.text = noticia.source?.name
        self.releaseTimeLabel.text = self.getReadingTime(noticia: noticia)
                
        if let urlString = noticia.urlToImage {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.holderView.formatarUIView()
        self.holderView.setGradientToView(colorOne: UIColor.azulClaroCustom, colorTwo: UIColor.azulEscuroCustom)
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
