//
//  PLTeamsStore.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import Combine

class PLTeamsStore: ObservableObject {
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
  
  func getTeams() -> [PLTeams.PLTeam] {
    var result = [PLTeams.PLTeam]()
    for (_, v) in teamsDict {
      result.append(v)
    }
    return result
  }
  
  func getHomeAwayTeamPair(with homeId: String, and awayId: String) -> (homeTeam: PLTeams.PLTeam, awayTeam: PLTeams.PLTeam) {
    (teamsDict[homeId]!, teamsDict[awayId]!)
  }
  
  func getFinalScore(with matchDayScore: MatchDay.Match.Score.ExtraTime) -> (homeScore: Int?, awayScore: Int?) {
    (matchDayScore.homeTeam, matchDayScore.awayTeam)
  }
}
