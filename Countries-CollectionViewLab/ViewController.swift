//
//  ViewController.swift
//  Countries-CollectionViewLab
//
//  Created by David Lin on 1/14/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    private var countries = [Countries]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "America"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        countrySearchBar.delegate = self
        searchCountry(search: searchQuery)
    }
    
    func searchCountry(search: String) {
        CountriesAPIClient.getCountries(for: search) {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self?.countries = data
            }
        }
    }
    
    
    
    func loadData(search: String) {
        CountriesAPIClient.getCountries(for: search) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self.countries = data
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedCountryVC = segue.destination as? CountriesDVC,
            let indexPath = collectionView.indexPathsForSelectedItems!.first else {
                fatalError()
        }
        let country = countries[indexPath.row]
        detailedCountryVC.countriesDetail = country
    }
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountriesCell else {
            fatalError()
        }
        let country = countries[indexPath.row]
        cell.configureCell(country: country)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(indexPath)")
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchCountry(search: searchText)
    }
}
