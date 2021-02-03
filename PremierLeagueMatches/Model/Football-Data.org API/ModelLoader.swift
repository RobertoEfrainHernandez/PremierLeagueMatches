//
//  ModelLoader.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import Combine

struct ModelLoader<Model: Decodable> {
  /// Method for returning a AnyPublisher from the URLSession extension with the input URLRequest
  /// - Parameters:
  ///   - request: URLRequest needed to pass into the dataTaskPublisher of URLSession
  ///   - session: Default URLSession.shared
  /// - Returns: AnyPublisher
  func loadModel(with request: URLRequest, and session: URLSession = .shared) -> AnyPublisher<Model, Error> {
    return session.publisher(for: request)
  }
}
