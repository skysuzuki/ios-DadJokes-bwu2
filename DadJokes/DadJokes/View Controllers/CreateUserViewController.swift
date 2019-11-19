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
    
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private methods
    
    private func updateViews() {
        view.backgroundColor = Colors.sharedColors.darkerBlue
        registerView.backgroundColor = Colors.sharedColors.darkestBlue
        
        usernameTextField.backgroundColor = Colors.sharedColors.babyBlue
        passwordTextField.backgroundColor = Colors.sharedColors.babyBlue
        
        buttonViews()
    }
    
    private func buttonViews() {
        registerButton.backgroundColor = Colors.sharedColors.salmon
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
    }
}
