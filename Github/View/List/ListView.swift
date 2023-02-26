//
//  ListView.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import UIKit
import SnapKit

class ListView: UIView {
    
    // MARK: Propreties
    var openRepositoryActionHandler: ((Repository) -> Void)?
    var didTapImageHandler: ((Repository) -> Void)?
    var repositories: [Repository] = []
    var searchedRepositories: [Repository] = []
    var showSearched: Bool = false
    var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.backgroundColor
        table.register(GithubTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.blueColor
        addSubviews()
        setConstraints()
        configure()
    }
    required init(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Functions
    private func addSubviews() {
        addSubview(tableView)
    }
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    // MARK: Configuring View
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        backgroundColor = .white
    }
    // MARK: Network call
    func fetchRepos(at indexPath: IndexPath, for repository: Repository) {
        APIService.shared.getRepoData(for: repository) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let repoData):
                if self.showSearched {
                    self.searchedRepositories[indexPath.row].repoData = repoData
                    if let cell = self.tableView.cellForRow(at: indexPath) as? GithubTableViewCell {
                        cell.configure(for: self.searchedRepositories[indexPath.row])
                    }
                } else {
                    self.repositories[indexPath.row].repoData = repoData
                    if let cell = self.tableView.cellForRow(at: indexPath) as? GithubTableViewCell {
                        cell.configure(for: self.repositories[indexPath.row])
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
