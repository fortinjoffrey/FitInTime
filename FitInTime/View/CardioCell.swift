//
//  CardioCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 05/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class CardioCell: UITableViewCell {
    
    var set: Set? {
        didSet {
            if let duration = set?.duration, let speed = set?.speed {                
                durationValueLabel.text = "\(duration / 60)"
                speedValueLabel.text = "\(speed)"
            }
        }
    }
    
    
    let durationValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "min".uppercased()
        return label
    }()
    
    let speedValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let speedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "km / h".uppercased()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        
        let middleSeparator = UIView()
        middleSeparator.backgroundColor = .darkBlue
        
        [durationValueLabel, durationLabel, middleSeparator, speedValueLabel, speedLabel].forEach { addSubview($0) }
        [].forEach { addSubview($0) }
        
        middleSeparator.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 2, height: 0)
        
        middleSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //        durationLabel.backgroundColor = .cyan
        
        durationLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: middleSeparator.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width / 4, height: 0)
        
        //        durationValueLabel.backgroundColor = .yellow
        
        durationValueLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: durationLabel.leftAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        //        weightLabel.backgroundColor = .cyan
        speedLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: frame.width / 4, height: 0)
        
        //        speedValueLabel.backgroundColor = .yellow
        speedValueLabel.anchor(top: topAnchor, left: middleSeparator.rightAnchor, bottom: bottomAnchor, right: speedLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

