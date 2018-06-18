//
//  TrainingsController+UITableView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension TrainingsController {
    
    
    // MARK: Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrainingCell
        
        cell.training = trainings[indexPath.row]
        
        return cell
    }
    
    
    
    // MARK: Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            let training = self.trainings[indexPath.row]
            
            if CoreDataManager.shared.deleteTraining(training: training) {
                self.trainings.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                success(true)
            }
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Modifier") { (action, view, success) in
            
            let createTrainingController = CreateTrainingController()
            let navController = UINavigationController(rootViewController: createTrainingController)
            
//            createTrainingController.delegate = self
            
            let training = self.trainings[indexPath.row]
            
            createTrainingController.training = training
            
            self.present(navController, animated: true, completion: nil)
            success(true)
        }
        editAction.backgroundColor = .darkBlue
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
    // MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
