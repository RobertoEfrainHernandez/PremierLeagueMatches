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
      .customShadow(Color.black)
  }
}

struct CloseButton_Previews: PreviewProvider {
  static var previews: some View {
    CloseButton()
  }
}
