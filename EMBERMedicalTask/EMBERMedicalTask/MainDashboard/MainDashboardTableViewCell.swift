//
//  MainDashboardTableViewCell.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit
import Kingfisher

class MainDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!

    func configure(url: URL?) {
        newsImage.kf.setImage(with: url)
    }
    
}
