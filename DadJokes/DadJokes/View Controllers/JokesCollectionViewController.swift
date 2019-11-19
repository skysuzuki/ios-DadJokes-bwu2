//
//  JokesCollectionViewController.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class JokesCollectionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var jokeCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    private let jokeController = JokeController()
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jokeCollectionView?.reloadData()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCreateJokeSegue" {
            if let destinationVC = segue.destination as? JokesDetailViewController {
                destinationVC.jokeController = self.jokeController
            }
        }
    }


}

extension JokesCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        jokeController.jokes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = jokeCollectionView.dequeueReusableCell(withReuseIdentifier: "JokeCell", for: indexPath) as? JokeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.joke = jokeController.jokes[indexPath.item]
        
        return cell
    }
}

extension JokesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2.0
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = jokeCollectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
    
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
