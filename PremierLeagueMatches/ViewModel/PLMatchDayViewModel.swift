//
//  PLMatchDayStore.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import UIKit
import Combine

class PLMatchDayViewModel: ObservableObject {
  @Published var groupMatches = [GroupMatch]()
  @Published var loading = false
  private var cancellables = Set<AnyCancellable>()
  private let modelLoader: ModelLoader<MatchDay>
  private var matchDayCache = [String: MatchDay]()
  
  init(matchDayId: Int = 1, modelLoader: ModelLoader<MatchDay> = ModelLoader<MatchDay>()) {
    self.modelLoader = modelLoader
    loadMatches(basedOn: matchDayId)
    
    NotificationCenter.default
      .publisher(for: UIApplication.didReceiveMemoryWarningNotification)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [self] _ in
        matchDayCache.removeAll()
      })
      .store(in: &cancellables)
  }
  
  /// This function calls the loadModel method from the ModelLoader struct to load all premier league matches on a particular match day number
  /// - Parameter matchDayNumber: Match Day Number
  func loadMatches(basedOn matchDayNumber: Int) {
    if let matchDayMatches = matchDayCache["\(matchDayNumber)"]?.groupMatches() {
      groupMatches = matchDayMatches
    } else {
      loading = true
      modelLoader
        .loadModel(with: EndPoint.plMatches(withMatchDayID: matchDayNumber).urlRequest)
        .sink(receiveCompletion: { completion in
          switch completion {
            case .finished: break
            case .failure(let error): print(error)
          }
        }, receiveValue: { [self] matchDay in
<<<<<<< HEAD:PremierLeagueMatches/ViewModel/PLMatchDayViewModel.swift
          let numStr = String(matchDayNumber)
          matchDayCache.updateValue(matchDay, forKey: numStr)
          groupMatches = matchDayCache[numStr]!.groupMatches()
=======
          matchDayCache.updateValue(matchDay, forKey: "\(matchDayNumber)")
          matches = matchDayCache["\(matchDayNumber)"]!.matches.sorted()
>>>>>>> 9d535dce56d8086b8ca9a403c890c0fa2f19cfa8:PremierLeagueMatches/ViewModel/PLMatchDayStore.swift
          loading = false
        })
        .store(in: &cancellables)
    }
  }
}
