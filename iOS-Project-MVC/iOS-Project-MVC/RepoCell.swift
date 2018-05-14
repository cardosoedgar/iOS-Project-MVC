//
//  RepoCell.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class RepoCell: UITableViewCell, ViewCode, ReusableCell {
    
    let userView = UIView()
    let userImage = UIImageView()

    let userName: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    let userType: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    let repoName: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    let repoDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    let forkImage: UIImageView = {
        let image = UIImage(named: "fork")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    let forksNumber: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let starImage: UIImageView = {
        let image = UIImage(named: "star")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    let starsNumber: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(with repo: Repo) {
        let imageUrl = URL(string: repo.image)
        userImage.kf.setImage(with: imageUrl)
        userName.text = repo.owner
        userType.text = repo.type
        repoDescription.text = repo.description
        repoName.text = repo.name
        forksNumber.text = "\(repo.forks)"
        starsNumber.text = "\(repo.stars)"
    }
    
    func buildViewHierarchy() {
        userView.addSubview(userImage)
        userView.addSubview(userName)
        userView.addSubview(userType)
        addSubview(userView)
        addSubview(repoName)
        addSubview(repoDescription)
        addSubview(forkImage)
        addSubview(forksNumber)
        addSubview(starImage)
        addSubview(starsNumber)
    }
    
    func configureViews() {
        repoName.setContentHuggingPriority(.required, for: .vertical)
        userName.setContentHuggingPriority(.required, for: .vertical)
        forksNumber.setContentHuggingPriority(.required, for: .horizontal)
        starsNumber.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func setupConstraints() {
        constrain(userView, userImage, userName, userType) { userView, userImage, userName, userType in
            userImage.centerX == userView.centerX
            userImage.top == userView.top + 10
            userImage.width == 40
            userImage.height == 40

            userName.trailing == userView.trailing
            userName.leading == userView.leading
            userName.top == userImage.bottom + 2

            userType.trailing == userView.trailing
            userType.leading == userView.leading
            userType.top == userName.bottom + 2
            userType.bottom == userView.bottom - 10
        }

        constrain(self, userView, repoName, repoDescription, forkImage, forksNumber, starImage, starsNumber) {
             containerView, userView, repoName, repoDescription, forkImage, forksNumber, starImage, starsNumber in

            userView.top >= containerView.top
            userView.bottom >= containerView.bottom
            userView.trailing == containerView.trailing + 8
            userView.centerY == containerView.centerY
            userView.width == 130
            
            repoName.top == containerView.top + 8
            repoName.leading == containerView.leading + 8
            repoName.trailing == userView.leading + 2
            
            repoDescription.top == repoName.bottom
            repoDescription.leading == repoName.leading
            repoDescription.trailing == userView.leading + 2

            forkImage.top == repoDescription.bottom + 2
            forkImage.leading == repoName.leading
            forkImage.bottom == containerView.bottomMargin - 8
            forkImage.width == 14
            forkImage.height == 14

            forksNumber.top == forkImage.top
            forksNumber.leading == forkImage.trailing + 3

            starImage.top == forkImage.top
            starImage.leading == forksNumber.trailing + 3
            starImage.width == 14
            starImage.height == 14

            starsNumber.top == forkImage.top
            starsNumber.leading == starImage.trailing + 3
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
