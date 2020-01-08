//
//  DetailedScreenViewController.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class DetailedScreenViewController: UIViewController {

    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sourceURl: UILabel!

    var dataModel: ArticleItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        headLine.text = dataModel?.headLine
        authorLabel.text = "By: " + (dataModel?.author ?? "unknown Author")
        textView.text = dataModel?.description
        sourceURl.text = "Source URL: " + (dataModel?.url ?? "no url found")
    }
}
