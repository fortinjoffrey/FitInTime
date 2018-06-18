//
//  ReportTrainingController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 31/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class ReportTrainingController: UIViewController {
    
    let reportTrainingCellId = "reportTrainingCellId"
    let collectionViewCellId = "collectionViewCellId"
    let cellIds = ["repsWeightCellId", "cardioCellId", "bodyweightCellId", "gainageCellId", "cellId"]
    
    var training: Training? {
        didSet {
            
            guard let startDate = training?.startDate else { return }
            guard let endDate = training?.endDate else { return }
            
            let calendar = Calendar.current
            var durationText = ""
            let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
            if let hours = components.hour, let minutes = components.minute {
                if hours < 0 || minutes < 0 || hours > 23 {
                    durationText = ""
                } else {
                    durationText = "\(hours) h " + String(format: "%02d", minutes) + " min"
                }
                setupBlackBoldAttributedText(for: durationLabel, firstString: "", secondString: durationText, size: 16)
            }
            
            if let numberOfExercices = training?.exercices?.allObjects.count {
                setupBlackBoldAttributedText(for: exercicesNumberLabel, firstString: "\(numberOfExercices)", secondString: " exercices"  , size: 16)
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "FR_fr")
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .short
//            dateFormatter.dateFormat = "EEEE d MMM yyyy à hh:mm"
            dateLabel.text = "Le " + dateFormatter.string(from: startDate)
            dateLabel.font = UIFont.boldSystemFont(ofSize: 16)                    
            
            guard let notes = training?.notes else { return }
            notesTextView.text = notes
        }
    }        
    
    var notationLabelWidth: CGFloat = 0.0
    
    var exercices = [Exercice]()
    var sets = [[Set]]()
    
    let tableViewCellHeight: CGFloat = 40
    let tableViewHeaderHeight: CGFloat = 40
    var tableViewHeight: CGFloat = 0
    
    var sortedCountedGroups: [(key: String, value: Int)] = []
    
    let collectionViewCellHeight: CGFloat = 40
    let collectionViewSpacing: CGFloat = 4
    var collectionViewHeight: CGFloat = 0
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let scrollContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "down-arrow-black").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
//        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let exercicesNumberLabel: UILabel = {
        let label = UILabel()
//        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    let notesTextView: UITextView = {
        let tf = UITextView()
        tf.text = ""
        tf.isEditable = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .white
        return tf
    }()
    
    
    let performancesTableView: UITableView = {
        let tv = UITableView() 
        return tv
    }()
    
    let groupsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        fetchExercices()
        setupTableView()
        setupCollectionView()
        setupUI()
    }

    private func fetchExercices() {
        guard let trainingExercices = training?.exercices?.allObjects as? [Exercice] else { return }
        exercices = trainingExercices.sorted(by: { $0.date! < $1.date!  })
        exercices.forEach { fetchSets(exercice: $0)  }
    }
    
    private func fetchSets(exercice: Exercice) {
        guard let exerciceSets = exercice.sets?.allObjects as? [Set] else { return }
        sets.append( exerciceSets.sorted(by: { $0.date! < $1.date!} ))
    }
    
}

















