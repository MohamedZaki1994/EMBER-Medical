//
//  RequestHandler.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class RequestHandler {

    class func requestData(path: String = "" , completion:((DataSourceModel?, Error?) -> Void)?) {
        var urlComponent = URLComponents(string: Constants.baseURL + Constants.endPoint + path)
        urlComponent?.queryItems = query(country: "us")
        guard let url = urlComponent?.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(nil, error)
                return
            }
            var user: DataSourceModel?
                if let data = data {
                    do {
                        user = try JSONDecoder().decode(DataSourceModel.self, from: data)
                        completion?(user,nil)
                    }
                    catch {
                        print("error")
                    }
                }
        }.resume()
    }

    class func requestSources(completion:((SourcesModel?, Error?) -> Void)?) {
        var urlComponent = URLComponents(string: Constants.baseURL + Constants.sourcesEndPoint)
        urlComponent?.queryItems = query()
        guard let url = urlComponent?.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(nil, error)
                return
            }
            var user: SourcesModel?
                if let data = data {
                    do {
                        user = try JSONDecoder().decode(SourcesModel.self, from: data)
                        completion?(user,nil)
                    }
                    catch {
                        print("error")
                    }
                }
        }.resume()
    }

    private class func query(country: String = "") -> [URLQueryItem] {
        var queries = [URLQueryItem] ()
        let queryAPIKey = URLQueryItem(name: "apikey", value: Constants.apiKey)
        queries.append(queryAPIKey)
        if !country.isEmpty {
            queries.append(URLQueryItem(name: "country", value: country))
        }
        return queries
    }
}
