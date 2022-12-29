//
//  CGFloat + Random.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 28/12/2022.
//

import Foundation
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
