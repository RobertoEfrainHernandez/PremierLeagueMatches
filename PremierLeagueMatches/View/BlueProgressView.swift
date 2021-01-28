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
      .progressViewStyle(BlueShadowProgressViewStyle())
      .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue))
      .scaleEffect(1.8, anchor: .center)
  }
}

struct BlueShadowProgressViewStyle: ProgressViewStyle {
  @Environment(\.colorScheme) var colorScheme
  
  func makeBody(configuration: Configuration) -> some View {
    ProgressView(configuration)
      .shadow(color: colorScheme == .dark ? Constants.darkModeBlue.opacity(0.3) : Constants.lightModeBlue.opacity(0.3),
              radius: 4.0, x: 1.0, y: 2.0)
  }
}

struct BlueProgressView_Previews: PreviewProvider {
  static var previews: some View {
    BlueProgressView()
  }
}
