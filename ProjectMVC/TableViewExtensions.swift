//
//  TableViewExtensions.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//

import UIKit

public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self)
        -> T where T: ReusableCell {
            let dequeueCell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
            guard let cell = dequeueCell as? T else {
                fatalError()
            }
            return cell
    }

    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: ReusableCell {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
