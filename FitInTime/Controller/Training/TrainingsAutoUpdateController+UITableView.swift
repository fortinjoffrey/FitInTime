//
//  TrainingsAutoUpdateController+UITableView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension TrainingsAutoUpdateController {
    
    func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.register(TrainingCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width / 7 + 11 , bottom: 0, right: 30)
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = fetchResultsController.sectionIndexTitles[section]
//        return label
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections![section].numberOfObjects
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrainingCell
        
        let training = fetchResultsController.object(at: indexPath)
        cell.training = training
        
        return cell
    }
    
    // MARK: Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Supprimer") { (action, view, success) in
            
            let alertController = UIAlertController(title: "Êtes-vous sur ?", message: "Cette action est irréversible", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
                success(true)
            }))
            alertController.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: { (action) in
                let training = self.fetchResultsController.object(at: indexPath)
                _ = CoreDataManager.shared.deleteTraining(training: training)
                success(true)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Modifier") { (action, view, success) in
            
            let createTrainingController = CreateTrainingController()
            let navController = UINavigationController(rootViewController: createTrainingController)
            
            let training = self.fetchResultsController.object(at: indexPath)
            
            createTrainingController.training = training            
            
            self.present(navController, animated: true, completion: nil)
            success(true)
        }
        editAction.backgroundColor = .darkBlue
        
        let reportAction = UIContextualAction(style: .normal, title: "Résumé") { (action, view, success) in
            
            let reportTrainingController = ReportTrainingController()
            reportTrainingController.modalPresentationStyle = .overFullScreen
            let training = self.fetchResultsController.object(at: indexPath)
            reportTrainingController.training = training
            self.present(reportTrainingController, animated: true, completion: nil)
            
            success(true)
        }
        reportAction.backgroundColor = .blue
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction, reportAction])
        config.performsFirstActionWithFullSwipe = false
        return config
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let training = fetchResultsController.object(at: indexPath)
        
        let exercicesController = ExercicesController()
        exercicesController.delegate = self
        exercicesController.training = training
        navigationController?.pushViewController(exercicesController, animated: true)
        return nil
    }
    
    // MARK: FOOTER
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Pas d'entraînements enregistrés"
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let count = fetchResultsController.fetchedObjects?.count else { return 0 }
        return count > 0 ? 0 : 150
    }
}
