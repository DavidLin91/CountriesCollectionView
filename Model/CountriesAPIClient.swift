 //
 //  CountriesAPIClient.swift
 //  Countries-CollectionViewLab
 //
 //  Created by David Lin on 1/15/20.
 //  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
 //
 
 import Foundation
 import NetworkHelper
 
 struct CountriesAPIClient {
    static func getCountries(for search: String, completion: @escaping(Result<[Countries], AppError>) ->()) {
        let endpointURL = "https://restcountries.eu/rest/v2/name/\(search.lowercased())"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        var country = [Countries]()
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let countryData = try JSONDecoder().decode([Countries].self, from: data)
                    country = countryData
                    completion(.success(country))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
 }
