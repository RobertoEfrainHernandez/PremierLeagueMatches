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
          .matchedGeometryEffect(id: match.id, in: namespace)
          .offset(y: 40)
          .frame(height: 275)
          .background(colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue)
          .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
          .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
      }
      
      //TODO:- Add UI content that displays Match Details
    }
    .background(colorScheme == .dark ? Color.black : Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    .matchedGeometryEffect(id: "container\(match.id)", in: namespace)
    .edgesIgnoringSafeArea(.vertical)
  }
}
