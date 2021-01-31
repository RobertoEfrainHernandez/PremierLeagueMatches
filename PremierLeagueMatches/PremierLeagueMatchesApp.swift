//
//  PremierLeagueMatchesApp.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

@main
struct PremierLeagueMatchesApp: App {
  @ObservedObject var plTeamsVM = PLTeamsViewModel()
  
  var body: some Scene {
    WindowGroup {
      MatchDayListView()
        .environmentObject(plTeamsVM)
    }
  }
}
