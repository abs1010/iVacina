//
//  News.swift
//  iVacina
//
//  Created by Alan Silva on 14/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

// MARK: - NewsHeader
struct NewsHeader: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsElement]?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

// MARK: - Article
struct NewsElement: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

typealias News = [NewsElement]
