//
//  PLTeam.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct PLTeams: Decodable {
  let teams: [PLTeam]
  
  struct PLTeam: Identifiable, Decodable {
    let id: Int
    let name, shortName, tla, crestUrl: String
  }
}
