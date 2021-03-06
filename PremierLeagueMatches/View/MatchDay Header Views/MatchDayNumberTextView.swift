//
//  MatchDayNumberTextView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/29/21.
//

import SwiftUI

struct MatchDayNumberTextView: View {
  @Environment(\.colorScheme) var colorScheme
  @Binding var numbers: [NumberModel]
  var index: Int
  let action: () -> Void
  
  var body: some View {
    Text("\(numbers[index].id)")
      .font(.subheadline)
      .foregroundColor(numbers[index].isSelected ? .white : .primary)
      .frame(width: 75.0, height: 50.0)
      .overlay(
        RoundedRectangle(cornerRadius: 18, style: .continuous)
          .stroke(numbers[index].isSelected ? blueColor : .primary, lineWidth: 4)
      )
      .background(numbers[index].isSelected ? blueColor : Color.clear)
      .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
      .customShadow(numbers[index].isSelected ? blueColor : .primary)
      .onTapGesture {
        action()
      }
  }
  
  private var blueColor: Color {
    colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue
  }
}
