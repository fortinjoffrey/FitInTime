//
//  TrainingsAutoUpdateController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

class TrainingsAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let cellId = "cellId"
    
    lazy var fetchResultsController: NSFetchedResultsController<Training> = {
        
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        
//        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let endDateSortDescriptor = NSSortDescriptor(key: "endDate", ascending: false)
        
        request.sortDescriptors = [endDateSortDescriptor]
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Entraînements"
        navigationController?.navigationBar.backgroundColor = .mainColor
        navigationController?.setStatusBarColor(backgroundColor: .mainColor)
        setupPlusButtonInNavBar(selector: #selector(handleAdd))        
    }
    
    func presentCreateTrainingController(isDone: Bool) {
        
        let createTrainingController = CreateTrainingController()
        createTrainingController.isDone = isDone
        createTrainingController.delegate = self
        
        let navController = CustomNavigationController(rootViewController: createTrainingController)
//        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated: true, completion: nil)        
    }
    
    @objc private func handleAdd(button: UIBarButtonItem) {
        
        let trainingCategories = ["Entraînement terminé", "Entraînement en cours", "Entraînement futur"]
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for (index, value) in trainingCategories.enumerated() {
            
            let isDone = index == 0 ? true : false
            alertController.addAction(UIAlertAction(title: value, style: .default, handler: { (_) in
                self.presentCreateTrainingController(isDone: isDone)
            }))
        }
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertController.modalPresentationStyle = .popover

        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = button
        }
        present(alertController, animated: true, completion: nil)
    }
}



