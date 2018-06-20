//
//  CreateTrainingController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateTrainingControllerDelegate {
    func didAddTraining(training: Training)
}

class CreateTrainingController: UIViewController {
    
    var training: Training? {
        didSet {
            guard let name = training?.name else { return }
            guard let startDate = training?.startDate else { return }
            
            nameTextField.text = name
            startDatePicker.date = startDate
            isDone = training?.isDone
            
            if let endDate = training?.endDate, let notation = training?.notation, let tirednessNotation = training?.tirednessNotation, let notes = training?.notes {
                
                endDatePicker.date = endDate
                notationPicker.selectRow(Int(notation), inComponent: 0, animated: false)
                tirednessNotationPicker.selectRow(Int(tirednessNotation), inComponent: 0, animated: false)
                notesTextView.text = notes
            }
        }
    }
    
    var isDone: Bool?
    
    var delegate: CreateTrainingControllerDelegate?
    
    var selectedTextArea: Any?
    var textfieldMode: Bool?
    let heightForHorizontalPickerView: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Ex: Jambes / Épaules"
        tf.textAlignment = .center
        tf.inputAccessoryView = createKeyboardToolBar()
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    let startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    let endDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    let notationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    let tirednessNotationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.redToGreenMode = false
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    lazy var notesTextView: UITextView = {
        let tf = UITextView()
        tf.delegate = self
        tf.text = ""
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.inputAccessoryView = createKeyboardToolBar()
        tf.backgroundColor = .white
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = .darkBlue
        
        setupNavBar()
        setupUI()
        setupTapGesture()
        setupObservers()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = training == nil ? "Créer entraînement" : "Modifier"
        setupCancelButtonInNavBar()
        setupSaveButtonInNavBar(selector: #selector(handleSave))
    }
    
    fileprivate func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func createTraining(name: String, isDone: Bool) {
        
        let endDate = isDone ? endDatePicker.date : startDatePicker.date
        
        let tuple = CoreDataManager.shared.createTraining(name: name, startDate: startDatePicker.date, endDate: endDate, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true) {
                if let training = tuple.0 {
                    self.delegate?.didAddTraining(training: training)
                }                
            }
        }
    }
    
    private func saveTrainingChanges(name: String, isDone: Bool) {
        
        let tuple = CoreDataManager.shared.saveTrainingChanges(name: name, startDate: startDatePicker.date, endDate: endDatePicker.date, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone, training: training)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }        
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        guard let isDone = isDone else { return }
        
        if name.isEmpty {
            showEmptyTextFieldAlert(message: "Entrer un nom pour votre séance")
            return
        }
        
        training == nil ? createTraining(name: name, isDone: isDone) : saveTrainingChanges(name: name, isDone: isDone)
    }
}



















