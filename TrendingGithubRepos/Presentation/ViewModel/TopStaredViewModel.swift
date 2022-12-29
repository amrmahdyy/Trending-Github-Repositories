//
//  TopStaredViewModel.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 27/12/2022.
//

import Foundation

protocol TopStaredViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}
protocol TopStaredViewModelOutput {
    var showError: (String)->() { get }
    var items: [Repository] { get }
    var trendingRepos: [TrendingRepoDetailsViewModel] { get }
    var startLoading: ()->() { get }
    var endLoading: ()->() { get }
    var showData:()->() { get }
    var reloadRow: (Int)->() { get }
}
class TopStaredViewModel: TopStaredViewModelInput, TopStaredViewModelOutput {

    var items: [Repository] = []
    var trendingRepos: [TrendingRepoDetailsViewModel] = []
    var showError: (String) -> () = { _ in}
    var startLoading: () -> () = {}
    var endLoading: () -> () = {}
    var showData: () -> () = {}
    var reloadRow: (Int) -> () = {_ in}
    
    func viewDidLoad() {
        items = []
        trendingRepos = []
        
        startLoading()
        StaredReposManager.shared.getMostStaredRepos() { [weak self] completion in
            self?.endLoading()
            switch completion {
            case .success(let repos):
                self?.items = repos.items
                self?.trendingRepos = self?.objectMapping(repos: repos.items) ?? []
                self?.showData()
            case .failure(let error):
                if let cachedRepos =  StaredReposManager.shared.cachedRepos {
                    self?.trendingRepos = self?.objectMapping(repos: cachedRepos.items) ?? []
                    self?.showData()
                }
               
                self?.showError(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "Error: Please Try again")
            }
            
        }
    }
    
    func didSelectItem(at index: Int) {
        guard  trendingRepos.count >= index else { return }
        self.trendingRepos[index].isDetailsShown.toggle()
        reloadRow(index)
    }
}
extension TopStaredViewModel {
    private func objectMapping(repos: [Repository])-> [TrendingRepoDetailsViewModel] {
        repos.map { TrendingRepoDetailsViewModel(name: $0.name, userName: $0.owner.loginName, repoDescription: $0.description, programmingLanguage: $0.language ?? "", imageURL: $0.owner.avatarUrl, stared: String($0.stars), isDetailsShown: false)}
    }
}
