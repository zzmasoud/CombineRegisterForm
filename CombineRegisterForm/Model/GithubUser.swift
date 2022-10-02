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
    let login: String
    let public_repos: Int
    let avatar_url: String
    let created_at: String
}
