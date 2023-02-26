//
//  RepositoryInfo.swift
//  Github
//
//  Created by Marko Antoljak on 2/15/23.
//

import Foundation


struct RepositoryInfo: Codable, Hashable {
    
    let id: Int
    let link: String
    let name: String?
    let description: String?
    let forksCount: Int?
    let watcherCount: Int?
    let issueCount: Int?
    let language: String?
    let created: String?
    let visibility: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case link = "html_url"
        case description = "description"
        case name = "name"
        case forksCount = "forks_count"
        case watcherCount = "watchers_count"
        case issueCount = "open_issues_count"
        case language = "language"
        case created = "created_at"
        case visibility = "visibility"
    }
}
