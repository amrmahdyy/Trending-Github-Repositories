//
//  TrendingTableViewCell.swift
//  TrendingGithubRepos
//
//  Created by amrmahdy on 27/12/2022.
//

import UIKit
import SDWebImage

class TrendingTableViewCell: UITableViewCell {
//    MARK: Identifier
    static let identifier = "TrendingTableViewCell"
//    MARK: Outlets
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var RepoDescription: UILabel!
    @IBOutlet private weak var programmingLanguage: UILabel!
    @IBOutlet private weak var programmingLangColor: UIView!
    @IBOutlet private weak var detailedStackView: UIStackView!
    @IBOutlet private weak var stared: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLanguageView()
        // Initialization code
    }
    private func configureLanguageView() {
        programmingLangColor.layer.cornerRadius = programmingLangColor.frame.height / 2
        programmingLangColor.clipsToBounds = true
        programmingLangColor.backgroundColor = UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        userName.text = nil
        RepoDescription.text = nil
        programmingLanguage.text = nil
        stared.text = nil
        detailedStackView.isHidden = false
    }
    
    func configure(with viewModel: TrendingRepoDetailsViewModel) {
        guard let url = URL(string: viewModel.imageURL) else { return print("Error Loading User Profile image") }
        userImage.sd_setImage(with: url)
        name.text = viewModel.name
        userName.text = viewModel.userName
        RepoDescription.text = viewModel.repoDescription
        programmingLanguage.text = viewModel.programmingLanguage
        stared.text = viewModel.stared
        detailedStackView.isHidden = !viewModel.isDetailsShown
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
