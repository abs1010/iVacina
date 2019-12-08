//
//  File.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 08/12/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setLoggedInState(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func getLoggedInState() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}
