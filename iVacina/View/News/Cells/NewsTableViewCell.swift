//
//  TableViewCell.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var noticia : NewsElement?
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var briefingLabel: UILabel!
    @IBOutlet weak var releaseTimeLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imagem: UIImageView!
    
    
    func setupCell(noticia: NewsElement){
        self.titleLabel.text = noticia.title
        self.briefingLabel.text = noticia.newsDescription
        self.sourceLabel.text = noticia.source?.name
        self.releaseTimeLabel.text = noticia.publishedAt
        
        if noticia.urlToImage != "" {
        self.imagem.image = UIImage(named: noticia.urlToImage ?? "")
        }
        else {self.imagem.image = UIImage(named: "placeholder")}
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.holderView.formatarUIView()
        //formatarUIView(containerView: holderView)
        self.holderView.setGradientToView(colorOne: UIColor.azulClaroCustom, colorTwo: UIColor.azulEscuroCustom)

        
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
