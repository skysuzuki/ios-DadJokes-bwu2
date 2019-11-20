//
//  LoginViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var logInView: UIView!
    
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Methods
    
    private func updateViews() {
        view.backgroundColor = Colors.darkerBlue
        logInView.backgroundColor = Colors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.babyBlue
        passwordTextField.backgroundColor = Colors.babyBlue
        emailTextField.backgroundColor = Colors.babyBlue
        buttonViews()
    }
    
    private func buttonViews() {
        // Register button
        registerButton.backgroundColor = Colors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        
        // Sign In button
        signInButton.backgroundColor = Colors.salmon
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.layer.cornerRadius = 8.0
        
        // Guest Button
        guestButton.backgroundColor = Colors.salmon
        guestButton.setTitleColor(UIColor.white, for: .normal)
        guestButton.layer.cornerRadius = 8.0
    }
}
