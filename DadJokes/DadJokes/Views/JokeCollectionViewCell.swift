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
    @IBOutlet weak var editJokeButon: UIButton!
    
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
        cellShadowViews()
    }
    
    private func cellShadowViews() {
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
