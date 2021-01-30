//
//  CloseButton.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/27/21.
//

import SwiftUI

struct CloseButton: View {
  var body: some View {
    Image(systemName: "xmark")
      .font(.system(size: 17, weight: .bold))
      .foregroundColor(.white)
      .padding(.all, 10)
      .background(Color.black.opacity(0.8))
      .mask(Circle())
      .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
      .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
  }
}

struct CloseButton_Previews: PreviewProvider {
  static var previews: some View {
    CloseButton()
  }
}
