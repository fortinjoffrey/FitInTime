//
//  SelectionController+Delegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 14/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension SelectionController: RunningTimerControllerDelegate {
    
    func didFinishTimer() {
        tabBarController?.selectedIndex = 0
    }
    
}
