//
//  String+DateFormatter.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

extension String {
    func format() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from:self) else { return "" }
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.string(from: date)
    }
}
