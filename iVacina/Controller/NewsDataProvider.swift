//
//  NewsDataProvider.swift
//  iVacina
//
//  Created by Alan Silva on 17/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation


let API_KEY = "6ace23c5086742ea849174cf7e33169b"

typealias completion <T> = (_ result: T, _ failure: Bool) -> Void

class NewsDataProvider {
    
    func getNews(completion: @escaping completion<News?>) {
        
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decodeObject = try? JSONDecoder().decode(News.self, from: data)
                
                completion(decodeObject, false)
                
            }catch {
                completion(nil, true)
            }
            
        }
        
    }
    
}

