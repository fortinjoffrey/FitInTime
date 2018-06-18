//
//  CreateExerciceController+UI.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 16/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension CreateExerciceController {
    
    func setupUI() {
        
       
        
        [visualEffectView, dismissButton, mainView].forEach { view.addSubview($0) }
        
        let nameLabel = createLabel(for: "Nom de l'exercice")
        let primaryGroupLabel = createLabel(for: "Groupe musculaire principal")
        let secondaryGroupLabel = createLabel(for: "Groupe musculaire secondaire")
        let categoryLabel = createLabel(for: "Catégorie de l'exercice")
        
        let cancelButton = createButton(title: "Annuler", titleColor: .red, action: #selector(handleCancel))
        let confirmButton = createButton(title: "Confirmer", titleColor: .blue, action: #selector(handleValidate))
        
        let buttonStackView = createStackView(with: [cancelButton, confirmButton], for: .horizontal)
        
        nameTextField.inputAccessoryView = createKeyboardToolBar()
        
        let views = [nameLabel, nameTextField, primaryGroupLabel, primaryGroupButton, secondaryGroupLabel, secondaryGroupButton, categoryLabel, categoryButton, buttonStackView]
        let stackView = createStackView(with: views, for: .vertical)
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        dismissButton.anchor(top: nil, left: nil, bottom: mainView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height * 0.8)
        
        mainView.addSubview(stackView)
        stackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 450)
    }
    
    
}
