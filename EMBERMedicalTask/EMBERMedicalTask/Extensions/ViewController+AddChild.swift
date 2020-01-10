//
//  ViewController+AddChild.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/10/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

extension UIViewController {
    func addSubViewController(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
