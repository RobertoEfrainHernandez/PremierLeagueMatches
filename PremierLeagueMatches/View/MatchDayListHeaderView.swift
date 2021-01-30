//
//  MatchDayListHeaderView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct NumberModel: Identifiable {
  let id: Int
  var isSelected: Bool = false
}

struct MatchDayListHeaderView: View {
  @ObservedObject var plMatchDayStore: PLMatchDayStore
  @State private var numbers = (1...38).map { NumberModel(id: $0) }
  @State private var currSelectedIndex = 0
  
  
  var body: some View {
    VStack {
      HStack {
        Text("Premier League Match Day \(currSelectedIndex + 1)")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 5)
          .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 0, y: 2)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding([.horizontal, .top])
      
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
                plMatchDayStore.loadMatches(basedOn: numbers[index].id)
              }
            }
          }
          .offset(y: -10)
        }
        .frame(maxHeight: 100)
        .padding(.horizontal)
      }
    }
    .onAppear {
      numbers[currSelectedIndex].isSelected = true
    }
  }
}


