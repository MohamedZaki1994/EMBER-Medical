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
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    var viewModel = FilterPopupViewModel()
    var countryButtonClicked = false
    var sourceButtonClicked = false
    var selectedCountry: String?
    var selectedSource: (id: String, name: String)?
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
        sourceImageView.image = UIImage(named: "circleDot")
        countryImageView.image = UIImage(named: "circle")
        showHideCountryTableView(show: false)
        countryButton.setTitle("Select Country", for: .normal)
        selectedCountry = nil
    }

    @IBAction func selectCountryButton(_ sender: Any) {
        if countryButtonClicked {
            showHideCountryTableView(show: false)
            return
        }
        showHideCountryTableView(show: true)
        countryImageView.image = UIImage(named: "circleDot")
        sourceImageView.image = UIImage(named: "circle")
        showHideSourcesTableView(show: false)
        sourceButton.setTitle("Select News Source", for: .normal)
        selectedSource = nil
    }

    @IBAction func cancelButton(_ sender: Any) {
        delegate?.closePopup()
    }

    @IBAction func filterButton(_ sender: Any) {
        delegate?.filter(country: selectedCountry, source: selectedSource?.id)
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
            cell.textLabel?.text = viewModel.sourcesName[indexPath.row].name
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
            selectedCountry = Countries.supportedCountries[indexPath.row]
        default:
            sourceButton.setTitle(viewModel.sourcesName[indexPath.row].name, for: .normal)
            showHideSourcesTableView(show: false)
            selectedSource = viewModel.sourcesName[indexPath.row]
        }
    }
}
