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
  @State var show = false
  
  var body: some View {
    ZStack {
      VStack {
        MatchDayListHeaderView(plMatchDayStore: plMatchDayStore)
        
        ScrollView {
          VStack(alignment: .center, spacing: 24) {
            ForEach(plMatchDayStore.matches) { match in
              MatchDayScoreView(match: match)
                .matchedGeometryEffect(id: match.id, in: namespace, isSource: !show)
                .frame(width: 335, height: 200)
                .background(colorScheme == .dark ? Constants.darkModeBkgrd : Constants.lightModeBkgrd)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                .onTapGesture {
                  withAnimation(.spring()) {
                    show.toggle()
                    selectedMatch = match
                  }
                }
            }
          }
          .frame(maxWidth: .infinity)
        }
      }
      
      if selectedMatch != nil {
        ScrollView {
          MatchDayScoreView(match: selectedMatch!)
            .matchedGeometryEffect(id: selectedMatch!.id, in: namespace)
            .frame(height: 275)
            .background(colorScheme == .dark ? Constants.darkModeBkgrd : Constants.lightModeBkgrd)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
            .onTapGesture {
              withAnimation(.spring()) {
                show.toggle()
                selectedMatch = nil
              }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
        .background(colorScheme == .dark ? Color.black : Color.white)
      }
    }
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
