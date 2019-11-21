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
    
    @IBOutlet weak var jokeSegmentedControl: UISegmentedControl!
    
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
        if let joke = joke {
            self.title = "Edit a Joke"
            questionTextField.text = joke.jokesDescription
            answerTextView.text = joke.punchline
        } else {
            self.title = "Create a New Joke"
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
            }
        } else {
            let newJoke = Joke(jokesDescription: questionText, punchline: answerTextView.text)
            jokeController.createJoke(with: newJoke) { error in
                if let error = error {
                    print("Error creating joke \(error)")
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
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
