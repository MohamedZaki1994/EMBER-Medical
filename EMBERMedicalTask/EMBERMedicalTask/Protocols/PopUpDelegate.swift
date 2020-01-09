//
//  PopUpDelegate.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

protocol PopUpDelegate {
    func closePopup()
    func filter(country: String?, source: String?)
}
