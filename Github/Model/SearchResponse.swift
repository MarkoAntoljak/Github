//
//  SearchResponse.swift
//  Github
//
//  Created by Marko Antoljak on 2/16/23.
//

import Foundation

struct SearchResponse: Codable {
    
    let count: Int
    let hasResults: Bool
    let repos: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case hasResults = "incomplete_results"
        case repos = "items"
    }
}
