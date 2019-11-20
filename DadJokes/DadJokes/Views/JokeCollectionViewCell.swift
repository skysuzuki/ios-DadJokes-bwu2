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
    @IBOutlet weak var privateQuestionLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    // MARK: - Properties
    
    var joke: Joke? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Private methods
    
    private func updateViews() {
        guard let joke = joke else { return }
        jokeQuestionLabel.text = joke.jokesDescription
        //privateQuestionLabel.text = joke.isPrivate ? "Private" : "Public"
        view.backgroundColor = Colors.veryLightBlue
        view.layer.cornerRadius = 8.0
    }
}
