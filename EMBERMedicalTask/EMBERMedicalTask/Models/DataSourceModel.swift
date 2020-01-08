//
//  DataSourceModel.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class DataSourceModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

class Article: Codable {
    var source: Source
    var author: String?
    var title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

class Source: Codable {
    var id: String?
    var name: String?
}
