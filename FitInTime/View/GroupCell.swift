//
//  GroupCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 31/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class GroupCell: UICollectionViewCell {
    
    var numberOfExercices: Int?
    
    var groupNameAndOccurences:(key: String, value: Int)? {
        didSet {
            groupLabel.text = groupNameAndOccurences?.key
            if let numberOfExercices = self.numberOfExercices, let count = groupNameAndOccurences?.value {
                let percentage = CGFloat(count) / CGFloat(numberOfExercices) * 100                
                percentageLabel.text = String(format: "%.0f", percentage) + "%"
            }            
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        addSubview(containerView)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let stackView = UIStackView(arrangedSubviews: [groupLabel, percentageLabel])
        containerView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
}
