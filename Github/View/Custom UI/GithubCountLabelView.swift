//
//  GithubCountLabelView.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import UIKit

class GithubCountLabelView: UIView {

    // MARK: Propreties
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Functions
    private func addSubviews() {
        addSubview(countLabel)
    }
    private func setConstraints() {
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(5)
            make.height.equalToSuperview().inset(1)
        }
    }
    private func configureView() {
        backgroundColor = Constants.greenColor
        layer.masksToBounds = true
        layer.cornerRadius = 4
    }



}
