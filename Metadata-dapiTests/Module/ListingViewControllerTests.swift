//
//  ListingViewControllerTests.swift
//  Metadata-dapiTests
//
//  Created by Nitanta Adhikari on 9/20/21.
//

import XCTest
@testable import Metadata_dapi

final class ListingViewControllerTests: XCTestCase {
    
    private var sut: ListingViewController!
    private var viewModel: MockListingViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = ListingViewController.initialize(.main)
        viewModel = MockListingViewModel(service: MetadataRetreiver(urls: []))
        
        sut.viewModel = viewModel
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_pickerScene_hasTableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_listScene_onInstantiate_setupObserverCalled() {
        XCTAssertTrue(viewModel.setupObserverCalled)
    }
    
    func test_listScene_onNavButtonPressed_fetchMetadataCalled() {
        sut.startTapped()
        XCTAssertTrue(viewModel.fetchMetadataCalled)
    }
    
}



private final class MockListingViewModel: ListViewModelImplementable {
    var datasource: [ListingModel] = []
    
    init(service: MetadataRetreiveProtocol) {}
    
    var setupObserverCalled: Bool = false
    func setupObservers() {
        setupObserverCalled = true
    }
    
    var fetchMetadataCalled: Bool = false
    func fetchMetadata() {
        fetchMetadataCalled = true
    }
    
}
