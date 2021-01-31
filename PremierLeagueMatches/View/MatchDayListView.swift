//
//  ContentView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct MatchDayListStates {
  var currSelectedIndex = 0
  var show = false
  var isDisabled = false
  var selectedMatch: MatchDay.Match? = nil
}

struct MatchDayListView: View {
  @EnvironmentObject var plTeamsStore: PLTeamsStore
  @Environment(\.colorScheme) var colorScheme
  @StateObject private var plMatchDayStore = PLMatchDayStore()
  @Namespace var namespace
  @State private var matchDayStates = MatchDayListStates()
  
  var body: some View {
    ZStack {
      VStack {
        MatchDayListHeaderView(currSelectedIndex: $matchDayStates.currSelectedIndex)
        
        MatchDayListNumbersScrollView(plMatchDayStore: plMatchDayStore, currSelectedIndex: $matchDayStates.currSelectedIndex)
        
        ScrollView {
          VStack(alignment: .center, spacing: 24) {
            if plMatchDayStore.loading {
              BlueProgressView()
                .offset(y: 100)
            } else {
              ForEach(plMatchDayStore.matches) { match in
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
          .frame(maxWidth: .infinity)
          .padding(.vertical)
        }
      }
      .zIndex(1)
      
      if matchDayStates.selectedMatch != nil {
        ZStack(alignment: .topTrailing) {
          MatchDayDetailView(match: matchDayStates.selectedMatch!, namespace: namespace)
          CloseButton()
            .padding(.trailing, 16)
            .onTapGesture {
              withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                matchDayStates.show.toggle()
                matchDayStates.selectedMatch = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  matchDayStates.isDisabled = false
                }
              }
            }
        }
          .zIndex(2)
      }
    }
    .edgesIgnoringSafeArea(.bottom)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MatchDayListView()
      MatchDayListView()
        .preferredColorScheme(.dark)
    }
  }
}
