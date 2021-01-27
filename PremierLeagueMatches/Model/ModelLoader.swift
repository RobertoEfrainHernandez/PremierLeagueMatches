//
//  ModelLoader.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import Combine

struct ModelLoader<Model: Decodable> {
  func loadModel(with request: URLRequest, and session: URLSession = .shared) -> AnyPublisher<Model, Error> {
    return session.publisher(for: request)
  }
}
