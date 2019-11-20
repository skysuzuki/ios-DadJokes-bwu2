//
//  CreateUserViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let usernameText = usernameTextField.text,
            let passwordText = passwordTextField.text else { return }
        
        if (usernameText.isEmpty || passwordText.isEmpty) {
            showInputAlert()
        } else {
            showRegistrationCompleteAlert()
        }
    }

    // MARK: - Private methods
    
    private func showInputAlert() {
        var message = "Enter a:\n"
        if let usernameText = usernameTextField.text,
            usernameText.isEmpty {
            message += "Username\n"
        }
        if let passwordText = passwordTextField.text,
            passwordText.isEmpty {
            message += "Password\n"
        }
        
        let alert = UIAlertController(title: "Missing Field!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showRegistrationCompleteAlert() {
        let alert = UIAlertController(title: "Registration Complete!", message: "Log In", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
    
    private func updateViews() {
        view.backgroundColor = Colors.darkerBlue
        registerView.backgroundColor = Colors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.babyBlue
        passwordTextField.backgroundColor = Colors.babyBlue
        emailTextField.backgroundColor = Colors.babyBlue
        buttonViews()
    }
    
    private func buttonViews() {
        registerButton.backgroundColor = Colors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
    }
}
