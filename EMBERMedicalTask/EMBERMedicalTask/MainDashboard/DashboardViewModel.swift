//
//  DashboardViewModel.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class DashboardViewModel {

    var dataModel = [ArticleItem]()
    func fetchData(completion: (([ArticleItem]?) -> Void)?) {
        RequestHandler.request { [weak self] (dataModel, error) in
            guard let self = self else {return}
            if error != nil {
                print(error as Any)
                return
            }
            guard let data = dataModel else {return}
            self.mapData(data: data)
            completion?(self.dataModel)
        }
    }

    func mapData(data: DataSourceModel) {
        data.articles?.forEach({ (articleModel) in
            let article = ArticleItem(headLine: articleModel.title,
                                      date: articleModel.publishedAt?.format(),
                                      imageURL: articleModel.urlToImage,
                                      description: articleModel.articleDescription,
                                      url: articleModel.url,
                                      author: articleModel.author,
                                      sourceName: articleModel.source.name)
            
            dataModel.append(article)
        })
    }
}
