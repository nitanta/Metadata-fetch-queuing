//
//  ListingViewModel.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation
import Combine

/// Enum for datasource
enum Sites: String, CaseIterable {
    case apple          = "https://www.apple.com"
    case spacex         = "https://www.spacex.com"
    case dapi           = "https://www.dapi.co"
    case facebook       = "https://www.facebook.com"
    case microsoft      = "https://www.microsoft.com"
    case amazon         = "https://www.amazon.com"
    case boomsupersonic = "https://www.boomsupersonic.com"
    case twitter        = "https://www.twitter.com"
}

/// Model for populating the cells
struct ListingModel: Hashable, Equatable {
    var url: String
    var state: State = .idle
}

final class ListingViewModel {
    
    /// States for the viewcontroller
    enum ViewModelState {
        case start
        case loading
        case finishedLoading
        case error(Error)
    }
    
    enum Section { case contents }
    
    private let service: MetadataRetreiveProtocol
    private var bag = Set<AnyCancellable>()
    
    @Published private(set) var datasource: [ListingModel] = []
    @Published private(set) var state: ViewModelState = .start
    
    
    init(service: MetadataRetreiveProtocol) {
        self.service = service
        setupObservers()
    }
    
    /// Add observers to listen to changes in the datasource
    func setupObservers() {
        let callCompletionHandler: (Subscribers.Completion<Error>) -> Void = { _ in }
        
        let callValueHandler: ([ListingModel]) -> Void = { [weak self] response in
            guard let self = self else { return }
            self.datasource = response
        }
        
        service.datasource.sink(receiveCompletion: callCompletionHandler, receiveValue: callValueHandler).store(in: &bag)
    }
    
    /// Perform request to fetch the metadata
    func fetchMetadata() {
        state = .loading
        service.fetchMetadata()
    }
    
}
