//
//  CityDetailTableViewCell.swift
//  Assignment
//
//  Created by Ravneet on 20/04/21.
//

import UIKit

class CityDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWithModel(model: CityDetail) {
        self.cityNameLabel.text = model.name
        self.stateNameLabel.text = model.stateName
        self.countryNameLabel.text = model.countryName
    }
}
