//
//  Joke.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Joke: Codable, Equatable {
    var question: String
    var answer: String
    var isPrivate: Bool = false
}
