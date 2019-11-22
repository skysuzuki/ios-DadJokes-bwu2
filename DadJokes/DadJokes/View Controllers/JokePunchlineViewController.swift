//
//  JokePunchlineViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class JokePunchlineViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var punchlineLabel: UILabel!
    @IBOutlet weak var punchlineView: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - Properties
    
    var joke: Joke?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    
    @IBAction func okTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func updateViews() {
        guard let joke = joke else { return }

        punchlineLabel.text = joke.punchline
        self.view.backgroundColor = Colors.babyBlue
        viewShadow()
        buttonViews()
    }
    
    private func buttonViews() {
        okButton.backgroundColor = Colors.salmon
        okButton.setTitleColor(UIColor.white, for: .normal)
        okButton.layer.cornerRadius = 15.0
    }
    
    private func viewShadow() {
        self.punchlineView.layer.cornerRadius = 15.0
        self.punchlineView.layer.borderWidth = 5.0
        self.punchlineView.layer.borderColor = UIColor.clear.cgColor
        self.punchlineView.layer.masksToBounds = true

        self.punchlineView.layer.shadowColor = UIColor.white.cgColor
        self.punchlineView.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.punchlineView.layer.shadowRadius = 6.0
        self.punchlineView.layer.shadowOpacity = 0.6
        self.punchlineView.layer.cornerRadius = 15.0
        self.punchlineView.layer.masksToBounds = false
    }
}
