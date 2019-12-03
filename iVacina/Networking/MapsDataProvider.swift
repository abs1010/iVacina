//
//  MapsDataProvider.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 10/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import Alamofire


class MapsDataProvider {
    
    typealias completion <T> = (_ result: T, _ failure: NetworkingError?) -> Void
    
    func loadMedicalCenters(latitude: Double, longitude:Double, completion: @escaping completion<ArrayMedicalCenters?>) {
        
     let baseURL: String = "https://api.yelp.com/v3/businesses/search"
     let apiKey: String = "Bearer 6_-pCYfUiMRBfQcclRYeTP5_YOvouRsCorah244UEhqNZ-5aR74jSSEssxsgEdvX4_rJtOh4XotwnKOQ2sUqNxJY6_didGZjIuFLyxB1M4fWm_ZfWgqi7CWlZp3mXXYx"
         
         if let url = URL(string: baseURL){
             
             let parameters: [String:Any] = ["latitude": latitude, "longitude": longitude, "categories": "medcenters"]
             
             let header: HTTPHeaders = ["Authorization": apiKey]
             
             Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
                 
                 print (response)
                 
                 if response.response?.statusCode == 200 {
                     
                     do {
                         let decodeObject = try JSONDecoder().decode(ArrayMedicalCenters.self, from: response.data ?? Data())
                         
                         completion(decodeObject, nil)
                         
                     } catch let jsonerr {
                         completion(nil,.invalidResponse)
                         print (jsonerr)
                         
                     }
                     
                 } else {
                     completion(nil,.invalidRequest)
                     
                 }
             }
         }
     }
 }

 enum NetworkingError: String, Error {
     
     case invalidRequest = "Você fez uma requisição invalida"
     case invalidResponse = "Há alguma coisa errada com a resposta que recebemos"
 }

 extension NetworkingError: LocalizedError {
     
     var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
 }



