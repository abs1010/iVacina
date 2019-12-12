//
//  Formatter.swift
//  iVacina
//
//  Created by Alan Silva on 17/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import UIKit


//MARK: - EXTENSIONS UICOLOR
extension UIColor {
    
    static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0) //Preto
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) //Branco
    static let azulEscuroCustom = UIColor(red: 65.0/255.0, green: 105.0/255.0, blue: 255.0/255.0, alpha: 1.0) //Hexa 4169E1
    static let azulClaroCustom  = UIColor(red: 64.0/255.0, green: 224.0/255.0, blue: 208.0/255.0, alpha: 1.0) //Hexa 40E0D0
    static let greenCustom      = UIColor(red: 1.0/255.0, green: 214.0/255.0, blue: 100.0/255.0, alpha: 1.0) //01D664
    static let lightGreyCustom  = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0) //EEEEEE
    
}


func formatarBotao(botao: UIButton){
    botao.layer.cornerRadius = botao.frame.size.height/2
    botao.layer.masksToBounds = true
}

func formatarTextField(textField: UITextField){
    textField.layer.cornerRadius = textField.frame.size.height/2
    textField.layer.masksToBounds = true
}

//MARK: - EXTENSIONS UIVIEW

extension UIView {
    
    func setGradientToView(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        //gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        //gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        //gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        //gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }


    func formatarUIView(){
        //containerView.layer.cornerRadius = view.frame.size.height/2
        let cornerRadius: CGFloat = 6.0
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.shadowRadius = 5
    }
    
}

//MARK: - EXTENSIONS UIBUTTON
extension UIButton {
    
    func setGradientToButton(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func formatarBotao(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    func pulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 100
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func shake(){
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x - 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
        
    }

}

extension UITextField {
    
    func formatarTextField(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        self.backgroundColor = Colors.lightGrey
        self.layer.borderColor = Colors.darkGrey.cgColor
        self.layer.borderWidth = 1.0
    }
}

//MARK: - EXTENSIONS UITABLEVIEWCELL

extension UITableViewCell {
    
    func setGradientToCell(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
