//
//  URLSession+Extension.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import Foundation
import Combine

extension URLSession {
  func publisher<T: Decodable>(
    for request: URLRequest,
    responseType: T.Type = T.self,
    decoder: JSONDecoder = .init()
  ) -> AnyPublisher<T, Error> {
    return dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: responseType, decoder: decoder)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
