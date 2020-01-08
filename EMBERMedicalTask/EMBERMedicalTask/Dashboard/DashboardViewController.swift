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
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MainDashboardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainDashboardTableViewCell")
        viewModel.fetchData { [weak self] (dataModel) in
            guard let self = self else {return}
            DispatchQueue.main.async {
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

