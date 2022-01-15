//
//  TableView+Extension.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import UIKit
public extension UITableViewCell {
    class var identifier: String {
        return "\(self)"
    }

    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static func registerTo(tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func dequeue(tableView: UITableView, indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let result = cell as? Self else { return Self() }
        return result
    }
    
    static func dequeue(tableView: UITableView) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        guard let result = cell as? Self else { return Self() }
        return result
    }

    var baseTabelView: UITableView? {
        var view = self.superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        
        return view as? UITableView
    }
}
