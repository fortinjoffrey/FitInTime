//
//  TrainingsController+CreateTraining.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension TrainingsController: CreateTrainingControllerDelegate {
    
    func didEditTraining(training: Training) {
        guard let row = trainings.index(of: training) else { return }
        let reloadIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .fade)
    }
    
    func didAddTraining(training: Training) {
        trainings.append(training)
        let newIndexPath = IndexPath(row: trainings.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
