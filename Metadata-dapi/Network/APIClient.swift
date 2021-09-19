//
//  APIClient.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import Foundation
import Combine

class APIClient {
    
    public typealias CallData = (String, String) // FaviconURL, Size
    
    // MARK: - Request data
    
    /// Get data for the endpoint
    /// - Parameter endpoint: endpoint
    /// - Returns: publisher containing either data(i.e Favicon url and data size)  or error
    func getData(from endpoint: String) -> AnyPublisher<CallData, Error> {
        guard let request = prepareRequest(for: endpoint) else {
            return Fail(error: NSError(
                            domain: "com.metadata-dapi.com",
                            code: 400,
                            userInfo: ["message": "Malformed request"])
            )
            .eraseToAnyPublisher()
        }
        
        return loadData(with: request)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Request building
    
    /// Build the url request for the endpoint
    /// - Parameter endpoint: url
    /// - Returns: urlrequest for the endpoint
    private func prepareRequest(for endpoint: String) -> URLRequest? {
        guard let url = URL(string: endpoint) else {
            return nil
        }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadRevalidatingCacheData,
                                    timeoutInterval: 30)
        urlRequest.httpMethod = "get"
        return urlRequest
    }
    
    // MARK: - Getting data
    
    
    /// Perform network call and load data
    /// - Parameter request: url request
    /// - Returns: publisher containing either data(i.e Favicon url and data size) or error
    private func loadData(with request: URLRequest) -> AnyPublisher<CallData, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ error -> Error in
                return error
            })
            .map {
                debugPrint("RESPONSE:: ", $0.response)
                debugPrint("String data:: ", $0.data.prettyPrintedString as Any)
                return (String(format: "%@/favicon.ico", request.url!.absoluteString), $0.data.sizeString())
            }
            .eraseToAnyPublisher()
    }
}
