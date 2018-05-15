//
//  PullRequestCell.swift
//  ProjectMVC
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class PullRequestCell: UITableViewCell, ViewCode, ReusableCell {
    let userView = UIView()
    let userImage = UIImageView()

    let userName: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    let prTitle: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    let prDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup(with pullRequest: PullRequest) {
        let imageUrl = URL(string: pullRequest.image)
        userImage.kf.setImage(with: imageUrl)
        userName.text = pullRequest.owner
        prTitle.text = pullRequest.title
        prDescription.text = pullRequest.description
    }

    func buildViewHierarchy() {
        userView.addSubview(userImage)
        userView.addSubview(userName)
        addSubview(userView)
        addSubview(prTitle)
        addSubview(prDescription)
    }

    func configureViews() {
        prTitle.setContentHuggingPriority(.required, for: .vertical)
        userName.setContentHuggingPriority(.required, for: .vertical)
    }

    func setupConstraints() {
        constrain(userView, userImage, userName) { userView, userImage, userName in
            userImage.centerX == userView.centerX
            userImage.top == userView.top + 10
            userImage.width == 40
            userImage.height == 40

            userName.trailing == userView.trailing
            userName.leading == userView.leading
            userName.top == userImage.bottom + 2
        }

        constrain(self, userView, prTitle, prDescription) {
            containerView, userView, prTitle, prDescription in

            userView.top == containerView.top
            userView.bottom == containerView.bottomMargin - 8
            userView.trailing == containerView.trailing - 8
            userView.centerY == containerView.centerY
            userView.width == 100

            prTitle.top == containerView.top + 8
            prTitle.leading == containerView.leading + 8
            prTitle.trailing == userView.leading + 2

            prDescription.top == prTitle.bottom
            prDescription.leading == prTitle.leading
            prDescription.trailing == userView.leading + 2
            prDescription.baseline == userView.baseline
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
