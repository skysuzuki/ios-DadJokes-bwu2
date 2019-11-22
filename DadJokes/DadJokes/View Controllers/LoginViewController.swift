//
//  LoginViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let jokeController = JokeController()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInView: UIView!
    
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        clearTextFields()
    }
    
    // MARK: - IBActions
    
    @IBAction func guestSignInTapped(_ sender: UIButton) {
         self.jokeController.getNoAuthJokes { error in
             if let error = error {
                 print("Error getting Jokes \(error)")
             } else {
                 print("Got Jokes!")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowGuestCollectionSegue", sender: self)
                }
             }
         }
     }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty {
            
            let user = UserLogin(username: username, password: password)
            
            jokeController.signIn(with: user) { error in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.presentBadLogInAlert()
                        //print("Error signing in! \(error)")
                    }
                } else {
                    print("Signed In!")
                    self.jokeController.getNoAuthJokes { error in
                        if let error = error {
                            print("Error getting Jokes \(error)")
                        } else {
                            print("Got Jokes!")
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "ShowLogInSegue", sender: self)
                            }
                            print("Log in was successful!")
                        }
                    }
                }

            }
            
        }
    }
    
    // MARK: - Private Methods
    
    private func updateViews() {
        view.backgroundColor = Colors.darkerBlue
        logInView.backgroundColor = Colors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.veryLightBlue
        passwordTextField.backgroundColor = Colors.veryLightBlue
        buttonViews()
    }
    
    private func buttonViews() {
        // Register button
        registerButton.backgroundColor = Colors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 15.0
        
        // Sign In button
        signInButton.backgroundColor = Colors.salmon
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.layer.cornerRadius = 15.0
        
        // Guest Button
        guestButton.backgroundColor = Colors.salmon
        guestButton.setTitleColor(UIColor.white, for: .normal)
        guestButton.layer.cornerRadius = 15.0
    }
    
    private func presentBadLogInAlert() {
        let alert = UIAlertController(title: "Log In Unsuccessful", message: "Check username and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func clearTextFields() {
        usernameTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
        usernameTextField.becomeFirstResponder()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ModalRegisterSegue":
            if let destinationVC = segue.destination as? CreateUserViewController {
                destinationVC.jokeController = self.jokeController
            }
        case "ShowLogInSegue", "ShowGuestCollectionSegue":
            if let destinationVC = segue.destination as? JokesCollectionViewController {
                destinationVC.jokeController = self.jokeController
            }
        default:
            return
        }
    }
}
