//
//  SetsController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol SetsControllerDelegate {
    func didFinishExercice(exercice: Exercice)
}

class SetsController: UIViewController {
    
    var sets = [Set]()
    var delegate: SetsControllerDelegate?
    var trainingIsDone: Bool? = false
    var exercice: Exercice? {
        didSet {
            navigationItem.title = exercice?.name
        }
    }
    
    let cellIds = ["repsWeightCellId", "cardioCellId", "bodyweightCellId", "gainageCellId", "cellId"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_blueCustom").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "confirm_blueCustom").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
        setupTableView()
        fetchSets()
    }
    
    @objc private func handleDone() {
        
        if CoreDataManager.shared.saveExerciceIsDone(isDone: true, exercice: exercice) {
            if let exercice = exercice {
                self.delegate?.didFinishExercice(exercice: exercice)
                navigationController?.popViewController(animated: true)
            }
        }             
    }
    
    @objc private func handleAdd() {
        
        let createSetController = CreateSetController()
        createSetController.modalPresentationStyle = .overFullScreen
        if let trainingIsDone = trainingIsDone {
            createSetController.trainingIsDone = trainingIsDone
        }
        createSetController.exercice = exercice
        createSetController.delegate = self
        present(createSetController, animated: true, completion: nil)
    }
        
    func fetchSets() {        
        guard let exerciceSets = exercice?.sets?.allObjects as? [Set] else { return }        
        let sortedSets = exerciceSets.sorted(by: { $0.date! < $1.date! })
        sets = sortedSets
    }
}








