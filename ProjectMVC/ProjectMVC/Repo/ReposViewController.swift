//
//  ReposViewController.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//

import UIKit
import Cartography

class ReposViewController: UIViewController, ViewCode, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let manager = ReposManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadRepos()
    }

    func loadRepos() {
        manager.getRepos(page: 0) { success in
            if success {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getRepoCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RepoCell.self)
        if let repo = manager.getRepo(at: indexPath.row) {
            cell.setup(with: repo)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repository = manager.getRepo(at: indexPath.row) {
            let prManager = PullRequestsManager(repo: repository)
            let prController = PullRequestViewController(manager: prManager)
            navigationController?.pushViewController(prController, animated: true)
        }
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func configureViews() {
        title = "Swift Repos"
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(cellType: RepoCell.self)
    }

    func setupConstraints() {
        constrain(view, tableView) { containerView, tableView in
            tableView.edges == containerView.edges
        }
    }
}
