//
//  JokesDetailViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class JokesDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var stackedView: UIView!
    // MARK: - Properties
    
    var jokeController: JokeController?
    var joke: Joke?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private methods
    
    private func updateViews() {
        view.backgroundColor = Colors.darkerBlue
        stackedView.backgroundColor = Colors.babyBlue
        answerTextView.layer.cornerRadius = 8.0
        buttonViews()
        if let joke = joke {
            self.title = "Edit a Joke"
            questionTextField.text = joke.jokesDescription
            answerTextView.text = joke.punchline
            deleteButton.isHidden = false
        } else {
            self.title = "Create a New Joke"
            deleteButton.isHidden = true
        }
    }
    
    private func buttonViews() {
        deleteButton.layer.cornerRadius = 8.0
        deleteButton.backgroundColor = Colors.salmon
        deleteButton.setTitleColor(.white, for: .normal)
    }
    
    private func presentDeleteConfirmationAlert() {
        let alert = UIAlertController(title: "Are you sure you want to Delete Joke?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "DELETE", style: .destructive) { (UIAlertAction) -> Void  in
            self.deleteJoke()
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteJoke() {
        guard let jokeController = jokeController else { return }
        
        if let joke = joke {
            jokeController.deleteJoke(with: joke) { (error) in
                if let error = error {
                    print("Error deleting a joke \(error)")
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let jokeController = jokeController,
            let questionText = questionTextField.text,
            !questionText.isEmpty,
            !answerTextView.text.isEmpty else { return }
        
        if let joke = joke {
            jokeController.updateJoke(with: joke, description: questionText, punchline: answerTextView.text ) { error in
                if let error = error {
                    print("Error editing a joke \(error)")
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            let newJoke = Joke(jokesDescription: questionText, punchline: answerTextView.text)
            jokeController.createJoke(with: newJoke) { error in
                if let error = error {
                    print("Error creating joke \(error)")
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        self.presentDeleteConfirmationAlert()
    }
}
