//
//  ListExercicesAutoUpdateController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol ListExercicesAutoUpdateControllerDelegate {
    func didAddExerciceToTraining(exercice: Exercice)
}

class ListExercicesAutoUpdateController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let listExercicesCellId = "listExercicesCellId"
    var training: Training?
    var delegate: ListExercicesAutoUpdateControllerDelegate?
    var selectedExercices = [Exercice]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Entrez nom de l'exercice"
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
        searchController.searchBar.tintColor = .white // Cancel color
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    lazy var fetchResultsController: NSFetchedResultsController<Exercice> = {
        
        let request: NSFetchRequest<Exercice> = Exercice.fetchRequest()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let groupSortDescriptor = NSSortDescriptor(key: "primaryGroup", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))        
        
        //        request.predicate = NSPredicate(format: "date > %@", NSDate())
        request.predicate = NSPredicate(format: "isListed = true")
        
        request.sortDescriptors = [groupSortDescriptor, nameSortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "primaryGroup", cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        return frc
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_blueCustom").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAddView), for: .touchUpInside)
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
        setupUI()
        setupTableView()
        setupNavBar()
        definesPresentationContext = true
        createDefaultsExercicesIfNeeded()
    }
    
    fileprivate func createDefaultsExercicesIfNeeded() {
        if UserDefaults.standard.object(forKey: "hasAlreadyBeenLauched") == nil {
            createDefaultsExercices()
            UserDefaults.standard.set(true, forKey: "hasAlreadyBeenLauched")
        }
    }
    
    /*
     * Might call this method upon "Reset All Exercices To Default" inside the settings page
     */
    @objc func handleReset() {
        UserDefaults.standard.set(nil, forKey: "hasAlreadyBeenLauched")
        
        fetchResultsController.fetchedObjects?.forEach({ (exercice) in
            _ = CoreDataManager.shared.deleteExercice(exercice: exercice)
        })        
        createDefaultsExercices()
        UserDefaults.standard.set(true, forKey: "hasAlreadyBeenLauched")
    }
    
    fileprivate func createExerciceIntoTraining(exercice: Exercice) {
        
        guard let training = self.training else { return }
        guard let name = exercice.name else { return }
        guard let category = exercice.category else { return }
        guard let primaryGroup = exercice.primaryGroup else { return }
        
        let tuple = CoreDataManager.shared.createExercice(name: name, category: category, primaryGroup: primaryGroup, secondaryGroup: exercice.secondaryGroup, training: training)
        if let error = tuple.1 {
            print(error)
        } else {
            if let exercice = tuple.0 {
                self.delegate?.didAddExerciceToTraining(exercice: exercice)
            }            
        }
    }
    
    @objc fileprivate func handleAddView() {
        let createExerciceController = CreateExerciceController()
        createExerciceController.modalPresentationStyle = .overFullScreen
        present(createExerciceController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleDone() {
        dismiss(animated: true) {
            self.selectedExercices.forEach {
                self.createExerciceIntoTraining(exercice: $0)
            }
        }
    }
    
}
