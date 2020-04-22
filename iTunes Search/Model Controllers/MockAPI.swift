//
//  MockAPI.swift
//  iTunes Search
//
//  Created by Jessie Ann Griffin on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class MockAPI: NetworkController {
    func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().async {
            
            let goodResultData = """
            {
              "resultCount": 2,
              "results": [
                    {
                      "trackName": "GarageBand",
                      "artistName": "Apple",
                    },
                    {
                      "trackName": "Garage Virtual Drumset Band",
                      "artistName": "Nexogen Private Limited",
                    }
                ]
            }
            """.data(using: .utf8)!
            
            completion(goodResultData, nil)
        }
    }
}
