//
//  ContentView.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI

struct MatchDayListView: View {
  @EnvironmentObject var plTeamsStore: PLTeamsStore
  @Environment(\.colorScheme) var colorScheme
  @StateObject private var plMatchDayStore = PLMatchDayStore()
  @Namespace var namespace
  @State private var selectedMatch: MatchDay.Match? = nil
  @State private var show = false
  @State private var isDisabled = false
  
  var body: some View {
    ZStack {
      VStack {
        MatchDayListHeaderView(plMatchDayStore: plMatchDayStore)
        
        ScrollView {
          VStack(alignment: .center, spacing: 24) {
            if plMatchDayStore.loading {
              ProgressView()
                .progressViewStyle(BlueShadowProgressViewStyle())
                .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue))
                .scaleEffect(1.8, anchor: .center)
                .offset(y: 100)
            } else {
              ForEach(plMatchDayStore.matches) { match in
                VStack {
                  MatchDayScoreView(match: match)
                    .matchedGeometryEffect(id: match.id, in: namespace, isSource: !show)
                    .offset(y: 0)
                    .frame(width: 335, height: 200)
                    .background(colorScheme == .dark ? Constants.darkModeBlue : Constants.lightModeBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                    .onTapGesture {
                      withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                        show.toggle()
                        selectedMatch = match
                        isDisabled = true
                      }
                    }
                    .disabled(isDisabled)
                }
                .matchedGeometryEffect(id: "container\(match.id)", in: namespace, isSource: !show)
              }
            }
          }
          .frame(maxWidth: .infinity)
        }
      }
      .zIndex(1)
      
      if selectedMatch != nil {
        ZStack(alignment: .topTrailing) {
          MatchDayDetailView(match: selectedMatch!, namespace: namespace)
          CloseButton()
            .padding(.trailing, 16)
            .onTapGesture {
              withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                show.toggle()
                selectedMatch = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  isDisabled = false
                }
              }
            }
        }
          .zIndex(2)
      }
    }
    .edgesIgnoringSafeArea(.bottom)
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MatchDayListView()
      MatchDayListView()
        .preferredColorScheme(.dark)
    }
  }
}
