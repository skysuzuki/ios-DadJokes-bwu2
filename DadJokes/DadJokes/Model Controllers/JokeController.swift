//
//  JokeController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class JokeController {
    
    
    // MARK: - CRUD Methods
    
    func createJoke(question: String, answer: String) {
        let _ = Joke(question: question, answer: answer)
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving joke \(error)")
        }
    }
    
    func updateJoke(for joke: Joke, update question: String, update answer: String) {
        joke.question = question
        joke.answer = answer
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("Error saving joke \(error)")
        }
    }
    
    func deleteJoke(for joke: Joke) {
        let context = CoreDataStack.shared.mainContext
        do {
            context.delete(joke)
            try CoreDataStack.shared.save(context: context)
        } catch {
            context.reset()
            print("Error deleting joke from managed object context: \(error)")
        }
    }
}
