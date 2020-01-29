//
//  NetworkService.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 29/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "0JWOh7pBFo6GTS27h5dNlfvs9PRiRSnUVJr04ocIt1_KPJkxCQwBhm7_lmL74Q5LHMsitvNe6N8TvVY476XpqJ0jqREko_4TZ9o_1m9itdlxIxOiBtHlX6VThsIwXnYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long):
                return.requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
