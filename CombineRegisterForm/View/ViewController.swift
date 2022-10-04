//
//  ViewController.swift
//  CombineRegisterForm
//
//  Created by Masoud Sheikh Hosseini on 10/2/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var usernameLoadingActivity: UIActivityIndicatorView!
    @IBOutlet private weak var usernameErrorLabel: UILabel!

    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordErrorLabel: UILabel!

    @IBOutlet private weak var passwordRepeatTextField: UITextField!
    @IBOutlet private weak var passwordRepeatErrorLabel: UILabel!

    @IBOutlet private weak var button: UIButton!
    
    private var subscriptions = [AnyCancellable]()
    
    @Published private var username: String = ""
    @Published private var user: GithubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.addTarget(self, action: #selector(usernameValueChanged), for: .editingChanged)

        $username
            .drop(while: {$0.count < 4})
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .removeDuplicates()
            .map({ text in
                return API.request(endpoint: .fetch(username: text))
            })
            .switchToLatest()
            .receive(on: RunLoop.main)
            .print("pipeline")
            .assign(to: \.user, on: self)
            .store(in: &subscriptions)
    }

    @objc func usernameValueChanged() {
        username = usernameTextField.text ?? ""
    }


}

