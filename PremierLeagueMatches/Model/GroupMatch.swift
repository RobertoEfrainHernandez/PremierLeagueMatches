//
//  GroupMatch.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import Foundation

struct GroupMatch: Identifiable, Comparable {
  static func < (lhs: GroupMatch, rhs: GroupMatch) -> Bool {
    lhs.id < rhs.id
  }
  
  let id: Date
  let date: String
  var matches: [MatchDay.Match]
}
