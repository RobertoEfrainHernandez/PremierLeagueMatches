//
//  MatchedGeoMatchDayScoreView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/28/21.
//

import SwiftUI

struct MatchedGeoMatchDayScoreView: View {
  @Environment(\.colorScheme) var colorScheme
  @Binding var show: Bool
  var match: MatchDay.Match
  var namespace: Namespace.ID
  
  var body: some View {
    MatchDayScoreView(match: match)
      .matchedGeometryEffect(id: match.id, in: namespace, isSource: !show)
      .offset(y: 0)
      .frame(width: 335, height: 200)
      .background(colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue)
      .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
      .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
  }
}
