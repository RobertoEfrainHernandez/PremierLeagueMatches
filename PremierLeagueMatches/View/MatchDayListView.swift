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
  @EnvironmentObject var plTeamsVM: PLTeamsViewModel
  @StateObject private var plMatchDayVM = PLMatchDayViewModel()
  @Environment(\.colorScheme) var colorScheme
  @State private var matchDayStates = MatchDayListStates()
  @Namespace var namespace
<<<<<<< HEAD
=======
  @State private var matchDayStates = MatchDayListStates()
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8
  
  var body: some View {
    ZStack {
      VStack {
        MatchDayListHeaderView(currSelectedIndex: $matchDayStates.currSelectedIndex)
<<<<<<< HEAD
        
        MatchDayListNumbersScrollView(plMatchDayVM: plMatchDayVM, currSelectedIndex: $matchDayStates.currSelectedIndex)
        
        MatchDayMatchesScrollView(plMatchDayVM: plMatchDayVM, matchDayStates: $matchDayStates, namespace: namespace, color: blueColor)
=======
        
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
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8
      }
      .zIndex(1)
      
      if matchDayStates.selectedMatch != nil {
        ZStack(alignment: .topTrailing) {
          MatchDayDetailView(match: matchDayStates.selectedMatch!, namespace: namespace)
<<<<<<< HEAD
          
=======
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8
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
  
  private var blueColor: Color {
    colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue
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
