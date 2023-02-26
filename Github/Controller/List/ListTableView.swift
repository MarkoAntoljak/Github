//
//  ListTableViewDelegateDataSource.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import UIKit

// MARK: UITableView Delegate and DataSource
extension ListView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if showSearched {
                guard searchedRepositories[indexPath.row].repoData == nil else {continue}
                fetchRepos(at: indexPath, for: searchedRepositories[indexPath.row])
            } else {
                guard repositories[indexPath.row].repoData == nil else {continue}
                fetchRepos(at: indexPath, for: repositories[indexPath.row])
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GithubTableViewCell
        if showSearched {
            cell.configure(for: searchedRepositories[indexPath.row])
            if searchedRepositories[indexPath.row].repoData == nil {
                fetchRepos(at: indexPath, for: searchedRepositories[indexPath.row])
            }
        } else {
            cell.configure(for: repositories[indexPath.row])
            if repositories[indexPath.row].repoData == nil {
                fetchRepos(at: indexPath, for: repositories[indexPath.row])
            }
        }
        cell.didTapImageHandler = didTapImageHandler
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showSearched {
            return searchedRepositories.count
        } else {
            return repositories.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if showSearched {
            openRepositoryActionHandler?(searchedRepositories[indexPath.row])
        } else {
            openRepositoryActionHandler?(repositories[indexPath.row])
        }
    }
}

