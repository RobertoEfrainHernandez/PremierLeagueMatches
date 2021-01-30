//
//  ContentView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct MatchDayListView: View {
  @EnvironmentObject var plTeamsStore: PLTeamsStore
  @Environment(\.colorScheme) var colorScheme
  @StateObject private var plMatchDayStore = PLMatchDayStore()
  @Namespace var namespace
  @State private var selectedMatch: MatchDay.Match? = nil
  @State private var show = false
  @State private var isDisabled = false
  
  var body: some View {
    ZStack {
      VStack {
        MatchDayListHeaderView(plMatchDayStore: plMatchDayStore)
        
        ScrollView {
          VStack(alignment: .center, spacing: 24) {
            if plMatchDayStore.loading {
              BlueProgressView()
                .offset(y: 100)
            } else {
              ForEach(plMatchDayStore.matches) { match in
                VStack {
                  MatchedGeoMatchDayScoreView(show: $show, match: match, namespace: namespace)
                    .onTapGesture {
                      withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                        show.toggle()
                        selectedMatch = match
                        isDisabled = true
                      }
                    }
                    .disabled(isDisabled)
                }
                .matchedGeometryEffect(id: "container\(match.id)", in: namespace, isSource: !show)
              }
            }
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical)
        }
      }
      .zIndex(1)
      
      if selectedMatch != nil {
        ZStack(alignment: .topTrailing) {
          MatchDayDetailView(match: selectedMatch!, namespace: namespace)
          CloseButton()
            .padding(.trailing, 16)
            .onTapGesture {
              withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                show.toggle()
                selectedMatch = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  isDisabled = false
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
