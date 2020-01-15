//
//  Countries.swift
//  Countries-CollectionViewLab
//
//  Created by David Lin on 1/15/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation

struct Countries: Codable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    let alpha2Code: String
}
