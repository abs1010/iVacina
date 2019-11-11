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
    
    typealias completion <T> = (_ result: T, _ failure: Bool) -> Void
    
    func loadPostosDeSaude(completion: @escaping completion<PostoDeSaude?>) {
        
        let urlString: String = "http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest/estabelecimentos"
        if let url: URL = URL(string: urlString) {
            
            Alamofire.request(url).responseJSON { (response) in
                
                do {
                    let decodeObject = try JSONDecoder().decode(PostoDeSaude.self, from: response.data ?? Data())
                    
                    completion(decodeObject, false)
                    
                } catch {
                    completion(nil, true)
                }
            }
        }
    }
}
