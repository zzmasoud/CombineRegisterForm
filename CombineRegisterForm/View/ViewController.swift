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
    @Published private var user: GithubUser? {
        didSet {
            guard let date = user?.createdAt else { return hideUsernameError() }
            
            usernameErrorLabel.text = "Already exist. (created at \(date.description))"
            usernameErrorLabel.isHidden = false
        }
    }
    
    @Published private var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideUsernameError()
        usernameTextField.addTarget(self, action: #selector(usernameValueChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordValueChanged), for: .editingChanged)

        $username
            .filter { [weak self] in
                self?.hideUsernameError()
                return $0.count > 3
            }
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .removeDuplicates()
            .map({ text in
                return API.request(endpoint: .fetch(username: text))
            })
            .print("pipeline")
            .switchToLatest()
            .receive(on: RunLoop.main)
            .assign(to: \.user, on: self)
            .store(in: &subscriptions)
        
        API.activityPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isActive in
                if isActive {
                    self?.usernameLoadingActivity.isHidden = false
                    self?.usernameLoadingActivity.startAnimating()
                } else {
                    self?.usernameLoadingActivity.stopAnimating()
                }
            })
            .store(in: &subscriptions)
        
        $password
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .filter { [weak self] text in
                guard text.count > 8 else {
                    self?.passwordErrorLabel.isHidden = false
                    self?.passwordErrorLabel.text = "Should contains 8 or more characters."
                    return false
                }
                guard text.contains("@") else {
                    self?.passwordErrorLabel.isHidden = false
                    self?.passwordErrorLabel.text = "Should contains especial characters."
                    return false
                }
                self?.passwordErrorLabel.isHidden = true
                return true
            }
            .sink(receiveValue: {print($0)})
            .store(in: &subscriptions)
    }

    @objc func usernameValueChanged() {
        username = usernameTextField.text ?? ""
    }
    
    @objc func passwordValueChanged() {
        password = passwordTextField.text ?? ""
    }
    
    private func hideUsernameError() {
        usernameErrorLabel.isHidden = true
    }


}

