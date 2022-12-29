//
//  ViewController.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 24/12/2022.
//

import UIKit
import Foundation
import SkeletonView
import Toast
class ViewController: UIViewController {
    //    MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    //    MARK: Properties
    private let viewModel = TopStaredViewModel()
    lazy private var refreshControl = UIRefreshControl()
    //    MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
        viewModel.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(loadData(_:)), for: .valueChanged)
    }
    //    MARK: View Controller Methods
    @objc private func loadData(_ sender: Any) {
        viewModel.viewDidLoad()
    }
    
    private func bind() {
        viewModel.startLoading = { [weak self] in
            self?.tableView.isSkeletonable = true
            self?.tableView.startSkeletonAnimation()
            self?.tableView.showAnimatedGradientSkeleton()
        }
        viewModel.endLoading = { [weak self] in
            self?.tableView.hideSkeleton()
            self?.tableView.stopSkeletonAnimation()
            self?.refreshControl.endRefreshing()
        }
        viewModel.showData = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.reloadRow = { [weak self] index in
            self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        viewModel.showError = { [weak self] errorMessage in
            var style = ToastStyle()
            style.messageColor = .white
            self?.view.makeToast(errorMessage, style: style)
        }
    }
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: TrendingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrendingTableViewCell.identifier)
    }
    
    
}
//    MARK: TableView Datasource & Delegate
extension ViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier) as? TrendingTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: viewModel.trendingRepos[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trendingRepos.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TrendingTableViewCell.identifier
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
        
        
    }
}

