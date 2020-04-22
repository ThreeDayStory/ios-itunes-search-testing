//
//  MockAPI.swift
//  iTunes Search
//
//  Created by Jessie Ann Griffin on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class MockAPI: NetworkController {
    
    let data: Data
    init(data: Data) {
        self.data = data // adds dependency injection at initializer level
    }
    
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        
        DispatchQueue.global().async {
            completion(self.data, nil)
        }
    }
}
