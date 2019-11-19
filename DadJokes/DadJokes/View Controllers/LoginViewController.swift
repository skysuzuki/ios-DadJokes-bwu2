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
        view.backgroundColor = Colors.sharedColors.darkerBlue
        logInView.backgroundColor = Colors.sharedColors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.sharedColors.babyBlue
        passwordTextField.backgroundColor = Colors.sharedColors.babyBlue
        buttonViews()
    }
    
    private func buttonViews() {
        // Register button
        registerButton.backgroundColor = Colors.sharedColors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        
        // Sign In button
        signInButton.backgroundColor = Colors.sharedColors.salmon
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.layer.cornerRadius = 8.0
        
        // Guest Button
        guestButton.backgroundColor = Colors.sharedColors.salmon
        guestButton.setTitleColor(UIColor.white, for: .normal)
        guestButton.layer.cornerRadius = 8.0
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
