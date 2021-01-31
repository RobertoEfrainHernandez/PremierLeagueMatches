//
//  Modifiers.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/31/21.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
  let color: Color
  let r1: CGFloat
  let r2: CGFloat
  
  func body(content: Content) -> some View {
    content
      .shadow(color: color.opacity(0.3), radius: r1, x: 0, y: r1 / 2)
      .shadow(color: color.opacity(0.2), radius: r2, x: 0, y: r2 / 2)
  }
}

extension View {
  func customShadow(_ color: Color, r1: CGFloat = 12, r2: CGFloat = 6) -> some View {
    self.modifier(ShadowModifier(color: color, r1: r1, r2: r2))
  }
}
