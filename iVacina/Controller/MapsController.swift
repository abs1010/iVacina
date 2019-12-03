//
//  MapsController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

typealias completion <T> = (_ result: T, _ failure: NetworkingError?) -> Void

class MapsController {
    
    func getMedicalCenters(latitude: Double, longitude: Double, completion: @escaping completion<[MapsLocals]?>) {
        
        var arrayMapsLocals: [MapsLocals] = []
        
        MapsDataProvider().loadMedicalCenters(latitude: latitude, longitude: longitude) { (response, error) in
            if let response = response {
                for value in response.businesses {
                    let currentPostoDeSaude = MapsLocals(json: value)
                    print (currentPostoDeSaude)
                    arrayMapsLocals.append(currentPostoDeSaude)
                }
                completion(arrayMapsLocals, nil)
            }
        }
    }
    
}
