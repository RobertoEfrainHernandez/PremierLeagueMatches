//
//  MatchDayListHeaderView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct NumberModel: Identifiable {
  let id: Int
  var isSelected: Bool = false
}

struct MatchDayListHeaderView: View {
  @Binding var currSelectedIndex: Int
  
  var body: some View {
    VStack {
      HStack {
        Text("Premier League Match Day \(currSelectedIndex + 1)")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 5)
          .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 0, y: 2)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding()
    }
    
  }
}


