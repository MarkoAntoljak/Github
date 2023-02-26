//
//  GithubTableViewCell.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import UIKit
import SDWebImage

class GithubTableViewCell: UITableViewCell {

    // MARK: Propreties
    var didTapImageHandler: ((Repository) -> Void)?
    var repo: Repository?
    private lazy var ownerThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var repoName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private lazy var ownerName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    private lazy var watcherCount = GithubCountLabelView()
    private lazy var forkCount = GithubCountLabelView()
    private lazy var issueCount = GithubCountLabelView()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.backgroundColor
        addSubviews()
        setConstraints()
        addActionHandlers()
    }
    required init(coder: NSCoder) {
        fatalError()
    }
    // MARK: Functions
    private func addSubviews() {
        addSubview(ownerThumbnail)
        addSubview(ownerName)
        addSubview(repoName)
        addSubview(watcherCount)
        addSubview(forkCount)
        addSubview(issueCount)
    }
    private func addActionHandlers() {
        ownerThumbnail.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        ownerThumbnail.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = false
    }
    private func setConstraints() {
        ownerThumbnail.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
        }
        repoName.sizeToFit()
        repoName.snp.makeConstraints { make in
            make.leading.equalTo(ownerThumbnail.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(250)
        }
        ownerName.sizeToFit()
        ownerName.snp.makeConstraints { make in
            make.leading.equalTo(ownerThumbnail.snp.trailing).offset(10)
            make.top.equalTo(repoName.snp.bottom)
            make.width.equalTo(180)
        }
        forkCount.snp.makeConstraints { make in
            make.leading.equalTo(ownerThumbnail.snp.trailing).offset(10)
            make.top.equalTo(ownerName.snp.bottom).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(20)
        }
        watcherCount.snp.makeConstraints { make in
            make.leading.equalTo(forkCount.snp.trailing).offset(10)
            make.top.equalTo(ownerName.snp.bottom).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(20)
        }
        issueCount.snp.makeConstraints { make in
            make.leading.equalTo(watcherCount.snp.trailing).offset(10)
            make.top.equalTo(ownerName.snp.bottom).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(20)
        }
    }
    // MARK: Actions
    @objc
    private func didTapImage() {
        guard let repo = repo else {return}
        didTapImageHandler?(repo)
    }
    // MARK: Configure
    func configure(for repo: Repository) {
        // image
        self.repo = repo
        guard let thumbnailImageURL = URL(string: repo.owner!.avatarURL) else {return}
        ownerThumbnail.sd_setImage(with: thumbnailImageURL)
        ownerThumbnail.layer.cornerRadius = 30
        // titles
        repoName.text = repo.name.uppercased()
        ownerName.text = repo.owner?.userName
        // repo data
        guard let repoData = repo.repoData,
        let watchers = repoData.watcherCount,
        let issues = repoData.issueCount,
        let forks = repoData.forksCount else {return}
        forkCount.countLabel.text = "⑂ \(forks.formatBigInt())"
        watcherCount.countLabel.text = "⚯ \(watchers.formatBigInt())"
        issueCount.countLabel.text = "⦿ \(issues.formatBigInt())"
    }

}
