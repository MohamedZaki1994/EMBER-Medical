//
//  FilterPopupViewController.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class FilterPopupViewController: UIViewController {

    @IBOutlet weak var selectCountryTableView: UITableView!

    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!

    var countryButtonClicked = false
    var delegate: PopUpDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        countryButton.setTitle("Select Country", for: .normal)
        sourceButton.titleLabel?.text = "Select News Source"

    }

    @IBAction func closeButton(_ sender: Any) {
        delegate?.closePopup()
    }

    @IBAction func sourceButton(_ sender: Any) {
    }

    fileprivate func showHideCountryTableView() {
        countryButtonClicked = !countryButtonClicked
        selectCountryTableView.alpha = countryButtonClicked ? 1 : 0
        selectCountryTableView.isHidden = !countryButtonClicked
    }

    @IBAction func selectCountryButton(_ sender: Any) {
        showHideCountryTableView()
    }
}

extension FilterPopupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
                return Countries.supportedCountries.count
        default:
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch tableView.tag {
        case 0:
            cell.textLabel?.text = Countries.supportedCountries[indexPath.row]
        default:
            cell.textLabel?.text = "Done"
        }
        return cell
    }

}

extension FilterPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 0:
            countryButton.setTitle(Countries.supportedCountries[indexPath.row], for: .normal)
            showHideCountryTableView()
        default:
            sourceButton.titleLabel?.text = ""
        }
    }
}
