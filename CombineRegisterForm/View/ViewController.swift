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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

