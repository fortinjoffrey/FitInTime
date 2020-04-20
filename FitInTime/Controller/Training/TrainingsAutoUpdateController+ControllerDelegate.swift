//
//  TrainingsAutoUpdateController+ControllerDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

extension TrainingsAutoUpdateController: EvaluateTrainingControllerDelegate {
    func didEvaluateTraining(training: Training) {
        presentReportTrainingController(for: training)
    }
    
    fileprivate func presentReportTrainingController(for training: Training) {
        let reportTrainingController = ReportTrainingController()
        reportTrainingController.modalPresentationStyle = .overFullScreen
        reportTrainingController.training = training
        self.present(reportTrainingController, animated: true, completion: nil)
    }
}

extension TrainingsAutoUpdateController: ExercicesControllerDelegate {
    func didFinishTraining(training: Training) {        
        guard let indexPath = fetchResultsController.indexPath(forObject: training) else { return }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        presentEvaluateTrainingController(for: training)
    }
    
    fileprivate func presentEvaluateTrainingController(for training: Training) {
        let evaluateTrainingController = EvaluateTrainingController()
        evaluateTrainingController.modalPresentationStyle = .overFullScreen
        evaluateTrainingController.training = training
        evaluateTrainingController.delegate = self
        present(evaluateTrainingController, animated: true, completion: nil)
    }            
}

extension TrainingsAutoUpdateController: CreateTrainingControllerDelegate {
    func didAddTraining(training: Training) {        
        guard let indexPath = fetchResultsController.indexPath(forObject: training) else { return }
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        _ = tableView(tableView, willSelectRowAt: indexPath)      
    }
}

extension TrainingsAutoUpdateController {
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .top)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .left)
        case .move:
            break
        case .update:
            break
        default:
            break
    }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .left)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .middle)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
}
