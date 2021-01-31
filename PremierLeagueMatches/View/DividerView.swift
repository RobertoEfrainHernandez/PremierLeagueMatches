//
//  DividerView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import SwiftUI

struct DividerView: View {
  let color: Color
  
  var body: some View {
    color
      .frame(height: 1)
      .clipShape(RoundedRectangle(cornerRadius: 1, style: .continuous))
      .customShadow(color, r1: 8, r2: 4)
  }
}
