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
    case apple          = "apple.com"
    case spacex         = "spacex.com"
    case dapi           = "dapi.co"
    case facebook       = "facebook.com"
    case microsoft      = "microsoft.com"
    case amazon         = "amazon.com"
    case boomsupersonic = "boomsupersonic.com"
    case twitter        = "twitter.com"
}

/// Model for populating the cells
struct ListingModel: Hashable, Equatable {
    var url: String
    var state: State = .idle
}

protocol ListViewModelImplementable {
    init(service: MetadataRetreiveProtocol)
    func setupObservers()
    func fetchMetadata()
    var datasource: [ListingModel] { get set }
}

final class ListingViewModel: ListViewModelImplementable {
    
    /// States for the viewcontroller
    enum ViewModelState {
        case start
        case loading
        case finishedLoading
        case error(Error)
    }
    
    enum Section: String { case contents = "CONTENTS" }
    
    private let service: MetadataRetreiveProtocol
    private var bag = Set<AnyCancellable>()
    
    @Published var datasource: [ListingModel] = []
    @Published private(set) var state: ViewModelState = .start
    
    
    init(service: MetadataRetreiveProtocol) {
        self.service = service
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
