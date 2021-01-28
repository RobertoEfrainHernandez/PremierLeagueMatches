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
  @Environment(\.colorScheme) var colorScheme
  @ObservedObject var plMatchDayStore: PLMatchDayStore
  @State private var isSelected = true
  @State private var numbers = (1...38).map { NumberModel(id: $0) }
  @State private var currSelectedIndex = 0
  
  
  var body: some View {
    VStack {
      HStack {
        Text("Premier League Match Day \(currSelectedIndex + 1)")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding([.horizontal, .top])
      
      ScrollView(.horizontal) {
        HStack(alignment: .center, spacing: 16) {
          ForEach(numbers.indices) { index in
            Text("\(numbers[index].id)")
              .font(.subheadline)
              .frame(width: 75.0, height: 25.0)
              .overlay(
                RoundedRectangle(cornerRadius: 18)
                  .stroke(Color.primary, lineWidth: 4)
              )
              .background(numbers[index].isSelected ? Color(.systemGray) : Color.clear)
              .cornerRadius(18)
              .onTapGesture {
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
        }
        .padding()
      }
    }
    .onAppear {
      numbers[currSelectedIndex].isSelected = true
    }
  }
}
