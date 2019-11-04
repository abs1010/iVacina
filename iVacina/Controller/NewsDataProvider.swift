//
//  NewsDataProvider.swift
//  iVacina
//
//  Created by Alan Silva on 17/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import Alamofire

protocol NewsProviderDelegate : class {
    func successOnLoadingNews(newsHeader: NewsHeader?)
    func errorOnLoadingNews(error: Error?)
}

let BASE_URL = "https://newsapi.org/v2/top-headlines?"
let COUNTRY = "br"
let CATEGORY = "health"
let API_KEY = "6ace23c5086742ea849174cf7e33169b"

class NewsProvider {
    
    weak var delegate : NewsProviderDelegate?
    
    func loadNews() {
        
        let urlString: String = BASE_URL + "country=" + COUNTRY + "&category=" + CATEGORY + "&apiKey=" + API_KEY
        //print(urlString)
        
        if let url: URL = URL(string: urlString) {
            
            Alamofire.request(url, method: .get).responseJSON { (response) in
                
                if response.response?.statusCode == 200 {
                    
                    do {
                        
                        let model = try JSONDecoder().decode(NewsHeader.self, from: response.data ?? Data())
                        
                        self.delegate?.successOnLoadingNews(newsHeader: model)
                        
                        print("\(model.articles?.count ?? 0) resultados obtidos da API.")
                        //print(model?.articles?[1].author)
                        
                    }catch let error {
                        print(error)
                        print("Erro: Problema ao retrieve data")
                        self.delegate?.errorOnLoadingNews(error: error)
                    }
                    
                }
                else {
                    print("=============error")
                    print(response.error ?? "")
                    self.delegate?.errorOnLoadingNews(error: response.error)
                }
                
            }
            
        }
        
    }
    
}
