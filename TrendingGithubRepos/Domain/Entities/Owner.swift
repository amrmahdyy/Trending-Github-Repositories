//
//  Owner.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import Foundation

struct Owner: Codable {
    var loginName: String
    var avatarUrl: String
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case loginName = "login"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
