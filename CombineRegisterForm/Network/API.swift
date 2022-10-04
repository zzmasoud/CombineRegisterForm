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
    
    static let activityPublisher = PassthroughSubject<Bool, Never>()
    
    // This is completely wrong(bcz of the retun type)! but I'm going to keep it temporary...
    static func request(endpoint: Endpoint) -> AnyPublisher<GithubUser?, Never> {
        URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .handleEvents(receiveSubscription: {_ in
                Self.activityPublisher.send(true)
            }, receiveCompletion: { _ in
                Self.activityPublisher.send(false)
            }, receiveCancel: {
                Self.activityPublisher.send(false)
            })
            .map(\.data)
            .decode(type: GithubUser?.self, decoder: JSONDecoder())
            .catch({ error in
                return Just(nil)
            })
            .eraseToAnyPublisher()
    }
}
