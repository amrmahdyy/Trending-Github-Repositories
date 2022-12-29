//
//  StaredReposManager.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import Foundation
import Alamofire
protocol NetworkManagerable {
    associatedtype Router: ApiConfigurable
}
class StaredReposManager: NetworkManagerable {
    static let shared = StaredReposManager()
    private init() {}
    enum Router: ApiConfigurable {
        case MostStaredRepos
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .MostStaredRepos:
                return .get
            }
        }
        var scheme: String {
            switch self {
            case .MostStaredRepos:
                return "https"
            }
        }
        
        var host: String {
            switch self {
            case .MostStaredRepos:
                return "api.github.com"
            }
        }
        
        var path: String {
            switch self {
            case .MostStaredRepos:
                return "/search/repositories"
            }
        }
        
        var parameters: [String : String] {
            switch self {
            case .MostStaredRepos:
                return ["q":"language=+sort:stars"]
            }
        }
    }
    
    func getMostStaredRepos(completion: @escaping(Result<Repositories, NSError>)->()) {
        NetworkService.request(router: Router.MostStaredRepos, responseClass: Repositories.self) { [weak self] response in
            switch response {
            case .success(let repos):
                completion(.success(repos))
                self?.saveRepos(repos: repos)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//    MARK: Caching in UserDefaults
extension StaredReposManager {
    var cachedRepos: Repositories? {
        if let data = UserDefaults.standard.data(forKey: "repositories") {
            do {
                let decoder = JSONDecoder()
                
                let repos = try decoder.decode(Repositories.self, from: data)
                
                return repos
            }
            catch {
                print("Error in retrieving Cached Repositories")
            }
        }
        return nil
    }
    
    private func saveRepos(repos: Repositories) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(repos)
            UserDefaults.standard.set(data, forKey: "repositories")
        }
        catch {
            print("Error in Caching Repositories")
        }
    }
}
