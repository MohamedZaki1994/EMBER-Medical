//
//  FilterPopupViewModel.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/9/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class FilterPopupViewModel {

    var sourcesName = [String]()
    func fetchSources(completion: (([String]?) -> Void)?) {
        RequestHandler.requestSources { [weak self] (sourceModel, error) in
            if error != nil {
                return
            }
            sourceModel?.sources?.forEach({ [weak self] (source) in
                if let name = source.name {
                    self?.sourcesName.append(name)
                }
            })
            completion?(self?.sourcesName)

        }
    }
}
