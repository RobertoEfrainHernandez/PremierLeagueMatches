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
          .customShadow(Color.primary)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding()
    }
    
  }
}


