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
    @IBOutlet weak var selectSourceTableView: UITableView!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    var viewModel = FilterPopupViewModel()

    var countryButtonClicked = false
    var sourceButtonClicked = false

    var delegate: PopUpDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchSources { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.selectSourceTableView.reloadData()
            }
        }
        countryButton.setTitle("Select Country", for: .normal)
        sourceButton.titleLabel?.text = "Select News Source"

    }

    @IBAction func closeButton(_ sender: Any) {
        delegate?.closePopup()
    }

    @IBAction func sourceButton(_ sender: Any) {
        if sourceButtonClicked {
            showHideSourcesTableView(show: false)
            return
        }
        showHideSourcesTableView(show: true)
        showHideCountryTableView(show: false)
    }

    @IBAction func selectCountryButton(_ sender: Any) {
        if countryButtonClicked {
            showHideCountryTableView(show: false)
            return
        }
        showHideCountryTableView(show: true)
        showHideSourcesTableView(show: false)
    }

    fileprivate func showHideCountryTableView(show: Bool) {
        countryButtonClicked = show
        selectCountryTableView.alpha = show ? 1 : 0
        selectCountryTableView.isHidden = !show
    }

    fileprivate func showHideSourcesTableView(show: Bool) {
        sourceButtonClicked = show
        selectSourceTableView.alpha = show ? 1 : 0
        selectSourceTableView.isHidden = !show
    }
}

extension FilterPopupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
                return Countries.supportedCountries.count
        default:
            return viewModel.sourcesName.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch tableView.tag {
        case 0:
            cell.textLabel?.text = Countries.supportedCountries[indexPath.row]
        default:
            cell.textLabel?.text = viewModel.sourcesName[indexPath.row]
        }
        return cell
    }
}

extension FilterPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 0:
            countryButton.setTitle(Countries.supportedCountries[indexPath.row], for: .normal)
            showHideCountryTableView(show: false)
        default:
            sourceButton.titleLabel?.text = ""
            showHideSourcesTableView(show: false)
        }
    }
}
