//
//  NetworkExtension.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 26/12/2022.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
    }
}
