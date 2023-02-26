//
//  OwnerDetailsController.swift
//  Github
//
//  Created by Marko Antoljak on 2/17/23.
//

import UIKit
import SafariServices

class OwnerDetailsController: UIViewController {
    
    // MARK: Attributes
    var repository: Repository?
    private let customView = OwnerDetailsView()
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureURLButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.userImage.shakeAnimate()
    }
    
    // MARK: Functions
    private func configureNavBar() {
        guard let repositoryOwner = repository?.owner?.userName else {return}
        navigationItem.title = "\(repositoryOwner.uppercased())"
    }
    
    private func configureURLButton() {
        customView.openInBrowserButton.addTarget(self, action: #selector(didTapUrl), for: .touchUpInside)
    }
    
    func configure(with repo: Repository) {
        self.repository = repo
        configureNavBar()
        customView.repository = repository
        customView.configure()
    }
    
    // MARK: User Actions
    @objc private func didTapUrl() {
        guard let link = customView.repository?.owner?.url, let url = URL(string: link) else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    
}
