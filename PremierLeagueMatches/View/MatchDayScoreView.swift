//
//  MatchDayScoreView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct MatchDayScoreView: View {
  @EnvironmentObject var plTeamsStore: PLTeamsStore
  let match: MatchDay.Match
  
  var body: some View {
    let (homeTeam, awayTeam) = plTeamsStore.getHomeAwayTeamPair(with: "\(match.homeTeam.id)", and: "\(match.awayTeam.id)")
    let (homeScore, awayScore) = plTeamsStore.getFinalScore(with: match.score.fullTime)
    
    return HStack(alignment: .center) {
      TeamCrestView(team: homeTeam)
      Spacer()
      Text("\(homeScore ?? 0) - \(awayScore ?? 0)")
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
  let size: CGFloat = 75
  
  var body: some View {
    VStack(alignment: .center, spacing: 8) {
      WebImage(url: URL(string: team.crestUrl))
        .resizable()
        .renderingMode(.original)
        .placeholder {
          Circle()
            .foregroundColor(Color(.systemGray3).opacity(0.7))
            .overlay(
              Image(systemName: "photo")
                .renderingMode(.original)
                .font(.system(size: size / 3, weight: .regular, design: .rounded))
                .foregroundColor(.white)
          )
      }
      .scaledToFill()
      .frame(width: size, height: size)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
      .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
      
      Text(team.shortName)
        .font(.subheadline)
        .foregroundColor(.white)
    }
    .frame(maxWidth: 100, maxHeight: 100)

  }
}
