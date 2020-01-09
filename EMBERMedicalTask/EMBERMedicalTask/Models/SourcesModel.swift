//
//  SourcesModel.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/9/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class SourcesModel: Codable {
    var status: String?
    var sources: [Source]?
}

class Source: Codable {
    var id, name, sourceDescription: String?
    var url: String?
    var category: Category?
    var language, country: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}
