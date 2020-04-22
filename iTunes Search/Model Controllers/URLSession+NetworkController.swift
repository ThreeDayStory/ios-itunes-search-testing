//
//  URLSession+NetworkController.swift
//  iTunes Search
//
//  Created by Jessie Ann Griffin on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

// URLSession knows how to behave like a network controller
extension URLSession: NetworkController {
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {

        let dataTask = self.dataTask(with: request) { possibleData, _, possibleError in
            completion(possibleData, possibleError)
        }
        dataTask.resume()

    }
}
