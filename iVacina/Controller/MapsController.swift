//
//  MapsController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

typealias completion <T> = (_ result: T, _ failure: Bool) -> Void

class MapsController {
    
    func loadPostosDeSaude (completion: @escaping completion<PostoDeSaude?>) {
        
        MapsDataProvider().loadPostosDeSaude { (response, error) in
            if let response = response {
                completion(response, false)
            } else {
                completion(nil, false)
            }
        }
    }
}
