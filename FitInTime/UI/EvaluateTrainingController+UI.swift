//
//  EvaluateTrainingController+UI.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 15/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension EvaluateTrainingController {
    
    func setupUI() {
        setupVisualEffectMainViews()
        setupNotationViewsAndValidateButton()
        notesTextView.inputAccessoryView = createKeyboardToolBar()
    }
    
    fileprivate func setupVisualEffectMainViews() {
        
        [visualEffectView, mainView].forEach { view.addSubview($0) }
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: view.frame.height * 0.8)
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    fileprivate func setupNotationViewsAndValidateButton() {
                
        let notesLabel = createLabel(for: "Remarques sur la séance")
        
        
        
        let notationLabel = createLabel(for: "Notez la séance")
        let notationContainerView = setupNotationContainerView(for: notationPicker)
        let tirednessNotationLabel = createLabel(for: "Évaluez votre fatigue")
        let tirednessNotationContainerView = setupNotationContainerView(for: tirednessNotationPicker)
        let stackView = createStackView(with: [notesLabel, notesTextView,notationLabel, notationContainerView, tirednessNotationLabel, tirednessNotationContainerView, validateButton], for: .vertical)
        
        [stackView].forEach { mainView.addSubview($0) }
        
        stackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    fileprivate func setupNotationContainerView(for notationPickerView: NotationPickerView) -> UIView {
        
        let notationContainerView = UIView()
        notationContainerView.addSubview(notationPickerView)        
        
        NSLayoutConstraint.activate([
            notationPickerView.centerXAnchor.constraint(equalTo: notationContainerView.centerXAnchor),
            notationPickerView.centerYAnchor.constraint(equalTo: notationContainerView.centerYAnchor)
            ])
        
        notationPickerView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: view.frame.width - 32)
        
        return notationContainerView
    }
    
    
}








