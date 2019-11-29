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
    
    func loadPostosDeSaude(latitude: Double, longitude:Double, raio: Float, completion: @escaping completion<PostoDeSaude?>) {
        //minha mock rio de Janeiro
        
        let urlString: String = "https://private-ee73ab-postosdesaude.apiary-mock.com/postos/rio-de-janeiro"
        
        //mock Rio Modificada
        //let urlString: String = "http://www.mocky.io/v2/5dd5c5543300002d00f3830f"
        
        //mock Rio
        //let urlString: String = "http://www.mocky.io/v2/5dd5a0023300007d00f38293"
        
        //mock Sao Paulo
        //let urlString: String = "http://www.mocky.io/v2/5dd5b91e33000023bdf382e8"
        
        //URL Original
        //let urlString: String = "http://mobile-aceite.tcu.gov.br:80/mapa-da-saude/rest/estabelecimentos/latitude/\(latitude)/longitude/\(longitude)/raio/\(raio)"
        if let url: URL = URL(string: urlString) {
            Alamofire.request(url).responseJSON { (response) in
                
                print(response)
                
                if response.response?.statusCode == 200 {
                    
                    do {
                        let decodeObject = try JSONDecoder().decode(PostoDeSaude.self, from: response.data ?? Data())
                        
                        completion(decodeObject, nil)
                        
                    } catch {
                        print("================================")
                        print(error)
                        print("================================")
                        completion(nil, .invalidResponse)
                        
                    }
                } else {
                    completion(nil, .invalidRequest)
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


