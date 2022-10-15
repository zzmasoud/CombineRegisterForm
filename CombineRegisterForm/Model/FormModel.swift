//
//  FormModel.swift
//  CombineRegisterForm
//
//  Created by Masoud Sheikh Hosseini on 10/14/22.
//

import Foundation
import Combine

class FormModel: ObservableObject {
    
    // MARK: Publishers
    private let passwordPub = CurrentValueSubject<String, Never>("")
    private let passwordRepeatPub = CurrentValueSubject<String, Never>("")
    var canSubmit: AnyPublisher<Bool, Never>!

    @Published var password = "" {
        didSet {
            passwordPub.send(password)
        }
    }
    @Published var repeatPassword = "" {
        didSet {
            passwordRepeatPub.send(repeatPassword)
        }
    }
    
    private var subscriptions = [AnyCancellable]()
    
}
