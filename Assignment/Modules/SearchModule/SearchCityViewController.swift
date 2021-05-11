//
//  SearchCityViewController.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//


import UIKit

class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var searchCityTableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SearchCityViewModel = SearchCityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initVM()
    }
    
    func initView() {
        self.searchCityTableView.register(UINib(nibName: "CityDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CityDetailTableViewCell")
        searchCityTableView.estimatedRowHeight = 65
        searchCityTableView.rowHeight = UITableView.automaticDimension
        activityIndicator.isHidden = true
        
    }
    
    func initVM() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.searchCityTableView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.searchCityTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchCityTableView.reloadData()
            }
        }
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let enteredCityName: String = self.cityTextField.text, !enteredCityName.isEmpty {
            viewModel.fetchCitiesList(withCityName: enteredCityName)
        }
    }
}

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailTableViewCell", for: indexPath) as? CityDetailTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.configureCellWithModel(model: cellVM)
        
        return cell
    }
}

extension SearchCityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.searchCityTableView.alpha = 0.0
        return true
    }
}
