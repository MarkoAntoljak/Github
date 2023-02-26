//
//  DetailedRepoView.swift
//  Github
//
//  Created by Marko Antoljak on 2/17/23.
//

import UIKit

class DetailedRepoView: UIView {

    // MARK: Attributes
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var openInBrowserButton = GithubButton()
    private lazy var descriptionLabel = createLabel()
    private lazy var languageLabel = createLabel()
    private lazy var createdAtLabel = createLabel()
    private lazy var ownerName = createLabel()
    private lazy var forksView = GithubCountLabelView()
    private lazy var watchersView = GithubCountLabelView()
    private lazy var issuesView = GithubCountLabelView()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.backgroundColor
        addSubviews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Functions
    private func addSubviews() {
        addSubview(userImage)
        addSubview(descriptionLabel)
        addSubview(languageLabel)
        addSubview(openInBrowserButton)
        addSubview(createdAtLabel)
        addSubview(ownerName)
        stackView.addArrangedSubview(forksView)
        stackView.addArrangedSubview(watchersView)
        stackView.addArrangedSubview(issuesView)
        addSubview(stackView)
    }
    
    private func setConstraints() {
        userImage.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
        }
        ownerName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(ownerName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(50)
            make.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        createdAtLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(languageLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        openInBrowserButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(createdAtLabel.snp.bottom).offset(30)
        }
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }
    
    func configure(with repository: Repository?) {
        descriptionLabel.numberOfLines = 4
        ownerName.textAlignment = .center
        guard let imageUrl = URL(string: repository?.owner?.avatarURL ?? "") else {return}
        userImage.sd_setImage(with: imageUrl)
        userImage.layer.cornerRadius = 75
        descriptionLabel.text = repository?.repoData?.description ?? "No description"
        languageLabel.text = "-- \(repository?.repoData?.language ?? "Unknown language")"
        ownerName.text = repository?.owner?.userName
        forksView.countLabel.text = "⑂ \((repository?.repoData?.forksCount ?? 0))"
        watchersView.countLabel.text = "⚯ \((repository?.repoData?.watcherCount ?? 0))"
        issuesView.countLabel.text = "⦿ \((repository?.repoData?.issueCount ?? 0))"
        // date format
        let dateString = repository?.repoData?.created
        guard let formattedDate = dateString?.formatTimestamp() else {return}
        createdAtLabel.text = "Created at:\n\(formattedDate)"
    }
}
