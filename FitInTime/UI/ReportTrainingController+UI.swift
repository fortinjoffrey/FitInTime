//
//  ReportTrainingController+UI.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 08/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ReportTrainingController {
    
    func setupUI() {
        setupSubViews()
        setupVisualEffectMainViews()
        setupLayout()
    }
    
    func setupSubViews() {
        view.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)
        [dismissButton, groupsCollectionView, performancesTableView].forEach { scrollContainerView.addSubview($0) }
    }
    
    // 8 P + 25 D + 16 P + 70 D + collectionViewHeight + tableViewHeigt
    
    fileprivate func setupVisualEffectMainViews() {
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let scrollContainerViewHeight: CGFloat = 8 + 25 + 16 + 50 + 16 + 1 + 16 + 200 + 16 + 1 + 16 + collectionViewHeight + 16 + 1 + 16 + 50 + 16 + 1 + 16 + tableViewHeight + 16 + 1 + 16 + 50 + 16 + 1 + 16 + 200
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: scrollContainerViewHeight)
        
        dismissButton.anchor(top: scrollContainerView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func createAndFillNotationLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        
        if let notation = training?.notation {
            let hue = CGFloat(notation)/CGFloat(10) * 0.3
            let hueColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
            label.backgroundColor = hueColor
            label.text = "Note\n\(notation)"            
        }
        label.font = UIFont.boldSystemFont(ofSize: 14)        
        label.font = UIFont(name: "AvenirNext-Bold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        
        return label
    }
    
    
    
    func setupLayout() {
        
        guard let name = training?.name else { return }
        let nameLabel = createLabel(for: name)
        let nameSeparator = createSeparatorView(color: .red)
        
        let views = [dateLabel,durationLabel, exercicesNumberLabel]
        let infoStackView = createStackView(with: views, for: .vertical)
        
        let infoSeparator = createSeparatorView(color: .lightBlue)
        
//        groupsCollectionView
        
        let groupsSeparator = createSeparatorView(color: .lightBlue)
        
        let performancesLabel = createLabel(for: "Vos performances par exercice")
        
        let performancesLabelSeparator = createSeparatorView(color: .blueCustom)
        
        let performancesSeparator = createSeparatorView(color: .lightBlue)
        
//        performancesTableView
        
        
        let notesLabel = createLabel(for: "Vos remarques sur la séance")
        
        let notesSeparator = createSeparatorView(color: .blueCustom)
        
        let notationSeparator = createSeparatorView(color: .blueCustom)
        
        
        [nameLabel, nameSeparator, infoStackView, infoSeparator, groupsSeparator, performancesLabel, performancesLabelSeparator, performancesSeparator, notesLabel, notesSeparator,notesTextView, notationSeparator].forEach { scrollContainerView.addSubview($0) }
        
        nameLabel.anchor(top: dismissButton.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: scrollContainerView.frame.width  * 0.2, height: 50)
        
        nameSeparator.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width * 0.3, height: 6)
        nameSeparator.centerXAnchor.constraint(equalTo: scrollContainerView.centerXAnchor).isActive = true
        
        infoStackView.anchor(top: nameSeparator.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 90)
        
        infoSeparator.anchor(top: infoStackView.bottomAnchor, left: nameSeparator.leftAnchor, bottom: nil, right: nameSeparator.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        groupsCollectionView.anchor(top: infoSeparator.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: collectionViewHeight)
        
        groupsSeparator.anchor(top: groupsCollectionView.bottomAnchor, left: nameSeparator.leftAnchor, bottom: nil, right: nameSeparator.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        performancesLabel.anchor(top: groupsSeparator.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        performancesLabelSeparator.anchor(top: performancesLabel.bottomAnchor, left: nameSeparator.leftAnchor, bottom: nil, right: nameSeparator.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 6)
        
        
        performancesTableView.anchor(top: performancesLabelSeparator.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: tableViewHeight)
        
        performancesSeparator.anchor(top: performancesTableView.bottomAnchor, left: nameSeparator.leftAnchor, bottom: nil, right: nameSeparator.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        notesLabel.anchor(top: performancesSeparator.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        notesSeparator.anchor(top: notesLabel.bottomAnchor, left: nameSeparator.leftAnchor, bottom: nil, right: nameSeparator.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 6)
        
        notesTextView.anchor(top: notesSeparator.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right:scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        if let notationInfoStackView = createStackViewForNotationInfo() {
            
            scrollContainerView.addSubview(notationInfoStackView)
            notationInfoStackView.anchor(top: notesTextView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right:scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 60)
        }
    }
        
    
    fileprivate func createStackViewForNotationInfo() -> UIStackView? {
        
        // notation

        let notationLabel = createLabel(for: "Séance")
        guard let notation = training?.notation else { return nil }
        let notationValueLabel = createLabel(for: "\(notation)")
        
        let hue = CGFloat(notation) / 11 * 0.3
        notationValueLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        let notationViews = [notationLabel, notationValueLabel]
        let notationStackView = createStackView(with: notationViews, for: .vertical)
        
        // tiredness notation
        
        let tirednessNotationLabel = createLabel(for: "Fatigue")
        guard let tirednessNotation = training?.tirednessNotation else { return nil }
        let tirednessNotationValueLabel = createLabel(for: "\(tirednessNotation)")
        
        let tirednessHue = CGFloat(11 - tirednessNotation - 1) / 11 * 0.3
        tirednessNotationValueLabel.backgroundColor = UIColor(hue: tirednessHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        
        let tirednessViews = [tirednessNotationLabel, tirednessNotationValueLabel]
        let tirednessStackView = createStackView(with: tirednessViews, for: .vertical)
        
        let views = [notationStackView, tirednessStackView]
        return createStackView(with: views, for: .horizontal)
    }
    
    
    
}















