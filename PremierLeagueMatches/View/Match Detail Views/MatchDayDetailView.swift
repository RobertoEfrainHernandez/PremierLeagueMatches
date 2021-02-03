//
//  MatchDayDetailView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/27/21.
//

import SwiftUI

struct MatchDayDetailView: View {
  @Environment(\.colorScheme) var colorScheme
  var match: MatchDay.Match
  var namespace: Namespace.ID
  
  var body: some View {
    VStack {
      ScrollView {
        MatchDayScoreView(match: match)
          .offset(y: 40)
          .frame(height: 275)
          .background(blueColor)
          .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
          .customShadow(blueColor)
          .matchedGeometryEffect(id: match.id, in: namespace)
      }
      
      //TODO:- Add UI content that displays Match Details
    }
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    .matchedGeometryEffect(id: "container\(match.id)", in: namespace)
    .edgesIgnoringSafeArea(.vertical)
  }
  
  private var blueColor: Color {
    colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue
  }
}
