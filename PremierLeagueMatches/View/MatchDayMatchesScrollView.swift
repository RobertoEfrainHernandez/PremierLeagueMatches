//
//  MatchDayMatchesScrollView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import SwiftUI

struct MatchDayMatchesScrollView: View {
  @ObservedObject var plMatchDayVM: PLMatchDayViewModel
  @Binding var matchDayStates: MatchDayListStates
  var namespace: Namespace.ID
  var color: Color
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .center, spacing: 24, pinnedViews: [.sectionHeaders]) {
        if plMatchDayVM.loading {
          BlueProgressView()
            .offset(y: 100)
        } else {
          ForEach(plMatchDayVM.groupMatches) { group in
            
            Section(header:
                      MatchDayHeaderView(title: group.date, color: color)
                      .background(Color(.systemBackground))
            ) {
              ForEach(group.matches) { match in
                VStack {
                  MatchedGeoMatchDayScoreView(show: $matchDayStates.show, match: match, namespace: namespace)
                    .onTapGesture {
                      withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                        matchDayStates.show.toggle()
                        matchDayStates.selectedMatch = match
                        matchDayStates.isDisabled = true
                      }
                    }
                    .disabled(matchDayStates.isDisabled)
                }
                .matchedGeometryEffect(id: "container\(match.id)", in: namespace, isSource: !matchDayStates.show)
              }
            }
          }
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
  }
}
