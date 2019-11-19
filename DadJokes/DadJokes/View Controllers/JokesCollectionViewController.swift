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
    
    lazy var fetchedResultsController: NSFetchedResultsController<Joke> = {
        let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
                                        //NSSortDescriptor(key: "title", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print("Error fetching: \(error)")
        }
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = jokeCollectionView.dequeueReusableCell(withReuseIdentifier: "JokeCell", for: indexPath) as? JokeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.joke = fetchedResultsController.object(at: indexPath)
        
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

extension JokesCollectionViewController: NSFetchedResultsControllerDelegate {
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        jokeCollectionView.beginUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
//        default:
//            break
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            guard let newIndexPath = newIndexPath else { return }
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        case .update:
//            guard let indexPath = indexPath else { return }
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        case .move:
//            guard let oldIndexPath = indexPath,
//                let newIndexPath = newIndexPath else { return }
//            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        case .delete:
//            guard let indexPath = indexPath else { return }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        @unknown default:
//            break
//        }
//    }
}
