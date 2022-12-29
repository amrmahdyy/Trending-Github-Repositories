//
//  Repositories.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import Foundation

struct Repositories: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
        case total_count
        case incomplete_results
    }
}
