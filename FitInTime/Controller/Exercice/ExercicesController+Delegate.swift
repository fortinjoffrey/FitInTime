//
//  ExercicesControllerDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ExercicesController: SetsControllerDelegate {
    func didFinishExercice(exercice: Exercice) {
        guard let row = exercices.firstIndex(of: exercice) else { return }
        exercices[row] = exercice        
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }    
}
