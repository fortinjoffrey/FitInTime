//
//  CreateExerciceController+UITextFieldDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension CreateExerciceController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
