//
//  Alert.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 26/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    func showAlert(title: String?, message: String?, vc: UIViewController){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
