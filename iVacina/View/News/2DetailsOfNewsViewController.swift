//
//  2DetailsOfNewsViewController.swift
//  iVacina
//
//  Created by Alan Silva on 06/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import AlamofireImage
import SnapKit

class _DetailsOfNewsViewController: UIViewController, UIScrollViewDelegate {

    var selectedNew : NewsElement?
    
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let infoText = UILabel()
    private let textContainer = UIView()
    private let btnGoBack = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setupViewAndConstraints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    //MARK: - SETUP CELL E SETUP VIEW
    
    func setupCell(){
         
         //self.titleLabel.text = self.selectedNew?.title
        self.infoText.text = "\(self.selectedNew?.content ?? "") \nLorem ipsum dolor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed exlor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed exlor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed exlor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed ex"
        
         if let urlString = self.selectedNew?.urlToImage {
               self.imageView.af_setImage(withURL: URL(string: urlString)!,
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
    
    func setupViewAndConstraints(){
    
        view.backgroundColor = .gray
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        infoText.textColor = .black
        infoText.numberOfLines = 0
        
        //self.btnGoBack.tit = "< Back"
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .darkGray
        
        textContainer.backgroundColor = .clear
        
        let textBacking = UIView()
        textBacking.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textBacking)
        scrollView.addSubview(textContainer)
        scrollView.addSubview(imageView)
        
        textContainer.addSubview(infoText)
        
        //MARK:- CONSTRAINTS
        scrollView.snp.makeConstraints {
                make in
                
                make.edges.equalTo(view)
            }
            
            imageContainer.snp.makeConstraints {
                make in
                
                make.top.equalTo(scrollView)
                make.left.right.equalTo(view)
                make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
            }
            
            imageView.snp.makeConstraints {
                make in
                
                make.left.right.equalTo(imageContainer)

                //** Note the priorities
                make.top.equalTo(view).priority(.high)
                
                //** We add a height constraint too
                make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
                
                //** And keep the bottom constraint
                make.bottom.equalTo(imageContainer.snp.bottom)
            }
        
            textContainer.snp.makeConstraints {
                make in
                
                make.top.equalTo(imageContainer.snp.bottom)
                make.left.right.equalTo(view)
                make.bottom.equalTo(scrollView)
            }
            
            textBacking.snp.makeConstraints {
                make in
                
                make.left.right.equalTo(view)
                make.top.equalTo(textContainer)
                make.bottom.equalTo(view)
            }
            
            infoText.snp.makeConstraints {
                make in
                
                make.edges.equalTo(textContainer).inset(14)
            }
        
    }
    
    //MARK:- OTHERS
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    //MARK: - Scroll View Delegate
    
    private var previousStatusBarHidden = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
    
    //MARK: - Status Bar Appearance
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
}
