//
//  SetsController+UI.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 16/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension SetsController {
    
    func setupUI() {
        
        if let isDone = exercice?.isDone {
            confirmButton.isHidden = !isDone ? false : true
        }
        
        [tableView, plusButton, confirmButton].forEach { view.addSubview($0) }
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        plusButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: tabBarHeight + 16, paddingRight: 16, width: 50, height: 50)
        
        confirmButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: tabBarHeight + 16, paddingRight: 0, width: 50, height: 50)
    }
    
}
