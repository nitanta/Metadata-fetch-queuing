//
//  MetadataFetchService.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation
import Combine

/// State for each operation
enum State: Hashable {
    case idle
    case running
    case successful(String, String) // Favicon url and data size
    case failed(Int) // error code
}

final class MetadataFetchOperation: Operation {
    
    override var isAsynchronous: Bool { return true }
    
    private var _isExecuting = false {
        willSet { willChangeValue(forKey: "isExecuting")}
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    
    override var isExecuting: Bool {
        return _isExecuting
    }
    
    private var _isFinished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    
    override var isFinished: Bool {
        return _isFinished
    }
    
    /// Handles the network call
    private let client: APIClient
    /// The url to be fetched
    private let url: String
    /// Dispose bag
    private var bag = Set<AnyCancellable>()
    /// Different states for the request
    @Published private(set) var requestState: State = .idle
    
    init(client: APIClient, url: String) {
        self.client = client
        self.url = url
        super.init()
    }
    
    override func start() {
        // For asynchronous operations, check the isCancelled state before performing work
        guard !isCancelled else { return }
        
        self.requestState = .running
        
        let callCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            guard let self = self else { return }
            defer { self._isFinished = true }
            switch completion {
            case .failure(let error as NSError):
                self.requestState = .failed(error.code)
            case .finished: break
            }
        }
        
        let callValueHandler: (APIClient.CallData) -> Void = { [weak self] response in
            guard let self = self else { return }
            self.requestState = .successful(response.0, response.1)
        }
        
        client.getData(from: url).sink(receiveCompletion: callCompletionHandler, receiveValue: callValueHandler).store(in: &bag)
        _isExecuting = true
    }
    
    override func cancel() {
        self.requestState = .failed(0)
        _isFinished = true
    }
    
}

