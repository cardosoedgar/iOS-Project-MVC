//
//  ViewCode.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//
import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func configureViews()
    func setupConstraints()
    func setup()
}

extension ViewCode {
    func setup() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
