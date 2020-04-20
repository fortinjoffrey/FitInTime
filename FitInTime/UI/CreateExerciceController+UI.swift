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
        
        let nameLabel           = createLabel(for: "Nom de l'exercice")
        let primaryGroupLabel   = createLabel(for: "Groupe musculaire principal")
        let secondaryGroupLabel = createLabel(for: "Groupe musculaire secondaire")
        let categoryLabel       = createLabel(for: "Catégorie de l'exercice")
        
        let confirmButton: ValidateButton = {
               let button = ValidateButton(type: .system)
               button.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
               return button
           }()
        
        nameTextField.inputAccessoryView = createKeyboardToolBar()
        
        let views = [nameLabel, nameTextField, primaryGroupLabel, primaryGroupButton, secondaryGroupLabel, secondaryGroupButton, categoryLabel, categoryButton]
        let stackView = createStackView(with: views, for: .vertical)
        
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let stackViewHeight = 400
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: CGFloat(stackViewHeight + 32 + 32 + 50))
        
        mainView.addSubview(confirmButton)
        confirmButton.anchor(top: nil, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 50)
        
        mainView.addSubview(stackView)
        stackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 400)
        
        
        
    }
    
    
    
}
