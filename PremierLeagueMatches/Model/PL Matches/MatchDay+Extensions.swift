//
//  MatchDay+Extensions.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import Foundation

//MARK:- Extensions ofr MATCHDAY

extension MatchDay {
  func groupMatches() -> [GroupMatch] {
    var result = [Date: GroupMatch]()
    matches.forEach { (match) in
      let (date, str) = match.dateOnly()
      result[date, default: GroupMatch(id: date, date: str, matches: [])].matches.append(match)
    }
    return result.map(\.value).sorted()
  }
}

//MARK:- Extensions for MATCHDAY.MATCH

extension MatchDay.Match {
  func utcDateToTime(_ formatter: DateFormatter = DateFormatter()) -> String {
    let dateFormat = localeFormat(for: formatter)
    let format = dateFormat.firstIndex(of: "a") == nil ? "HH:mm zzz" : "h:mm a"
    return createDateString(from: format, with: formatter)
  }
  
  func dateOnly(_ formatter: DateFormatter = DateFormatter()) -> (Date, String) {
    let dateFormat = localeFormat(for: formatter)
    let format = dateFormat.firstIndex(of: "a") == nil ? "yyyy.MM.dd" : "MMMM d, yyyy"
    let str = createDateString(from: format, with: formatter)
    let date = formatter.date(from: str)!
    return (date, str)
  }
  
  //MARK:- Private Methods
  private func localeFormat(for formatter: DateFormatter = DateFormatter()) -> String {
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)!
  }
  
  private func createDateString(from format: String, with formatter: DateFormatter) -> String {
    let utcConverted = utcDateToDate(formatter)
    formatter.dateFormat = format
    return formatter.string(from: utcConverted)
  }
  
  private func utcDateToDate(_ formatter: DateFormatter = DateFormatter()) -> Date {
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let utcConverted = formatter.date(from: utcDate) else {
      preconditionFailure("Invalid Date from UTC Date")
    }
    return utcConverted
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
