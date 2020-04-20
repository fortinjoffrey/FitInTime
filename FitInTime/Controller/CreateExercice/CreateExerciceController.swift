//
//  CreateExerciceController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class CreateExerciceController: UIViewController {
    
    let groups = ["Pectoraux" ,"Abdominaux", "Quadriceps","Deltoïdes","Biceps","Avant-bras","Trapèzes","Triceps","Lombaires","Ischio-Jambiers","Mollets","Fessiers","Dorsaux", "Cardio"].sorted()
    let categories = ["Poids libres","Machines, poulie", "Cardio","Poids du corps","Gainage"]
    
    var mainViewOriginY: CGFloat = 0.0
    
    let visualEffectView = BlurryVisualEffectView()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let mainView = MainView()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray
        textField.textAlignment = .center
        textField.placeholder = "Entrez nom"
        textField.delegate = self
        return textField
    }()
    
    let primaryGroupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sélectionner groupe", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    let secondaryGroupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("(Optionnel)", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exemple: Poids du corps", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        setupUI()
        setupPanGesture()
        setupTapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        mainViewOriginY = mainView.frame.origin.y
    }
    
    fileprivate func setupPanGesture() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    fileprivate func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        visualEffectView.addGestureRecognizer(tapGestureRecognizer)        
    }
    
    @objc fileprivate func handleGroupSelection(button: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        var dataArray: [String] = groups
        
        if button.tag == 2 && dataArray == groups {
            dataArray = categories
        }
        
        dataArray.forEach {
            alertController.addAction(UIAlertAction(title: $0, style: .default, handler: { (action) in
                button.setTitle(action.title, for: .normal)
            })) }
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = []
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        
        visualEffectView.alpha = 0
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        mainView.frame.origin.y =  mainViewOriginY + translation.y
        
        if gesture.state == .changed {            
            let percentage = translation.y / view.frame.height
            visualEffectView.alpha = 1 - percentage
            dismissButton.alpha = 1 - percentage
        }
        
        if gesture.state == .ended {
            
            let velocity = gesture.velocity(in: self.view)
            
            if velocity.y > 1000 || mainView.frame.origin.y >= view.frame.height / 2 {
                visualEffectView.alpha = 0
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.mainView.frame.origin.y = self.mainViewOriginY
                }
            }
        }
    }
    
    @objc func handleValidate() {
        
        guard let exerciceName = nameTextField.text else { return }
        guard let primaryGroupName = primaryGroupButton.titleLabel?.text else { return }
        guard let secondaryGroupName = secondaryGroupButton.titleLabel?.text else { return }
        guard let categoryName = categoryButton.titleLabel?.text else { return }
        
        if exerciceName.isEmpty || !groups.contains(primaryGroupName) || !categories.contains(categoryName) {
            showEmptyTextFieldAlert(message: "Veuillez compléter les champs")
            return
        }
        
        let tuple = CoreDataManager.shared.createExercice(name: exerciceName, category: categoryName, primaryGroup: primaryGroupName, secondaryGroup: secondaryGroupName, training: nil)
        
        if tuple.1 == nil {
            dismiss(animated: true, completion: nil)
        }
    }
}
