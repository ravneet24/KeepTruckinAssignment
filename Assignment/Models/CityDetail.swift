//
//  CityDetail.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation

struct SearchCityAPIResponse: Decodable {
    var cities: [CityDetail]?
   
    private enum CodingKeys : String, CodingKey {
        case cities = "geonames"
    }
}

struct CityDetail: Decodable {
    var name: String?
    var countryName: String?
    var stateName: String?
   
    private enum CodingKeys : String, CodingKey {
           case name, countryName, stateName = "adminName1"
       }
}
