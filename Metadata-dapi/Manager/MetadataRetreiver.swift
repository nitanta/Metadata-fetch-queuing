//
//  MetadataManager.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/20/21.
//

import Foundation
import Combine

protocol MetadataRetreiveProtocol {
    init(urls: [String])
    func fetchMetadata()
    var datasource: CurrentValueSubject<[ListingModel], Error> { get set }
}


final class MetadataRetreiver: MetadataRetreiveProtocol {
    
    /// Datasource for populating the view
    var datasource: CurrentValueSubject<[ListingModel], Error> = CurrentValueSubject([])
    /// List of urls for making network calls
    private let urls: [String]
    
    /// Disposebag
    private var bag = Set<AnyCancellable>()
    
    /// Operation queue for serializing requests
    var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "DapiOperationQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    init(urls: [String]) {
        self.urls = urls
        self.datasource.send(urls.map { ListingModel(url: $0) })
    }
    
    /// Make the network calls for all the urls. Uses operation queue for it.
    func fetchMetadata() {
        self.urls.forEach { url in
            let fetchOperation = MetadataFetchOperation(client: APIClient(), url: url.correctLink())
            let callValueHandler: (State) -> Void = { [weak self] state in
                guard let self = self else { return }
                let model = ListingModel(url: url, state: state)
                self.updateDatasource(model: model)
            }
            fetchOperation.$requestState.sink(receiveValue: callValueHandler).store(in: &bag)
            operationQueue.addOperation(fetchOperation)
        }
    }
    
    /// Update the datasource
    /// - Parameter model: ListingModel that is used to replace the old model
    private func updateDatasource(model: ListingModel) {
        var lists = datasource.value
        if let index = lists.firstIndex(where: {$0.url == model.url}) {
            lists[index] = model
            datasource.send(lists)
        }
    }
}
