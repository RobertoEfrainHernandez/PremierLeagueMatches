//
//  PremierLeagueMatchesApp.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

@main
struct PremierLeagueMatchesApp: App {
  @ObservedObject var plTeamsStore = PLTeamsStore()
  
    var body: some Scene {
        WindowGroup {
            MatchDayListView()
              .environmentObject(plTeamsStore)
        }
    }
}
