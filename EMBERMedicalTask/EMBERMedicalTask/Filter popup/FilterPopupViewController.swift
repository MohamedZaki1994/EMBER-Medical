//
//  FilterPopupViewController.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class FilterPopupViewController: UIViewController {

    var delegate: PopUpDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func closeButton(_ sender: Any) {
        delegate?.closePopup()
    }
}
