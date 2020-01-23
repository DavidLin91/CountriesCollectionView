//
//  CountriesDVC.swift
//  Countries-CollectionViewLab
//
//  Created by David Lin on 1/15/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class CountriesDVC: UIViewController {
    var countriesDetail: Countries!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryPopulation: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        countryNameLabel.text = countriesDetail.name
        countryCapitalLabel.text = countriesDetail.capital
        countryPopulation.text = countriesDetail.population.description
        
        let imageURL = "https://www.countryflags.io/\(countriesDetail.alpha2Code)/flat/64.png"
        
        countryFlagImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.countryFlagImage.image = image
                }
            }
        }
        
    }

}
