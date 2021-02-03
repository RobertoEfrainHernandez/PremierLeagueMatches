//
//  MatchDayListNumbersScrollView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/30/21.
//

import SwiftUI

struct MatchDayListNumbersScrollView: View {
  @ObservedObject var plMatchDayVM: PLMatchDayViewModel
  @State private var numbers = (1...38).map { NumberModel(id: $0) }
  @Binding var currSelectedIndex: Int
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(alignment: .center, spacing: 16) {
        ForEach(numbers.indices) { index in
          MatchDayNumberTextView(numbers: $numbers, index: index) {
            /*
             Conditional for handling the selection of a Match Day and having the UI update and reflect those changes
             */
            if !numbers[index].isSelected {
              numbers[currSelectedIndex].isSelected = false
              currSelectedIndex = index
              numbers[index].isSelected = true
              plMatchDayVM.loadMatches(basedOn: numbers[index].id)
            }
          }
        }
        .offset(y: -10)
      }
      .frame(maxHeight: 100)
      .padding(.horizontal)
    }
    .onAppear {
      numbers[currSelectedIndex].isSelected = true
    }
  }
}
