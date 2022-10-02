//
//  API.swift
//  CombineRegisterForm
//
//  Created by Masoud Sheikh Hosseini on 10/2/22.
//

import Foundation
import Combine

struct API {
    static private let baseURL = "https://api.github.com"
    
    enum endpoint {
        case fetch(username: String)
        
        private var url: URL {
            switch self {
            case .fetch(let username):
                return URL(string: API.baseURL + "/users/" + username)!
            }
        }
    }
    
    static private func fetch(username: String) -> AnyPublisher<GithubUser?, Never> {
        return Empty<GithubUser?, Never>()
            .eraseToAnyPublisher()
    }
}
