//
//  GithubUser.swift
//  CombineRegisterForm
//
//  Created by Masoud Sheikh Hosseini on 10/2/22.
//

import Foundation

//  Example:
// https://api.github.com/users/zzmasoud

struct GithubUser: Decodable {
    static private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    let login: String
    let public_repos: Int
    let avatar_url: String
    let created_at: String
}
