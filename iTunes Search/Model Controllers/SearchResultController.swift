//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Spencer Curtis on 8/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkController {
    // protocol = language (how you communicate) used and the inside is the message
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

class SearchResultController {
    
    enum PerformSearchError: Error {
        case invalidURLComponents(URLComponents?)
        case noDataReturned
        case invalidJSON(Data)
    }
    
    func performSearch(for searchTerm: String,
                       resultType: ResultType,
                       session: NetworkController,
                       completion: @escaping (Result<[SearchResult], PerformSearchError>) -> Void) {
        
        // Creating the URL components.
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let parameters = [
            "term": searchTerm,
            "entity": resultType.rawValue]
        // Map iterates over ever element -> compact takes the nil values out
        let queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        // Make sure that urlComponents can give us a valid URL.
        guard let requestURL = urlComponents?.url else {
            completion(.failure(.invalidURLComponents(urlComponents)))
            return
        }

        // Creating the GET request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Fetching the information from the network
        
        session.perform(request: request) { (possibleData, possibleError) in
            
            // Make sure the data exists.
            if let error = possibleError { NSLog("Error fetching data: \(error)") }
            guard let data = possibleData else {
                completion(.failure(.noDataReturned))
                return
            }
            
            // We know the 'data' exists. (in binary format)
            // Attempt to decode the data.
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                completion(.success(searchResults.results))
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(.failure(.invalidJSON(data)))
            }
        }
    }
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
//    var searchResults: [SearchResult] = []
}
