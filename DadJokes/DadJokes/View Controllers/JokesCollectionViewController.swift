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
    
    @IBOutlet weak var signLogBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    var jokeController: JokeController?
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeApperance()
        jokeCollectionView.delegate = self
        jokeCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jokeCollectionView?.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIBarButtonItem) {
        guard let jokeController = jokeController else { return }
        
        if let _ = jokeController.token {
            jokeController.token = nil
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func themeApperance() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont(name: "FredokaOne-Regular", size: 40.0) as Any]
        view.backgroundColor = Colors.darkerBlue
        if let _ = jokeController?.token {
            signLogBarButtonItem.title = "Log Out"
        } else {
            signLogBarButtonItem.title = "Sign In"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCreateJokeSegue" {
            if let destinationVC = segue.destination as? JokesDetailViewController {
                destinationVC.jokeController = self.jokeController
            }
        } else if segue.identifier == "ShowEditJokeSegue" {
            guard let sender = sender as? UIButton,
                let cell = sender.superview?.superview?.superview as? JokeCollectionViewCell else { return }
            
            if let indexPath = jokeCollectionView?.indexPath(for: cell),
                let destinationVC = segue.destination as? JokesDetailViewController {
                destinationVC.jokeController = self.jokeController
                destinationVC.joke = self.jokeController?.jokes[indexPath.item]
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowCreateJokeSegue" {
            guard let jokeController = jokeController else { return false }
            
            if let _ = jokeController.token {
                return true
            } else {
                return false
            }
        }
        
        return true
    }
}

extension JokesCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        jokeController?.jokes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = jokeCollectionView.dequeueReusableCell(withReuseIdentifier: "JokeCell", for: indexPath) as? JokeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.joke = jokeController?.jokes[indexPath.item]
        if let _ = jokeController?.token {
            cell.editJokeButon.isHidden = false
        } else {
             cell.editJokeButon.isHidden = true
        }
        
        return cell
    }
}

extension JokesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let jokeController = jokeController else { return }
        
        let joke = jokeController.jokes[indexPath.item]
        let alert = UIAlertController(title: "Punchline!", message: joke.punchline, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        jokeCollectionView?.reloadData()
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
