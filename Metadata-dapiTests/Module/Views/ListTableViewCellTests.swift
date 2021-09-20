//
//  ListTableViewCellTests.swift
//  Metadata-dapiTests
//
//  Created by Nitanta Adhikari on 9/20/21.
//

import XCTest
@testable import Metadata_dapi

final class ListTableViewCellTests: XCTestCase {
    
    private var sut: ListTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = Bundle(for: ListTableViewCell.self).loadNibNamed("ListTableViewCell", owner: nil)?.first as? ListTableViewCell
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_cellView_hasViews() {
        XCTAssertNotNil(sut.logoImageView)
        XCTAssertNotNil(sut.subtitleLabel)
        XCTAssertNotNil(sut.titleLabel)
    }
    
}
