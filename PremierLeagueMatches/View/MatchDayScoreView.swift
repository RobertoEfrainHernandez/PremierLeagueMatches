//
//  MatchDayScoreView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI


struct MatchDayScoreView: View {
  @EnvironmentObject var plTeamsStore: PLTeamsStore
  let match: MatchDay.Match
  
  var body: some View {
    let (homeTeam, awayTeam) = plTeamsStore.getHomeAwayTeamPair(with: "\(match.homeTeam.id)", and: "\(match.awayTeam.id)")
    let score = plTeamsStore.getFinalScore(with: match)
    
    return HStack(alignment: .center) {
      TeamCrestView(team: homeTeam)
      Spacer()
      
      Text(score)
        .font(.title2)
        .bold()
        .foregroundColor(.white)
      
      Spacer()
      TeamCrestView(team: awayTeam)
    }
    .padding(.horizontal)
  }
}

struct TeamCrestView: View {
  let team: PLTeams.PLTeam
  
  var body: some View {
    VStack(alignment: .center, spacing: 8) {
      SVGImage(url: URL(string: team.crestUrl)!)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
      
      Text(team.shortName)
        .lineLimit(1)
        .font(.subheadline)
        .foregroundColor(.white)
    }
    .frame(maxWidth: 100, maxHeight: 100)
    
  }
}
