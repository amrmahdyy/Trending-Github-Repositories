//
//  ApiConfigurable.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import Foundation
import Alamofire
protocol ApiConfigurable {
    var scheme: String { get }
    var host: String { get }
    var path: String {  get }
    var parameters: [String: String] {  get }
    var method: HTTPMethod { get }
}
