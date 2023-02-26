//
//  GithubTests.swift
//  GithubTests
//
//  Created by Marko Antoljak on 2/22/23.
//

import XCTest
@testable import Github

class APIServiceTests: XCTestCase {

    var apiService: APIService!
    
    override func setUpWithError() throws {
        apiService = APIService.shared
    }

    func testGetAllRepos() throws {
        let expectation = self.expectation(description: "Fetching all repos from API")
        
        apiService.getAllRepos { result in
            switch result {
            case .success(let repos):
                XCTAssertGreaterThan(repos.count, 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching all repos failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetRepoData() throws {
        let expectation = self.expectation(description: "Fetching repo data from API")
        let repository = Repository(id: 1, name: "grit", fullName: "mojombo/grit", owner: Owner(id: 1, userName: "mojombo", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo"), description: "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.")
        
        APIService.shared.getRepoData(for: repository) { result in
            switch result {
            case .success(let repoData):
                XCTAssertEqual(repoData.name, repository.name)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching repo data failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetSearchResult() throws {
        let expectation = self.expectation(description: "Fetching search result from API")
        
        apiService.getSearchResult("swift", .stars) { result in
            switch result {
            case .success(let searchResponse):
                XCTAssertGreaterThan(searchResponse.count, 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching search result failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

