//
//  MatchDay.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct MatchDay: Decodable {
  let count: Int
  let filters: Filters
  var matches: [Match]

  struct Filters: Decodable {
    var matchday: String
  }

  struct Match: Identifiable, Decodable {
    let id: Int
    let utcDate: String
    let season: Season
    let status: MatchStatus
    let score: Score
    let matchday: Int
    let homeTeam, awayTeam: Area

    struct Season: Decodable {
        let id: Int
        let startDate, endDate: String
        let currentMatchday: Int
    }

    struct Score: Decodable {
        let winner: String?
        let duration: String
        let fullTime, halfTime, extraTime, penalties: ExtraTime

      struct ExtraTime: Decodable {
          let homeTeam, awayTeam: Int?
      }
    }

    struct Area: Decodable {
        let id: Int
        let name: String
    }
  }
}

enum MatchStatus: String, Decodable {
  case finished = "FINISHED"
  case scheduled = "SCHEDULED"
  case live = "LIVE"
  case inPlay = "IN_PLAY"
  case paused = "PAUSED"
  case postponed = "POSTPONED"
  case suspended = "SUSPENDED"
  case canceled = "CANCELED"
}
