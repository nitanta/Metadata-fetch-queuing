//
//  ListingViewModel.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation
import Combine

enum Sites: String, CaseIterable {
    case apple          = "https://apple.com"
    case spacex         = "https://spacex.com"
    case dapi           = "https://dapi.co"
    case facebook       = "https://facebook.com"
    case microsoft      = "https://microsoft.com"
    case amazon         = "https://amazon.com"
    case boomsupersonic = "https://boomsupersonic.com"
    case twitter        = "https://twitter.com"
}

enum State: Hashable {
    case idle
    case running
    case successful(String, String) // Favicon url and data size
    case failed(Int) // error code
}

struct ListingModel: Hashable, Equatable {
    var url: String
    var state: State = .idle
}


final class ListingViewModel {
    
    enum ViewModelState {
        case loading
        case finishedLoading
        case error(Error)
    }
    
    enum Section { case contents }
    
    private let service: MetadataFetchServiceProtocol
    private var bag = Set<AnyCancellable>()
    
    @Published private(set) var datasource: [ListingModel] = []
    @Published private(set) var state: ViewModelState = .loading
    
    
    init(service: MetadataFetchServiceProtocol) {
        self.service = service
    }
    
    func setupData() {
        datasource = Sites.allCases.map { ListingModel(url: $0.rawValue)}
    }
    
    func fetchMetadata() {
        
    }
    
}
