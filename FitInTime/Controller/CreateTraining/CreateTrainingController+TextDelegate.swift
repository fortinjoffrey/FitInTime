//
//  CreateTrainingController+TextDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//


import UIKit

extension CreateTrainingController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextArea = textField
        textfieldMode = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        selectedTextArea = textView
        textfieldMode = false
        return true
    }
    
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {        
        offSetBottomAnchor(notification: notification)
    }
    
    func offSetBottomAnchor(notification: NSNotification) {
        
        guard let info = notification.userInfo else { return }
        guard let rect = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }
        guard let textfieldMode = textfieldMode else { return }
        
        var targetY: CGFloat = 0
        var originY: CGFloat = 0
        
        if textfieldMode {
            guard let textfield = selectedTextArea as? UITextField else { return }
            targetY = view.frame.height - rect.height - 20 - textfield.frame.height
            originY = textfield.frame.origin.y - scrollView.contentOffset.y
        } else {
            guard let textview = selectedTextArea as? UITextView else { return }
            targetY = view.frame.height - rect.height - 20 - textview.frame.height
            originY = textview.frame.origin.y - scrollView.contentOffset.y
        }
        
        let difference = targetY - originY                
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
        
        if difference < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: self.scrollView.contentOffset.y - difference), animated: false)
        }
        
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
}
