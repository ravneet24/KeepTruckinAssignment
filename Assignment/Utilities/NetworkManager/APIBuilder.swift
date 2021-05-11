//
//  APIBuilder.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation

struct APIBuilder {
    static func buildSearchCityAPI(withCityName name: String, maxRows: Int, userName: String) -> (SearchCityAPI,[String:String]?) {
        
        let apiObject = SearchCityAPI(withCityName: name, maxRows: maxRows, userName: userName)
        
        var params: [String:String]? {
            do {
                return  try apiObject.buildParameters()
            } catch  {
                print("Error building User List Params")
                return nil
            }
        }
       return (apiObject,params)
    }
}
