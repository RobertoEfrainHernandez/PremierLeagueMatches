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
  let matches: [Match]

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

extension MatchDay.Match {
  func utcDateToString(_ formatter: DateFormatter = DateFormatter()) -> String {
    formatter.locale = Locale(identifier: "en_US_POSIX")
    let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)!
    let format = dateFormat.firstIndex(of: "a") == nil ? "yyyy.MM.dd' at 'HH:mm zzz" : "MMMM d, yyyy' at 'h:mm a"
    return createDateString(from: format, with: formatter)
  }
  
  func utcDateToDate(_ formatter: DateFormatter = DateFormatter()) -> Date {
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let utcConverted = formatter.date(from: utcDate) else {
      preconditionFailure("Invalid Date from UTC Date")
    }
    return utcConverted
  }
  
  private func createDateString(from format: String, with formatter: DateFormatter) -> String {
    let utcConverted = utcDateToDate(formatter)
    formatter.dateFormat = format
    return formatter.string(from: utcConverted)
  }
}

extension MatchDay.Match: Comparable {
  static func < (lhs: MatchDay.Match, rhs: MatchDay.Match) -> Bool {
    lhs.utcDateToDate() < rhs.utcDateToDate()
  }
  
  static func == (lhs: MatchDay.Match, rhs: MatchDay.Match) -> Bool {
    lhs.id == rhs.id
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
