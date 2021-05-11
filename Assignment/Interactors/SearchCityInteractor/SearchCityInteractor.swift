//
//  SearchCityInteractor.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation

protocol SearchCityInteractorDelegate: AnyObject {
    func didRecieveCitiesList(cities: [CityDetail])
    func didFailToReceiveCitiesList(errorMessage: String)
}

class SearchCityInteractor {
    
    weak var delegate: SearchCityInteractorDelegate?
    
    init(withDelegate delegate:SearchCityInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchCitiesList(withCityName name: String, maxRows: Int, userName: String) {
        
        NetworkWrapper.shared.getDataFromSearchCityAPI(withCityName: name, maxRows: maxRows, userName: userName) { [weak self] (result) in
            
            switch result {
            
            case .success(let response):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: response, options: [])
                    let response: SearchCityAPIResponse = try JSONDecoder().decode(SearchCityAPIResponse.self, from: data)
                    if let cities: [CityDetail] = response.cities, cities.count > 0 {
                        self?.delegate?.didRecieveCitiesList(cities: cities)
                    } else {
                        self?.delegate?.didFailToReceiveCitiesList(errorMessage: "City not found.")
                    }
                } catch {
                    self?.delegate?.didFailToReceiveCitiesList(errorMessage: "Fail to parse search city API Data")
                }
            case .failure(let error):
                self?.delegate?.didFailToReceiveCitiesList(errorMessage: error.localizedDescription)
            }
        }
    }
}
