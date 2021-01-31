//
//  MatchDayHeaderView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import SwiftUI

struct MatchDayHeaderView: View {
  var title: String
  var color: Color
  
  var body: some View {
    HStack(alignment: .center, spacing: 10.0) {
      DividerView(color: color)
      Text(title)
        .font(.headline)
        .bold()
        .foregroundColor(Color.primary)
        .customShadow(Color.primary, r1: 8, r2: 4)
      DividerView(color: color)
    }
    .padding()
  }
}
