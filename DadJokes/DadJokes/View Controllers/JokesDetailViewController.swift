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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private methods
    
    private func navigationViews() {
        self.title = "Create a New Joke"
    }
    
    // MARK: - IBActions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let jokeController = jokeController,
            let questionText = questionTextField.text,
            !questionText.isEmpty,
            !answerTextView.text.isEmpty else { return }
        
        let isPrivate = (jokeSegmentedControl.selectedSegmentIndex == 1) ? true : false
        
        jokeController.createJoke(question: questionText,
                                  answer: answerTextView.text,
                                  isPrivate: isPrivate)
        
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
