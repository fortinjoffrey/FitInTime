//
//  ListExercicesAutoUpdateController+UITableView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.allowsSelection = training == nil ? false : true
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: listExercicesCellId)
    }
    
    //MARK: DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = fetchResultsController.sections?[section].numberOfObjects {            
            return numberOfRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listExercicesCellId, for: indexPath)

        let exercice = fetchResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(exercice.name ?? "")"
        cell.accessoryType = selectedExercices.contains(exercice) ? .checkmark : .none
        
        return cell        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if training != nil { return UISwipeActionsConfiguration(actions: []) }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            let exercice = self.fetchResultsController.object(at: indexPath)
            _ = CoreDataManager.shared.deleteExercice(exercice: exercice)
            
            success(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
                
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        
        let exercice = fetchResultsController.object(at: indexPath)
        
        if let index = selectedExercices.index(of: exercice) {
            selectedExercices.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectedExercices.append(exercice)
            
            if (UserDefaults.standard.value(forKey: "automaticAddedAnimationSwitchIsOn") as? Bool == true) {
                let alertController = UIAlertController(title: "Ajouté", message: nil, preferredStyle: .alert)

                           present(alertController, animated: true, completion: nil)

                           let when = DispatchTime.now() + 0.5

                           DispatchQueue.main.asyncAfter(deadline: when){
                               alertController.dismiss(animated: true, completion: nil)}
            }
            cell.accessoryType = .checkmark            
        }
    
        return nil
    }
    
    
    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.textAlignment = .center
        if let sections = fetchResultsController.sections {
            label.text = sections[section].name
        } else {
            label.text = fetchResultsController.sectionIndexTitles[section]
        }
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}









