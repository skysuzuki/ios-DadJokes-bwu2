//
//  JokeCollectionViewCell.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class JokeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var jokeQuestionLabel: UILabel!
    
    // MARK: - Properties
    
    var joke: Joke? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Private methods
    
    private func updateViews() {
        guard let joke = joke else { return }
        jokeQuestionLabel.text = joke.question
    }
}
