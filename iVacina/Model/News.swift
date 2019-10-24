//
//  News.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

struct NewsElement: Codable {

    let source: Source?
    let author, title: String?
    let newsDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source
        case author, title
        case newsDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    // MARK: - Source
    struct Source: Codable {
        let id, name: String?
    }
    
}

typealias News = [NewsElement]
