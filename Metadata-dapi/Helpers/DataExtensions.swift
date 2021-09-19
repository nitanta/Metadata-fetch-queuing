//
//  DataExtensions.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation

extension Data {
    /// Convert data to a formatted string
    var prettyPrintedString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let prettyPrintedString = NSString(data: self, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
    
    /// Get size of the data
    /// - Parameters:
    ///   - units: unit representation - KB, MB and others
    ///   - countStyle: stype = file, memory, binary and decimal
    /// - Returns: output formatted size in string
    func sizeString(units: ByteCountFormatter.Units = [.useAll], countStyle: ByteCountFormatter.CountStyle = .file) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = units
        bcf.countStyle = .file

        return bcf.string(fromByteCount: Int64(count))
     }
}
