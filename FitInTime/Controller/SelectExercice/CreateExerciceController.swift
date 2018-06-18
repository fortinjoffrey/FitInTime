//
//  SelectExerciceController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateExerciceControllerDelegate {
    func didAddExercice(exercice: Exercice)
    func didEditExercice(exercice: Exercice)
}

class SelectExerciceController: UIViewController {
    
    var training: Training?
    var exercice: Exercice? {
        didSet {
            nameTextfield.text = exercice?.name
            categoryTextfield.text = exercice?.category
            categoryTextfield.backgroundColor = .green
        }
    }
    var delegate: CreateExerciceControllerDelegate?
    
    lazy var nameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Entrez un nom pour votre exercice"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.delegate = self
        return tf
    }()
    
    let categoryData = ["Poids libres / Machines", "Cardio","Poids du corps","Gainage"]
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Catégorie"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var categoryTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Choisir catégorie"
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.delegate = self
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = exercice == nil ? "Créer exercice" : "Modifier"
        
        setupCancelButton()
        setupSaveButtonInNavBar(selector: #selector(handleSave))
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func handleCategoryTextfield() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        categoryData.forEach {
            alertController.addAction(UIAlertAction(title: $0, style: .default, handler: { (action) in
                
                UIView.animate(withDuration: 1, animations: {
                    self.categoryTextfield.text = action.title
                    self.categoryTextfield.backgroundColor = .green
                })
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
        
        guard let name = nameTextfield.text else { return }
        guard let category = categoryTextfield.text else { return }
        
        if name.isEmpty {
            showEmptyTextFieldAlert(message: "Entrer un nom pour votre exercice")
            return
        } else if category.isEmpty {
            showEmptyTextFieldAlert(message: "Entrer une catégorie pour votre exercice")
            return
        }
        
        if exercice == nil {
            createExercice(name: name, category: category)
        } else {
            saveExerciceChanges(name: name, category: category)
        }
    }
    
    private func createExercice(name: String, category: String) {
        
        guard let training = training else { return }
        
//        let tuple = CoreDataManager.shared.createExercice(name: name, category: category, training: training)
        let tuple = CoreDataManager.shared.createExercice(name: name, category: category, primaryGroup: "Primary", secondaryGroup: nil, training: training)
        
        if let error = tuple.1 {
            // present an alert
            print(error)
        } else {
            dismiss(animated: true) {
                if let exercice = tuple.0 {
                    self.delegate?.didAddExercice(exercice: exercice)
                }
            }
        }                
    }
    
    private func saveExerciceChanges(name: String, category: String) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        exercice?.name = name
        exercice?.category = category
        
        do {
            try context.save()
            dismiss(animated: true) {
                if let exercice = self.exercice {
                    self.delegate?.didEditExercice(exercice: exercice)
                }
            }
        } catch let saveErr {
            print("Failed to save changes:", saveErr)
        }
    }
    
    private func setupUI() {
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightBlue
        
        [backgroundView, nameTextfield, categoryLabel, categoryTextfield].forEach { view.addSubview($0) }
        
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        nameTextfield.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        categoryLabel.anchor(top: nameTextfield.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: view.frame.width / 2, height: 50)
        
        categoryTextfield.anchor(top: categoryLabel.topAnchor, left: categoryLabel.rightAnchor, bottom: categoryLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
}




