//
//  RequestHandler.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class RequestHandler {

    class func request(path: String = "" , completion:((DataSourceModel?, Error?) -> Void)?) {
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

    private class func query(country: String) -> [URLQueryItem] {
        let query1 = URLQueryItem(name: "country", value: country)
        let query2 = URLQueryItem(name: "apikey", value: Constants.apiKey)
        return [query1, query2]
    }
}
