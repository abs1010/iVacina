////
////  NewsController.swift
////  iVacina
////
////  Created by Alan Silva on 17/10/19.
////  Copyright © 2019 Alan Silva. All rights reserved.
////
//
import Foundation

protocol NewsControllerDelegate : class {
    func successOnLoadingNewsController()
    func errorOnLoadingNewsController(error: Error?)
}

class NewsController {
  
    //Array que recebes as noticias do provider
    //private
    private var arrayOfNews: [NewsElement] = []
    //delegate
    weak var delegate: NewsControllerDelegate?
    var provider: NewsProvider?
    
    func setupController(){
           self.provider = NewsProvider()
           self.provider?.delegate = self
           
       }
    
    func loadNews() {
 
        self.setupController()
        self.provider?.loadNews()

        
    }


    //Get the number of items in the Array
    func numberOfRowsInSection() -> Int{
        return self.arrayOfNews.count
    }
    
    //Get a especif object from a IndexPath reference
    func loadCurrentNews(indexPath: IndexPath) -> NewsElement {
        return self.arrayOfNews[indexPath.row]
    }
    
}

extension NewsController : NewsProviderDelegate {
    
    func successOnLoadingNews(newsHeader: NewsHeader?) {
        self.arrayOfNews = newsHeader?.articles ?? []
        self.delegate?.successOnLoadingNewsController()
    }

    func errorOnLoadingNews(error: Error?) {
        
        self.delegate?.errorOnLoadingNewsController(error: error)

    }

}
