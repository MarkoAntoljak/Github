//
//  APIService.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import Foundation

public struct APIService {
    
    // MARK: Propreties
    static let shared = APIService()
    
    // MARK: Init
    private init() {}
    
    // MARK: Error Enum
    enum ErrorType: Error {
        case ErrorGettingAllRepos
        case ErrorGettingSearchResults
        case ErrorGettingRepoData
    }
    // MARK: Functions
    func getAllRepos(completion: @escaping (Result<[Repository], ErrorType>) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/repositories") else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, let data = data else {
                completion(.failure(.ErrorGettingAllRepos))
                return
            }
            do {
                let objectData = try JSONDecoder().decode([Repository].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(objectData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.ErrorGettingAllRepos))
            }
        }.resume()
    }
        
    func getRepoData(for repo: Repository, completion: @escaping (Result<RepositoryInfo, ErrorType>) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/repos/\(repo.fullName)") else {return}

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, let data = data else {
                completion(.failure(.ErrorGettingRepoData))
                return
            }
            do {
                let objectData = try JSONDecoder().decode(RepositoryInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(objectData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.ErrorGettingRepoData))
            }
        }.resume()
    }
    
    
    func getSearchResult(_ searchInput: String, _ sortParameter: SortParameter, completion: @escaping (Result<SearchResponse, ErrorType>) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchInput)&sort=\(sortParameter.rawValue)") else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, let data = data else {
                completion(.failure(.ErrorGettingSearchResults))
                return
            }
            do {
                let objectData = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(objectData))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.ErrorGettingSearchResults))
            }
        }.resume()
    }

}
