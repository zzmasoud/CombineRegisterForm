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
    
    enum Endpoint {
        case fetch(username: String)
        
        var url: URL {
            switch self {
            case .fetch(let username):
                return URL(string: API.baseURL + "/users/" + username)!
            }
        }
    }
    
    // This is completely wrong(bcz of the retun type)! but I'm going to keep it temporary...
    static func request(endpoint: Endpoint) -> AnyPublisher<GithubUser?, any Error> {
        URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .map(\.data)
            .decode(type: GithubUser?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
