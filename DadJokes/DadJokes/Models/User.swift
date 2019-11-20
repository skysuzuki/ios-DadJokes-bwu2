//
//  User.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct UserRegistration: Codable {
    let username: String
    let password: String
    let email: String
}

struct UserLogin: Codable {
    let username: String
    let password: String
}
