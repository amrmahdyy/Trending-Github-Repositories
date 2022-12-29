//
//  NetworkService.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 26/12/2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    final class func request<T: Decodable>(router: ApiConfigurable,responseClass: T.Type, completion: @escaping(Result<T, NSError>)->()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        let URLError = NSError(domain: router.host, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.URLError.rawValue])
        let decodingError = NSError(domain: router.host, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.DecodingError.rawValue])
        let notFoundError = NSError(domain: router.host, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.NotFound.rawValue])
        let networkError = NSError(domain: router.host, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.NetworkError.rawValue])
        
        guard let url = components.url else { return completion(.failure(URLError)) }
        let parameter = router.parameters
        let parameterEncoding : ParameterEncoding = URLEncoding.default
        
        AF.request(url, method: router.method, parameters: parameter,encoding: parameterEncoding , headers: [:]).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let objResponse):
                completion(.success(objResponse))
            case .failure(_):
                guard response.response?.statusCode != nil else { return completion(.failure(networkError)) }
                completion(.failure(decodingError))
            }
        }
      
    }
}
