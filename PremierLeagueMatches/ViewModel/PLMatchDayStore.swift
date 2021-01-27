//
//  PLMatchDayStore.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import UIKit
import Combine

class PLMatchDayStore: ObservableObject {
  @Published var matches = [MatchDay.Match]()
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
  
  func loadMatches(basedOn matchDayNumber: Int) {
    if let matchDayMatches = matchDayCache["\(matchDayNumber)"]?.matches {
      matches = matchDayMatches
    } else {
      modelLoader
        .loadModel(with: EndPoint.plMatches(withMatchDayID: matchDayNumber).urlRequest)
        .sink(receiveCompletion: { completion in
          switch completion {
            case .finished: break
            case .failure(let error): print(error)
          }
        }, receiveValue: { [self] matchDay in
          matchDayCache.updateValue(matchDay, forKey: "\(matchDayNumber)")
          matches = matchDayCache["\(matchDayNumber)"]!.matches
        })
        .store(in: &cancellables)
    }
  }
}
