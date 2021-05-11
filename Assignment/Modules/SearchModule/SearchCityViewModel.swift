//
//  SearchCityViewModel.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import Foundation


/// For now taking these constant.
struct Constants {
    static let maxRows: Int = 10
    static let userName: String = "keep_truckin"
}

class SearchCityViewModel {
    
    var cities: [CityDetail] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var numberOfCells: Int {
        return cities.count
    }
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    
    
    
    lazy var interactor = SearchCityInteractor(withDelegate: self)
    
    func getCellViewModel( at indexPath: IndexPath ) -> CityDetail {
        return cities[indexPath.row]
    }
   
    func fetchCitiesList(withCityName name: String) {
        self.isLoading = true
        interactor.fetchCitiesList(withCityName: name, maxRows: Constants.maxRows, userName: Constants.userName)
    }
}

extension SearchCityViewModel: SearchCityInteractorDelegate {
    func didRecieveCitiesList(cities: [CityDetail]) {
        self.isLoading = false
        self.cities = cities
    }
    
    func didFailToReceiveCitiesList(errorMessage: String) {
        self.isLoading = false
        self.alertMessage = errorMessage
    }
    
    
}
