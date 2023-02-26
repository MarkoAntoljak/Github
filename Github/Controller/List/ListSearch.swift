//
//  ListSearch.swift
//  Github
//
//  Created by Marko Antoljak on 2/20/23.
//

import Foundation
import UIKit

extension ListController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        APIService.shared.getSearchResult(text, sortParam) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let results):
                self.customView.searchedRepositories = results.repos ?? []
                self.customView.showSearched = true
                self.customView.tableView.reloadData()
                break
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customView.showSearched = false
        customView.tableView.reloadData()
    }
}
