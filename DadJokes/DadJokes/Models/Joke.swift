//
//  Joke.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Joke: Codable, Equatable {
    var id: Int = 0
    var jokesDescription: String
    var punchline: String
}
