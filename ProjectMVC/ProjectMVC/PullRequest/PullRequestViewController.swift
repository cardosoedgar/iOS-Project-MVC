//
//  PullRequestViewController.swift
//  iOS-Project-MVC
//
//  Created by Edgar Costa Cardoso on 14/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Cartography
import SafariServices

class PullRequestViewController: UIViewController, ViewCode, UITableViewDelegate, UITableViewDataSource {
    let manager: PullRequestsManager
    let tableView = UITableView()

    init(manager: PullRequestsManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadPullRequests()
    }

    func loadPullRequests() {
        manager.getPullRequests { success in
            if success {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getPullRequestCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PullRequestCell.self)
        if let pullRequest = manager.getPullRequest(at: indexPath.row) {
            cell.setup(with: pullRequest)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let pullRequest = manager.getPullRequest(at: indexPath.row), let url = URL(string: pullRequest.url) {
            let webController = SFSafariViewController(url: url)
            self.present(webController, animated: true, completion: nil)
        }
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func configureViews() {
        title = manager.getRepoName()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(cellType: PullRequestCell.self)
    }

    func setupConstraints() {
        constrain(view, tableView) { containerView, tableView in
            tableView.edges == containerView.edges
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
