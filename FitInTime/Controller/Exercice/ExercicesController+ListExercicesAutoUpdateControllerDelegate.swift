//
//  ExercicesController+ListExercicesAutoUpdateControllerDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ExercicesController: ListExercicesAutoUpdateControllerDelegate {
    func didAddExerciceToTraining(exercice: Exercice) {
        exercices.append(exercice)
        let indexPath = IndexPath(row: exercices.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
    }    
}
