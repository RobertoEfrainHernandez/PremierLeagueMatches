//
//  BlueProgressView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/28/21.
//

import SwiftUI

struct BlueProgressView: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    ProgressView()
      .progressViewStyle(BlueShadowProgressViewStyle(color: blueColor))
      .progressViewStyle(CircularProgressViewStyle(tint: blueColor))
      .scaleEffect(1.8, anchor: .center)
  }
  
  private var blueColor: Color {
    colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue
  }
}

struct BlueShadowProgressViewStyle: ProgressViewStyle {
  var color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    ProgressView(configuration)
      .customShadow(color, r1: 8, r2: 4)
  }
}

struct BlueProgressView_Previews: PreviewProvider {
  static var previews: some View {
    BlueProgressView()
  }
}
