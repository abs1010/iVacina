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
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var selectedNew : NewsElement?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupCell()
        
    }
    
    func setupCell(){
        
        self.titleLabel.text = self.selectedNew?.title
        self.descriptionLabel.text = self.selectedNew?.articleDescription
        
        if let urlString = self.selectedNew?.urlToImage {
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
        
        
        //self.selectedNew = NewsElement()
        //let contadorSort = Int.random(in: 1...9)
        //self.imagem.image = UIImage(named: "news\(contadorSort)")
        
    }
    
    
    @IBAction func clicouBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

        
        //--------
        
//        view.backgroundColor = .gray
//
//            scrollView.contentInsetAdjustmentBehavior = .never
//            scrollView.delegate = self
//
//            imagem.image = UIImage(named: "Header")
//            imagem.contentMode = .scaleAspectFill
//            imagem.clipsToBounds = true
//
//            titleLabel.textColor = .white
//            titleLabel.numberOfLines = 0
//            let text =  """
//                        Lorem ipsum dolor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed ex.
//
//                        Quod possit expetendis id qui, consequat vituperata ad eam. Per cu elit latine vivendum. Ei sit nullam aliquam, an ferri epicuri quo. Ex vim tibique accumsan erroribus. In per libris verear adipiscing. Purto aliquid lobortis ea quo, ea utinam oportere qui.
//                        """
//            titleLabel.text = text + text + text
//
//            let imageContainer = UIView()
//            imageContainer.backgroundColor = .darkGray
//
//            textContainer.backgroundColor = .clear
//
//            let textBacking = UIView()
//            textBacking.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1235740449, blue: 0.2699040081, alpha: 1)
//
//            view.addSubview(scrollView)
//
//            scrollView.addSubview(imageContainer)
//            scrollView.addSubview(textBacking)
//            scrollView.addSubview(textContainer)
//            scrollView.addSubview(imageView)
//
//            textContainer.addSubview(infoText)
//
//            scrollView.snp.makeConstraints {
//                make in
//
//                make.edges.equalTo(view)
//            }
//
//            imageContainer.snp.makeConstraints {
//                make in
//
//                make.top.equalTo(scrollView)
//                make.left.right.equalTo(view)
//                make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
//            }
//
//            imagem.snp.makeConstraints {
//                make in
//
//                make.left.right.equalTo(imageContainer)
//
//                //** Note the priorities
//                make.top.equalTo(view).priority(.high)
//
//                //** We add a height constraint too
//                make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
//
//                //** And keep the bottom constraint
//                make.bottom.equalTo(imageContainer.snp.bottom)
//            }
//
//            textContainer.snp.makeConstraints {
//                make in
//
//                make.top.equalTo(imageContainer.snp.bottom)
//                make.left.right.equalTo(view)
//                make.bottom.equalTo(scrollView)
//            }
//
//            textBacking.snp.makeConstraints {
//                make in
//
//                make.left.right.equalTo(view)
//                make.top.equalTo(textContainer)
//                make.bottom.equalTo(view)
//            }
//
//            infoText.snp.makeConstraints {
//                make in
//
//                make.edges.equalTo(textContainer).inset(14)
//            }
        //--------
