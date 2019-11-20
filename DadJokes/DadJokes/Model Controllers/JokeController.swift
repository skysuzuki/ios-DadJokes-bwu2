//
//  JokeController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class JokeController {
    
    // MARK: - Properties
    
    var jokes: [Joke] = []
    let jokesURL = URL(string: "https://dad-jokes-2019.herokuapp.com/api/")!
    
    // MARK: - Log In Methods
    
    
    
    // MARK: - Fetch Methods
    
    func getNoAuthJokes(completion: @escaping (Error?) -> Void) {
        
        let allJokesURL = jokesURL.appendingPathComponent("jokes")
        
        var request = URLRequest(url: allJokesURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/javascript", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error recieving joke data: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                print("Got bad data")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.jokes = try decoder.decode([Joke].self, from: data)
                completion(nil)
            } catch {
                print("Error decoding joke objects: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    
    
    
    
    // MARK: - CRUD Methods
    
    func createJoke(question: String, answer: String) {
        let joke = Joke(jokesDescription: question, punchline: answer)
        jokes.append(joke)
    }
    
    func updateJoke(for joke: Joke, update question: String, update answer: String) {
        guard let index = jokes.firstIndex(of: joke) else { return }
        jokes[index].jokesDescription = question
        jokes[index].punchline = answer
    }
    
    func deleteJoke(for joke: Joke) {
        guard let index = jokes.firstIndex(of: joke) else { return }
        jokes.remove(at: index)
    }
}
