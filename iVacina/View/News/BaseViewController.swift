//
//  BaseViewController.swift
//  iVacina
//
//  Created by Alan Silva on 04/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    var animationLoadingView: AnimationView?
    var whiteView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showLoading(){
        whiteView = UIView(frame: self.view.frame)
        whiteView?.backgroundColor = .white
        self.view.addSubview(whiteView ?? UIView())
        
        self.animationLoadingView = AnimationView()
        
        self.animationLoadingView?.frame = self.view.frame
        self.animationLoadingView?.backgroundColor = .clear
        
        let animation = Animation.named("loading1")
        animationLoadingView?.animation = animation
        animationLoadingView?.loopMode = .loop
        
        whiteView?.addSubview(self.animationLoadingView ?? UIView())
        animationLoadingView?.play()
    }
    
    func hideLoading(){
        whiteView?.removeFromSuperview()
        self.animationLoadingView?.stop()
        self.animationLoadingView?.removeFromSuperview()
        
    }
    
}
