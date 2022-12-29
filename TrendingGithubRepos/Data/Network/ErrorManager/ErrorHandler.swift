//
//  ErrorHandler.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 27/12/2022.
//

import Foundation
enum ErrorMessage: String {
    case GenericError = "Failure 😞"
    case DecodingError = "Error in Decoding ☠️"
    case URLError = "Error in creating URL"
    case NotFound = "404: Not Found ⚠️"
    case NetworkError = "Network Error 🌍, Please check your internet connection and try again"
}
