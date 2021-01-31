//
//  MatchDayListNumbersScrollView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/30/21.
//

import SwiftUI

struct MatchDayListNumbersScrollView: View {
<<<<<<< HEAD
  @ObservedObject var plMatchDayVM: PLMatchDayViewModel
=======
  @ObservedObject var plMatchDayStore: PLMatchDayStore
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8
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
<<<<<<< HEAD
              plMatchDayVM.loadMatches(basedOn: numbers[index].id)
=======
              plMatchDayStore.loadMatches(basedOn: numbers[index].id)
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8
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
