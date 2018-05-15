//
//  PullRequestViewController.swift
//  iOS-Project-MVC
//
//  Created by Edgar Costa Cardoso on 14/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Cartography

class PullRequestViewController: UIViewController, ViewCode, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func configureViews() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
    }

    func setupConstraints() {
        constrain(view, tableView) { containerView, tableView in
            tableView.edges == containerView.edges
        }
    }
}
