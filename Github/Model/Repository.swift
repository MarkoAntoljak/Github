//
//  Repository.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import Foundation

struct Repository: Codable {
    
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner?
    let description: String?
    var repoData: RepositoryInfo?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case description = "description"
    }
}
