//
//  MainViewController.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var email : String?
    var homeController: HomeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn(){
            homeController = HomeController()
        } else {
            perform(#selector(showLoginViewController), with: nil, afterDelay: 0.01)
        }
    }

    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.getLoggedInState()
    }
    
    @objc func showLoginViewController(){
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        guard let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        self.present(vc, animated: false, completion: nil)
    }


}
