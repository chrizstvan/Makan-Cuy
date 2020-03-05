//
//  Models.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 29/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import CoreLocation

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
    let distance: Double
    let id: String
    
    static var numberFormater: NumberFormatter{
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
    }
    
    var formattedDistance: String?{
        return WarungListViewModel.numberFormater.string(from: distance as NSNumber)
    }
}

extension WarungListViewModel {
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1609.355
    }
}

struct Details: Decodable {
    let price: String
    let phone: String
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Decodable {
    enum CodingKeys: CodingKey {
        case longitude
        case latitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitudete = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitudete, longitude: longitude)
    }
}
