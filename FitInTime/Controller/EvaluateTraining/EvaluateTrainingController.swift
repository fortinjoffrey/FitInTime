//
//  EvaluateTrainingController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 12/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol EvaluateTrainingControllerDelegate {
    func didEvaluateTraining(training: Training)
}

class EvaluateTrainingController: UIViewController {
    
    var training: Training?
    var delegate: EvaluateTrainingControllerDelegate?
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        return visualEffectView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
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
    
    let notesTextView: UITextView = {
        let tf = UITextView()
        tf.text = ""        
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .white
        return tf
    }()
    
    let validateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Valider", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc fileprivate func handleValidate() {
        guard let training = training else { return }
        CoreDataManager.shared.saveNotationsForTraining(notes: notesTextView.text, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData,training: training)
        dismiss(animated: true) {
            self.delegate?.didEvaluateTraining(training: training)
        }
    }
    
}






