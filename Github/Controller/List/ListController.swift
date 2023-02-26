//
//  ListController.swift
//  Github
//
//  Created by Marko Antoljak on 2/13/23.
//

import UIKit

class ListController: UIViewController {
    // MARK: Propreties
    let customView = ListView()
    var sortParam: SortParameter = .stars
    private let searchController = UISearchController()
    private lazy var sortButton = UIBarButtonItem(systemItem: .search)
    
    // MARK: Lifecycle
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.blueColor
        configureSearchController()
        getAllRepos()
        configureNavBar()
        configureDropMenu()
        configureActions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = Constants.blueColor
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.backgroundColor = Constants.backgroundColor
    }
    // MARK: Functions
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Repositories"
        navigationItem.rightBarButtonItem = sortButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    private func createMenuOption(_ parameter: SortParameter) -> UIAction {
        let actionItem = UIAction(title: parameter.rawValue.uppercased()) { action in
            self.sortParam = parameter
        }
        return actionItem
    }
    private func configureDropMenu() {
        let options = [createMenuOption(.updated),createMenuOption(.stars),createMenuOption(.forks)]
        let menu = UIMenu(title: "Sort search result by", children: options)
        navigationItem.rightBarButtonItem?.menu = menu
    }
    // MARK: Networking Call
    private func getAllRepos() {
        APIService.shared.getAllRepos { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let responseRepos):
                self.customView.repositories = responseRepos
                self.customView.tableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    // MARK: Configure User Actions
    private func configureActions() {
        customView.openRepositoryActionHandler = { [weak self] repo in
            let vc = DetailedRepoController()
            self?.navigationController?.pushViewController(vc, animated: true)
            vc.configure(with: repo)
        }
        customView.didTapImageHandler = { [weak self] repo in
            let vc = OwnerDetailsController()
            self?.navigationController?.pushViewController(vc, animated: true)
            vc.configure(with: repo)
        }
    }
}
