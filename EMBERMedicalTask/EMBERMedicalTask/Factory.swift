//
//  Factory.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/10/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class Factory {

    class func makeFilterVC() -> FilterPopupViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FilterPopupViewController") as? FilterPopupViewController
    }

    class func makeDetailedVC() -> DetailedScreenViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedScreenViewController") as? DetailedScreenViewController
    }
}
