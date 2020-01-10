//
//  ViewController.swift
//  EMBERMedicalTask
//
//  Created by Mohamed Mahmoud Zaki on 1/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    var viewModel = DashboardViewModel()
    var isPopupPresented = false
    var statusLabel = UILabel()
    var popupView: UIView?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupStatusLabel()
        registerCell()
        fetchData(country: "us", source: nil)
    }

    @objc func filterTapped() {
        if !isPopupPresented {
            guard let filterVC = Factory.makeFilterVC() else {return}
            filterVC.delegate = self
            filterVC.modalPresentationStyle = .fullScreen
            popupView = filterVC.view
            addSubViewController(viewController: filterVC)
            isPopupPresented = true
        }
    }

    func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "News App", style: .plain, target: self, action: nil)
    }

    func setupStatusLabel() {
        statusLabel = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.midY, width: view.frame.width, height: 50))
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        statusLabel.text = "Loading..."
    }

    func registerCell() {
        let nib = UINib(nibName: "MainDashboardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainDashboardTableViewCell")
    }

    func fetchData(country: String?, source: String?) {
        viewModel.fetchData(country: country ?? "", source: source ?? "") { [weak self] (dataModel) in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                if dataModel?.isEmpty ?? true {
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = "results not found!"
                } else {
                    self.statusLabel.isHidden = true
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDashboardTableViewCell", for: indexPath)
        guard let dashboardCell = cell as? MainDashboardTableViewCell else {
            return cell
        }
        dashboardCell.headline.text = viewModel.dataModel[indexPath.row].headLine
        dashboardCell.datelabel.text = viewModel.dataModel[indexPath.row].date
        if let stringUrl = viewModel.dataModel[indexPath.row].imageURL {
            dashboardCell.configure(url: URL(string: stringUrl))
        }
        return dashboardCell
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = Factory.makeDetailedVC() else {return}
        detailedVC.dataModel = viewModel.dataModel[indexPath.row]
        navigationItem.backBarButtonItem?.title = viewModel.dataModel[indexPath.row].sourceName
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension DashboardViewController: PopUpDelegate {
    func filter(country: String?, source: String?) {
        closePopup()
        fetchData(country: country, source: source)
    }

    func closePopup() {
        popupView?.removeFromSuperview()
        isPopupPresented = false
    }
}
