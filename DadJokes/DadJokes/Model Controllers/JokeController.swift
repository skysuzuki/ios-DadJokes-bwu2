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
    
    let jokesURL = URL(string: "https://dad-jokes-2019.herokuapp.com/api/")!
    var jokes: [Joke] = []
    var token: Token?
    // MARK: - Log In Methods
    
    func register(with user: UserRegistration, completion: @escaping (Error?) -> Void) {
        let registerURL = jokesURL.appendingPathComponent("auth/register")
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 500 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func signIn(with user: UserLogin, completion: @escaping (Error?) -> Void) {
        let loginURL = jokesURL.appendingPathComponent("auth/login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.token = try decoder.decode(Token.self, from: data)
                //print(self.token as Any)
            } catch {
                print("Error decoding token object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
        
    }
    
    // MARK: - Fetch Methods
    func getAuthJokes(completion: @escaping (Error?) -> Void) {
        guard let token = token else { return }
        
        let allJokesURL = jokesURL.appendingPathComponent("auth/jokes")
        
        var request = URLRequest(url: allJokesURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/javascript", forHTTPHeaderField: "Content-Type")
        request.setValue(token.token, forHTTPHeaderField: "authorization")
        
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
    
    func createJoke(with joke: Joke, completion: @escaping (Error?) -> Void) {
        guard let token = token else { return }
        
        let createJokeURL = jokesURL.appendingPathComponent("auth/jokes")
        
        var request = URLRequest(url: createJokeURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(token.token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let jsonData = try jsonEncoder.encode(joke)
            request.httpBody = jsonData
        } catch {
            print("Error encoding joke object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let newJoke = try decoder.decode(Joke.self, from: data)
                self.jokes.append(newJoke)
            } catch {
                print("Error decoding joke object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func deleteJoke(with joke: Joke, completion: @escaping (Error?) -> Void) {
        guard let token = token else { return }
        
        let jokeId = returnJokeId(for: joke)
        let deleteJokeURL = jokesURL.appendingPathComponent("auth/jokes/\(jokeId)")
        
        var request = URLRequest(url: deleteJokeURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue(token.token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            if let index = self.jokes.firstIndex(of: joke) {
                self.jokes.remove(at: index)
            } else {
                print("Error deleting local joke")
            }
            
            completion(nil)
        }.resume()
    }
    
    func updateJoke(with joke: Joke, description: String, punchline: String, completion: @escaping (Error?) -> Void) {
        guard let token = token,
            let jokeIndex = jokes.firstIndex(of: joke) else { return }
        
        let jokeId = returnJokeId(for: joke)
        
        let updatedJoke = Joke(id: jokeId, jokesDescription: description, punchline: punchline)
        
        let updateJokeURL = jokesURL.appendingPathComponent("auth/jokes/\(jokeId)")
        
        var request = URLRequest(url: updateJokeURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue(token.token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let jsonData = try jsonEncoder.encode(updatedJoke)
            request.httpBody = jsonData
        } catch {
            print("Error encoding joke object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.jokes[jokeIndex] = try decoder.decode(Joke.self, from: data)
            } catch {
                print("Error decoding joke object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    // MARK: - Private Methods
    
    private func returnJokeId(for joke: Joke) -> Int {
        guard let index = jokes.firstIndex(of: joke) else { return 0 }
        
        return jokes[index].id
    }
}
