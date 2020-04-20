//
//  UIViewController+Helpers.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import UserNotifications

extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupSaveButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sauvegarder", style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func showEmptyTextFieldAlert(message: String) {
        let alertController = UIAlertController(title: "Champ vide", message: message, preferredStyle: .alert)
        let alertConfirmedAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertConfirmedAction)
        present(alertController, animated: true, completion: nil)
    }        
    
    func sendUserNotification(identifier: String, timeInterval: TimeInterval, title: String, body: String) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let err = err {
                print(err)
            }
        }        
    }
    
    func createLabel(for text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    func createStackView(with views: [UIView], for axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = .fillEqually
        stackView.axis = axis
        return stackView
    }
    
    func setupBlackBoldAttributedText(for label: UILabel, firstString: String, secondString: String, size: CGFloat) {
        
        let attributedText = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: size)])
        
        attributedText.append(NSAttributedString(string: secondString, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: size)]))
        
        label.attributedText = attributedText
    }
    
    func createButton(title: String, titleColor: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func createSeparatorView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupKeyboardToolBar(for textView: UITextView) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Terminer", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolBar.items = [flexibleSpace, doneButton]
        textView.inputAccessoryView = toolBar
    }
    
    func createKeyboardToolBar() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Terminer", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolBar.items = [flexibleSpace, doneButton]
        return toolBar
    }
        
}











