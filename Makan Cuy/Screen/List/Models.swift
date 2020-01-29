//
//  Models.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 29/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation

struct Root: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
}

struct WarungListViewModel {
    let name: String
    let imageUrl: URL
    let distance: String
    let id: String
}

extension WarungListViewModel {
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = "\(business.distance / 1609.355)"
    }
}
