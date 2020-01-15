//
//  CountriesCell.swift
//  Countries-CollectionViewLab
//
//  Created by David Lin on 1/14/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit
import ImageKit

class CountriesCell: UICollectionViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    func configureCell(country: Countries) {
        countryNameLabel.text = country.name
        countryCapitalLabel.text = country.capital
        populationLabel.text = "Population: \(country.population.description)"
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"

        flagImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.flagImage.image = image
                }
            }
        }
    }
}
