//
//  NewsController.swift
//  iVacina
//
//  Created by Alan Silva on 17/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

class NewsController {
    
     func getAListOfNews(completion: @escaping completion<News?>) {
        
        NewsDataProvider().getNews { (response, error) in
            
            if let _response = response {
                completion(_response, false)
            }else{
                completion(nil, true)
            }
            
        }
        
    }
    
}
