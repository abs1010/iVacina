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
    
    func getPostoDeSaude(completion: @escaping completion<[MapsLocals]?>) {
        
        var arrayMapsLocals: [MapsLocals] = []
        
        MapsDataProvider().loadPostosDeSaude(latitude: -23.5615, longitude: -46.656, raio: 1000.0) { (response, error) in
            if let response = response {
                for value in response {
                    let currentPostoDeSaude = MapsLocals(json: value)
                    print (currentPostoDeSaude)
                    arrayMapsLocals.append(currentPostoDeSaude)
                }
                completion(arrayMapsLocals, false)
            }
        }
    }
    
}
