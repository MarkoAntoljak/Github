//
//  Owner.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import Foundation

struct Owner: Codable {
    
    let id: Int
    let userName: String
    let avatarURL: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "login"
        case avatarURL = "avatar_url"
        case url = "html_url"
    }
}
