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
      .background(Color(.systemGray))
      .mask(Circle())
  }
}

struct CloseButton_Previews: PreviewProvider {
  static var previews: some View {
    CloseButton()
  }
}
