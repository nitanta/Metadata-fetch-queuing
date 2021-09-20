//
//  StringExtension.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/20/21.
//

import Foundation


extension String {
    /// Get the correct link for the url
    /// - Returns: the correct url
    func correctLink() -> String {
        if !self.hasPrefix("https://www.") {
            return "https://www." + self
        }
        return self
    }
}
