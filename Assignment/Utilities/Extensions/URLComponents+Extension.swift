//
//  Extensions.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
