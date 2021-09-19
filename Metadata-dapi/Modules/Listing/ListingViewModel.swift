//
//  ListingViewModel.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation
import Combine

struct ListingModel: Hashable, Equatable {
    var url: String
    var imageURL: String?
    var size: String?
    var statusCode: String?
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
    
    func fetchMetadata() {
        
//        let listCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
//            guard let self = self else { return }
//            switch completion {
//            case .failure(let error):
//                self.state = .error(error)
//            case .finished:
//                self.state = .finishedLoading
//            }
//        }
//
//        let listValueHandler: (PokemonListingResponse) -> Void = { [weak self] response in
//            guard let self = self else { return }
//            let data = response.results.map { ListingModel(name: $0.name, detailURL: $0.url)}
//            if self.offset == 0 {
//                self.datasource = data
//            } else {
//                self.datasource.append(contentsOf: data)
//            }
//            self.hasMore = self.offset + self.limit <= response.count
//            self.offset += self.limit
//        }
//
//        service.fetchPokemonList(limit: limit, offset: offset).sink(receiveCompletion: listCompletionHandler, receiveValue: listValueHandler).store(in: &bag)
    }
    
}
