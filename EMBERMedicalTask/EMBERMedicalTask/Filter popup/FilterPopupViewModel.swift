//
//  FilterPopupViewModel.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/9/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

class FilterPopupViewModel {

    var sourcesName = [(id: String, name: String)]()
    func fetchSources(completion: (() -> Void)?) {
        RequestHandler.requestSources { [weak self] (sourceModel, error) in
            if error != nil {
                return
            }
            sourceModel?.sources?.forEach({ [weak self] (source) in
                if let name = source.name,
                    let id = source.id{
                    let tuple = (id, name)
                    self?.sourcesName.append(tuple)
                }
            })
            completion?()

        }
    }
}
