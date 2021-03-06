//
//  CreateUserViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    // MARK: - Properties
    
    var jokeController: JokeController?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearTextFields()
    }
    
    // MARK: - IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let usernameText = usernameTextField.text,
            let passwordText = passwordTextField.text,
            let emailText = emailTextField.text else { return }
        
        if (usernameText.isEmpty || passwordText.isEmpty || emailText.isEmpty) {
            presentInputAlert()
        } else {
            let user = UserRegistration(username: usernameText,
                                        password: passwordText,
                                        email: emailText)
            registerUser(with: user)
        }
    }

    // MARK: - Private methods
    
    private func registerUser(with user: UserRegistration) {
        guard let jokeController = jokeController else { return }
        
        jokeController.register(with: user) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.presentBadRegistrationAlert()
                    print("Error registering user: \(error)")
                } else {
                    self.presentRegistrationCompleteAlert()
                }
            }
        }
    }
    
    private func presentInputAlert() {
        var message = "Enter a:\n"
        if let usernameText = usernameTextField.text,
            usernameText.isEmpty {
            message += "Username\n"
        }
        if let passwordText = passwordTextField.text,
            passwordText.isEmpty {
            message += "Password\n"
        }
        if let emailText = emailTextField.text,
            emailText.isEmpty {
            message += "Email\n"
        }
        
        let alert = UIAlertController(title: "Missing Field!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentRegistrationCompleteAlert() {
        let alert = UIAlertController(title: "Registration Complete!", message: "Log In", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
    
    private func presentBadRegistrationAlert() {
        let alert = UIAlertController(title: "Username taken!", message: "Try a different username", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func updateViews() {
        view.backgroundColor = Colors.darkerBlue
        registerView.backgroundColor = Colors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.veryLightBlue
        passwordTextField.backgroundColor = Colors.veryLightBlue
        emailTextField.backgroundColor = Colors.veryLightBlue
        buttonViews()
    }
    
    private func buttonViews() {
        registerButton.backgroundColor = Colors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 15.0
    }
    
    private func clearTextFields() {
        usernameTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
        emailTextField.text?.removeAll()
        usernameTextField.becomeFirstResponder()
    }
}
