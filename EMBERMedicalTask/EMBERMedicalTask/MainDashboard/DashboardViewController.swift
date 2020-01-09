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
    var notFoundLabel = UILabel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "News App", style: .plain, target: self, action: nil)
        notFoundLabel = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.midY, width: view.frame.width, height: 50))
        notFoundLabel.textAlignment = .center
        view.addSubview(notFoundLabel)
        notFoundLabel.text = "Loading..."
        let nib = UINib(nibName: "MainDashboardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainDashboardTableViewCell")
        viewModel.fetchData(country: "us") { [weak self] (dataModel) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.notFoundLabel.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    var popupView: UIView?
    @objc func filterTapped() {
        if !isPopupPresented {
            guard let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FilterPopupViewController") as? FilterPopupViewController else {return}
            filterVC.delegate = self
            filterVC.modalPresentationStyle = .fullScreen
            addChild(filterVC)
            view.addSubview(filterVC.view)
            popupView = filterVC.view
            filterVC.didMove(toParent: self)
            isPopupPresented = true
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
        guard let detailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedScreenViewController") as? DetailedScreenViewController else {return}
        detailedVC.dataModel = viewModel.dataModel[indexPath.row]
        navigationItem.backBarButtonItem?.title = viewModel.dataModel[indexPath.row].sourceName
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension DashboardViewController: PopUpDelegate {
    func filter(country: String?, source: String?) {
        popupView?.removeFromSuperview()
        isPopupPresented = false
        viewModel.fetchData(country: country ?? "", source: source ?? "") { [weak self] (dataModel) in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                if dataModel?.isEmpty ?? true {
                    self.notFoundLabel.isHidden = false
                    self.notFoundLabel.text = "results not found!"
                } else {
                    self.notFoundLabel.isHidden = true
                }
                self.tableView.reloadData()
            }
        }
    }

    func closePopup() {
        popupView?.removeFromSuperview()
        isPopupPresented = false
    }
}
