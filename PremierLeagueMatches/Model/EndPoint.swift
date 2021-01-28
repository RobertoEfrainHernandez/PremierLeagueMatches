//
//  EndPoint.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation

struct EndPoint {
  var path: String
  var queryItems: [URLQueryItem] = []
}

extension EndPoint {
  var url: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.football-data.org"
    components.path = "/" + path
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    
    guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
    
    return url
  }
  
  var urlRequest: URLRequest {
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField:"Content-Type")
    request.addValue(Constants.apiKey, forHTTPHeaderField: "X-Auth-Token")
    return request
  }
}

extension EndPoint {
  static var plTeams: Self {
    EndPoint(path: "v2/competitions/PL/teams")
  }
  
  static func plMatches(withMatchDayID id: Int) -> Self {
    EndPoint(path: "v2/competitions/PL/matches", queryItems: [URLQueryItem(name: "matchday", value: String(id))])
  }
}
