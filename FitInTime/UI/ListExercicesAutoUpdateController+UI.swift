//
//  ListExercicesAutoUpdateController+UI.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 16/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController {
    
    func setupUI() {
        
        plusButton.isHidden = training == nil ? false : true
        confirmButton.isHidden = training == nil ? true : false
        
        [tableView, plusButton, confirmButton].forEach { view.addSubview($0) }
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        confirmButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 16, width: 50, height: 50)
        
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        plusButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: tabBarHeight + 16, paddingRight: 16, width: 50, height: 50)
    }
    
    func setupNavBar() {
        
        navigationItem.title = training == nil ? "Listes des exercices" : "Ajouter exercices"
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    
}
