//
//  PLTeamsStore.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import Combine

class PLTeamsViewModel: ObservableObject {
  @Published private var teamsDict = [String: PLTeams.PLTeam]()
  private var cancellables = Set<AnyCancellable>()
  
  init(modelLoader: ModelLoader<PLTeams> = ModelLoader<PLTeams>()) {
    modelLoader
      .loadModel(with: EndPoint.plTeams.urlRequest)
      .sink(receiveCompletion: {completion in
        switch completion{
          case .finished: break
          case .failure(let error): print(error.localizedDescription)
        }
      }, receiveValue: { [self] plTeams in
        plTeams.teams.forEach { teamsDict.updateValue($0, forKey: "\($0.id)") }
    })
      .store(in: &cancellables)
  }
  
  /// Helper method for testing purposes to ensure we're recieving the PL Teams from the API
  /// - Returns: Any array of PL Teams
  func getTeams() -> [PLTeams.PLTeam] {
    var result = [PLTeams.PLTeam]()
    for (_, v) in teamsDict {
      result.append(v)
    }
    return result
  }
  
  /// Helper Method for getting a home and an away team from the Team Dictionary
  /// - Parameters:
  ///   - homeId: Home Team Id provided from a match
  ///   - awayId: Away Team Id provided from a match
  /// - Returns: Tuple containing the Home and Away Team
  func getHomeAwayTeamPair(with homeId: String, and awayId: String) -> (homeTeam: PLTeams.PLTeam, awayTeam: PLTeams.PLTeam) {
    (teamsDict[homeId]!, teamsDict[awayId]!)
  }
  
  /// Helper Method for getting a home and an away team score to display in MatchDayScoreView
  /// - Parameter matchDayScore: A particular Match
  /// - Returns: String the displays teams score based on the status of a match
  func getFinalScore(with match: MatchDay.Match) -> String {
    switch match.status {
      case .finished:
        let homeScore = match.score.fullTime.homeTeam
        let awayScore = match.score.fullTime.awayTeam
        return "\(homeScore ?? 0) - \(awayScore ?? 0)"
      case .scheduled: return "vs."
<<<<<<< HEAD:PremierLeagueMatches/ViewModel/PLTeamsViewModel.swift
      case .live: return "Live"
      case .inPlay: return "In Play"
      case .paused: return "Paused"
      case .postponed: return "Postponed"
      case .suspended: return "Suspended"
      case .canceled: return "Canceled"
=======
      case .live: return "Live Match"
      case .inPlay: return "Match In Play"
      case .paused: return "Match Paused"
      case .postponed: return "Match Postponed"
      case .suspended: return "Match Suspended"
      case .canceled: return "Match Canceled"
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8:PremierLeagueMatches/ViewModel/PLTeamsStore.swift
    }
  }
}
