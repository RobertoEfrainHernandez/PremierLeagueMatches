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
      .offset(y: 0)
      .frame(width: 335, height: 200)
      .background(blueColor)
      .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
      .customShadow(blueColor)
      .matchedGeometryEffect(id: match.id, in: namespace, isSource: !show)
  }
  
  private var blueColor: Color {
    colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue
  }
}
