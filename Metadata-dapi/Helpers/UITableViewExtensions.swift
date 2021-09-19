//
//  UITableViewExtensions.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit

extension UITableViewCell {
    /// cell identifier of the tableviewcell
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}
