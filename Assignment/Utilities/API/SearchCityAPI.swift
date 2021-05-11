//
//  SearchCityAPI.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation

struct SearchCityAPI {

    private let baseURL = URLList.baseURL
    
    let nameKey: String = "name_startsWith"
    let maxRowsKey: String = "maxRows"
    let userNameKey: String = "username"
    
    var name: String
    var maxRows: String
    var userName: String
    
    init(withCityName name: String, maxRows: Int, userName: String) {
        self.name = name
        self.maxRows = "\(maxRows)"
        self.userName = userName
    }
    
    func getUrl() -> String {
        return "\(baseURL)"
    }
    
    func getPath() -> String {
        return "\(URLList.searchCity)"
    }
    
    func getMethod() -> RequestMethod {
        return .get
    }
    
    func buildParameters() throws -> [String:String] {
        
        var params: [String: String] = [:]
        
        params.updateValue(self.name, forKey: nameKey)
        params.updateValue(self.maxRows, forKey: maxRowsKey)
        params.updateValue(self.userName, forKey: userNameKey)
        
        return params
    }
    
}
