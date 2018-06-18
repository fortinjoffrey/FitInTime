//
//  TrainingsController.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 25/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

class TrainingsController: UITableViewController {
    
    var trainings = [Training]()

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.title = "Trainings"
        
        setupPlusButtonInNavBar(selector: #selector(handleAddTraining))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .red
        
        tableView.register(TrainingCell.self, forCellReuseIdentifier: cellId)
        
        
        self.trainings = CoreDataManager.shared.fetchTrainings()
        
    }
    
    
    @objc private func handleAddTraining() {
        
        let createTrainingController = CreateTrainingController()
        let navController = UINavigationController(rootViewController: createTrainingController)

//        createTrainingController.delegate = self
        
        present(navController, animated: true, completion: nil)        
    }
    
    @objc private func handleReset() {
        
        let alertController = UIAlertController(title: "Êtes-vous sûr ?", message: "Cette action est entraînera la suppression de vos données", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Oui", style: .destructive) { (action) in
            
            if CoreDataManager.shared.performBatchDeleteRequest() {
                self.resetTableView()
            }            
        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        [confirmAction, cancelAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetTableView() {
        var indexPathsToRemove = [IndexPath]()
        
        for (index,_) in trainings.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            indexPathsToRemove.append(indexPath)
        }
        
        trainings.removeAll()
        tableView.deleteRows(at: indexPathsToRemove, with: .left)
    }
}



