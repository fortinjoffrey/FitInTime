//
//  CreateSetController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateSetControllerDelegate {
    func didAddSet(set: Set)
    func didEditSet(set: Set)
}





class CreateSetController: UIViewController {
    
    var trainingIsDone: Bool = false
    var delegate: CreateSetControllerDelegate?
    var exercice: Exercice? {
        didSet {
        }
    }
    var mainViewOriginY: CGFloat = 0.0

    let visualEffectView = BlurryVisualEffectView()
    
    let mainView = MainView()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: Labels
    
    let repsLabel = PerformancesTypeLabel(text: "reps")
    let weightLabel = PerformancesTypeLabel(text: "kgs")
    let durationLabel = PerformancesTypeLabel(text: "minutes")
    let speedLabel = PerformancesTypeLabel(text: "km / h")
    let gainageMinutesLabel = PerformancesTypeLabel(text: "minutes")
    let gainageSecondsLabel  = PerformancesTypeLabel(text: "secondes")
    
    // MARK: Value Labels
    let repsValueLabel = PerformancesValueLabel(text: "10")
    let weightValueLabel = PerformancesValueLabel(text: "24")
    let durationValueLabel = PerformancesValueLabel(text: "15")
    let speedValueLabel  = PerformancesValueLabel(text: "12")
    let gainageMinutesValueLabel = PerformancesValueLabel(text: "0")
    let gainageSecondsValueLabel = PerformancesValueLabel(text: "30")
    
    
    // MARK: Picker Data Variables
    var repsPickerData = [Int16]()
    var weightPickerData = [Int16]()
    var durationPickerData = [Int16]()
    var speedPickerData = [Int16]()
    var gainageMinutesPickerData = [Int16]()
    var gainageSecondsPickerData = [Int16]()
    
    // MARK: Picker Views
    lazy var repsPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var weightPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var durationPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var speedPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var gainageMinutesPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var gainageSecondsPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    let validateButton: ValidateButton = {
        let button = ValidateButton(type: .system)
        button.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
        return button
    }()
    
    @objc func handleValidate() {
        
        guard let exercice = exercice else { return }
        
        var tuple: (Set?, Error?)
        
        switch exercice.category {
        case "Poids libres","Machines, poulie":
            let repetitions = repsPickerData[repsPickerView.selectedRow(inComponent: 0)]
            let weight = weightPickerData[weightPickerView.selectedRow(inComponent: 0)]
            tuple = CoreDataManager.shared.createSet(duration: 0, speed: 0, repetitions: repetitions, weight: weight, exercice: exercice)
            
        case "Cardio":
            let durationMinutes = durationPickerData[durationPickerView.selectedRow(inComponent: 0)]
            let speed = speedPickerData[speedPickerView.selectedRow(inComponent: 0)]
            tuple = CoreDataManager.shared.createSet(duration: durationMinutes * 60, speed: speed, repetitions: 0, weight: 0, exercice: exercice)
            
        case "Poids du corps":
            let repetitions = repsPickerData[repsPickerView.selectedRow(inComponent: 0)]
            tuple = CoreDataManager.shared.createSet(duration: 0, speed: 0, repetitions: repetitions, weight: 0, exercice: exercice)
            
        case "Gainage":
            let durationMinutes = gainageMinutesPickerData[gainageMinutesPickerView.selectedRow(inComponent: 0)]
            let durationSeconds = gainageSecondsPickerData[gainageSecondsPickerView.selectedRow(inComponent: 0)]
            let duration = durationMinutes * 60 + durationSeconds
            tuple = CoreDataManager.shared.createSet(duration: duration, speed: 0, repetitions: 0, weight: 0, exercice: exercice)
            
        default:
            return
        }
        
        if let set = tuple.0 {
            self.delegate?.didAddSet(set: set)
            
            let alertController = UIAlertController(title: "Ajouté", message: nil, preferredStyle: .alert)
            
            present(alertController, animated: true, completion: nil)
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when){                
                alertController.dismiss(animated: true, completion: {                    
                    if !self.trainingIsDone && UserDefaults.standard.value(forKey: "automaticTimerSwitchIsOn") as? Bool == true {
                        let runningTimerController = RunningTimerController()
                        runningTimerController.modalPresentationStyle = .overFullScreen
                        
                        if let count = UserDefaults.standard.value(forKey: "DefaultTimerCount") as? Int {
                            runningTimerController.timerValue = CGFloat(count)
                        } else {
                            runningTimerController.timerValue = CGFloat(90)
                        }
                        self.present(runningTimerController, animated: true, completion: nil)
                    }
                })
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPanGesture()
    }
    
    override func viewDidLayoutSubviews() {
        mainViewOriginY = mainView.frame.origin.y
    }
    
    fileprivate func setupPanGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc fileprivate func handleGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        if translation.y < 0 {
            return
        }
        mainView.frame.origin.y =  mainViewOriginY + translation.y
        
        if gesture.state == .changed {
            let percentage = translation.y / view.frame.height
            visualEffectView.alpha = 1 - percentage
            dismissButton.alpha = 1 - percentage
        }
        
        if gesture.state == .ended {
            
            let velocity = gesture.velocity(in: self.view)
            
            if velocity.y > 1000 || mainView.frame.origin.y >= view.frame.height / 2 {
                visualEffectView.alpha = 0
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.mainView.frame.origin.y = self.mainViewOriginY
                }
            }
        }
    }
    
    
    
    
    func setupUI() {
        
        [visualEffectView, dismissButton, mainView].forEach { view.addSubview($0) }
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height * 0.7)
        
        dismissButton.anchor(top: nil, left: nil, bottom: mainView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainView.addSubview(validateButton)
        
        validateButton.anchor(top: nil, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 50)
        
        switch exercice?.category {
        case "Poids libres","Machines, poulie":
            setupUIForRepsWeight()
        case "Cardio":
            setupUIForCardio()
        case "Poids du corps":
            setupUIForBodyweight()
        case "Gainage":
            setupUIForGainage()
        default:
            return
        }
    }
    
    func setupUIForRepsWeight() {
        
        setupRepsWeightPickerViews()
        
        let repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsValueLabel])
        repsStackView.axis = .vertical
        repsStackView.distribution = .fillEqually
        
        let weightStackView = UIStackView(arrangedSubviews: [weightLabel, weightValueLabel])
        weightStackView.axis = .vertical
        weightStackView.distribution = .fillEqually
        
        let repsWeightLabelStackView = UIStackView(arrangedSubviews: [repsStackView, weightStackView])
        repsWeightLabelStackView.axis = .horizontal
        repsWeightLabelStackView.distribution = .fillEqually
        
        let repsWeightPickerStackView = UIStackView(arrangedSubviews: [repsPickerView, weightPickerView])
        repsWeightPickerStackView.axis = .horizontal
        repsWeightPickerStackView.distribution = .fillEqually
        
        [repsWeightLabelStackView, repsWeightPickerStackView].forEach { mainView.addSubview($0) }
        
        repsWeightLabelStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        repsWeightPickerStackView.anchor(top: nil, left: mainView.leftAnchor, bottom: validateButton.topAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
    }
    
    func setupUIForCardio() {
        
        setupDurationSpeedPickerViews()
        
        let durationStackView = UIStackView(arrangedSubviews: [durationLabel, durationValueLabel])
        durationStackView.axis = .vertical
        durationStackView.distribution = .fillEqually
        
        let speedStackView = UIStackView(arrangedSubviews: [speedLabel, speedValueLabel])
        speedStackView.axis = .vertical
        speedStackView.distribution = .fillEqually
        
        let durationSpeedLabelStackView = UIStackView(arrangedSubviews: [durationStackView, speedStackView])
        durationSpeedLabelStackView.axis = .horizontal
        durationSpeedLabelStackView.distribution = .fillEqually
        
        let durationSpeedPickerStackView = UIStackView(arrangedSubviews: [durationPickerView, speedPickerView])
        durationSpeedPickerStackView.axis = .horizontal
        durationSpeedPickerStackView.distribution = .fillEqually
        
        [durationSpeedLabelStackView, durationSpeedPickerStackView].forEach { mainView.addSubview($0) }
        
        durationSpeedLabelStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        durationSpeedPickerStackView.anchor(top: nil, left: mainView.leftAnchor, bottom: validateButton.topAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
    }
    
    func setupUIForBodyweight() {
        
        setupRepsWeightPickerViews()
        
        let repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsValueLabel])
        repsStackView.axis = .vertical
        repsStackView.distribution = .fillEqually
        
        [repsStackView, repsPickerView].forEach { mainView.addSubview($0) }
        
        repsStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        repsPickerView.anchor(top: nil, left: mainView.leftAnchor, bottom: validateButton.topAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
    }
    
    func setupUIForGainage() {
        
        setupMinutesSecondsPickerViews()
        
        let minutesStackView = UIStackView(arrangedSubviews: [gainageMinutesLabel, gainageMinutesValueLabel])
        minutesStackView.axis = .vertical
        minutesStackView.distribution = .fillEqually
        
        let secondsStackView = UIStackView(arrangedSubviews: [gainageSecondsLabel, gainageSecondsValueLabel])
        secondsStackView.axis = .vertical
        secondsStackView.distribution = .fillEqually
        
        let minutesSecondsLabelStackView = UIStackView(arrangedSubviews: [minutesStackView, secondsStackView])
        minutesSecondsLabelStackView.axis = .horizontal
        minutesSecondsLabelStackView.distribution = .fillEqually
        
        let minutesSecondsPickerStackView = UIStackView(arrangedSubviews: [gainageMinutesPickerView, gainageSecondsPickerView])
        minutesSecondsPickerStackView.axis = .horizontal
        minutesSecondsPickerStackView.distribution = .fillEqually
        
        [minutesSecondsLabelStackView, minutesSecondsPickerStackView].forEach { mainView.addSubview($0) }
        
        minutesSecondsLabelStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        minutesSecondsPickerStackView.anchor(top: nil, left: mainView.leftAnchor, bottom: validateButton.topAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
    }
}
