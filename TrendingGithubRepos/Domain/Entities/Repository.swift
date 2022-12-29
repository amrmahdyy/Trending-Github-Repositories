//
//  Repository.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import Foundation

struct Repository: Codable {
    var name: String
    var privateRepo: Bool
    var htmlUrl: String
    var stars: Int
    var watchers: Int
    var owner: Owner
    var language: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case name, language
        case description = "description"
        case privateRepo = "private"
        case htmlUrl = "html_url"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case owner = "owner"
    }
}

