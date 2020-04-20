//
//  SetsController+CreateSetControllerDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension SetsController: CreateSetControllerDelegate {
    func didAddSet(set: Set) {
        exercice?.lastSet = set
        sets.append(set)
        let indexPath = IndexPath(row: sets.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)        
    }
    
    func didEditSet(set: Set) {
        guard let row = sets.index(of: set) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }    
}
