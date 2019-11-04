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

    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var briefingLabel: UILabel!
    @IBOutlet weak var releaseTimeLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imagem: UIImageView!
    
    
    func setupCell(noticia: NewsElement){
        self.titleLabel.text = noticia.title
        self.briefingLabel.text = noticia.articleDescription
        self.sourceLabel.text = noticia.source?.name
        self.releaseTimeLabel.text = noticia.publishedAt
        
        let stringErro : URL?
        
        stringErro = URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.brownweinraub.com%2Fhome%2Fplaceholder%2F&psig=AOvVaw2vj5whQLDgxppQFL4rvO0g&ust=1572916839983000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPj6yv-xz-UCFQAAAAAdAAAAABAN")
           
        if let urlString = noticia.urlToImage {
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
