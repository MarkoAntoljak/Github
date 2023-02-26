//
//  OwnerDetailsView.swift
//  Github
//
//  Created by Marko Antoljak on 2/17/23.
//

import UIKit

class OwnerDetailsView: UIView {

    // MARK: Attributes
    var repository: Repository?
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var openInBrowserButton = GithubButton()
    private lazy var nameLabel = UILabel()
    
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
        addSubview(openInBrowserButton)
        addSubview(nameLabel)
    }
    
    private func setConstraints() {
        userImage.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(20)
        }
        openInBrowserButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
        }
    }
    func configure() {
        guard let imageUrl = URL(string: repository?.owner?.avatarURL ?? "") else {return}
        userImage.sd_setImage(with: imageUrl)
        userImage.layer.cornerRadius = 100
        nameLabel.textColor = .white
        nameLabel.text = repository?.owner?.userName
    }

}
