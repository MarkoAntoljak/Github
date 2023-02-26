//
//  DetailedRepoController.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import UIKit
import SafariServices

class DetailedRepoController: UIViewController {
    
    // MARK: Propreties
    private var repository: Repository?
    let customView = DetailedRepoView()
    // MARK: init
    
    // MARK: Lifecycle
    override func loadView() {
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
        guard let repository = repository else {return}
        navigationItem.title = "\(repository.name.uppercased())"
    }
    
    private func configureURLButton() {
        customView.openInBrowserButton.addTarget(self, action: #selector(didTapUrl), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        customView.userImage.addGestureRecognizer(tap)
    }
    
    @objc private func didTapUrl() {
        guard let link = repository?.repoData?.link, let url = URL(string: link) else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapImage() {
        let vc = OwnerDetailsController()
        guard let repository = repository else {return}
        vc.configure(with: repository)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configure(with repo: Repository) {
        repository = repo
        configureNavBar()
        customView.configure(with: repo)
    }
    
}
