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
    private let created_at: String
    
    var createdAt: Date {
        return Self.dateFormatter.date(from: created_at) ?? Date()
    }
}

extension GithubUser: CustomStringConvertible {
    var description: String {
        "\n" +
        "public repo(s): \(public_repos) \n" +
        "avatar URL: \(avatar_url) \n" +
        "created at: \(createdAt)"
        
    }
}
