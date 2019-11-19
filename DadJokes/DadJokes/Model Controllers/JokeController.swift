//
//  JokeController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class JokeController {
    
    // MARK: - Properties
    
    var jokes: [Joke] = []
    
    // MARK: - CRUD Methods
    
    func createJoke(question: String, answer: String) {
        let joke = Joke(question: question, answer: answer)
        jokes.append(joke)
    }
    
    func updateJoke(for joke: Joke, update question: String, update answer: String) {
        guard let index = jokes.firstIndex(of: joke) else { return }
        jokes[index].question = question
        jokes[index].answer = answer
    }
    
    func deleteJoke(for joke: Joke) {
        guard let index = jokes.firstIndex(of: joke) else { return }
        jokes.remove(at: index)
    }
}
