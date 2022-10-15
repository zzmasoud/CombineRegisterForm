//
//  FormModel.swift
//  CombineRegisterForm
//
//  Created by Masoud Sheikh Hosseini on 10/14/22.
//

import Foundation
import Combine

class FormModel: ObservableObject {
    static let passwordMinLimit = 8
    
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
    
    @Published var validationErrorMsg: String? = nil
    
    private var subscriptions = [AnyCancellable]()
    
    init() {
        let validationPipeline = Publishers.CombineLatest(passwordPub, passwordRepeatPub)
            .map { pass, repeatPass -> String? in
                guard pass.count >= Self.passwordMinLimit else { return "pass short" }
                guard pass == repeatPass else { return "not equal" }
                return nil
            }
        
        canSubmit = validationPipeline
            .map({$0 == nil})
            .eraseToAnyPublisher()
        
        validationPipeline
            .assign(to: \.validationErrorMsg, on: self)
            .store(in: &subscriptions)
    }
}
