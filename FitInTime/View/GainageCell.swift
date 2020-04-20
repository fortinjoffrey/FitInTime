//
//  GainageCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 05/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class GainageCell: UITableViewCell {
    
    var set: Set? {
        didSet {
            if let duration = set?.duration {
                durationMinutesValueLabel.text = "\(duration / 60 % 60)"
                durationSecondsValueLabel.text = "\(duration % 60)"
            }
        }
    }    
    
    let durationMinutesValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let durationMinutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "min".uppercased()
        return label
    }()
    
    let durationSecondsValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let durationSecondsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "sec".uppercased()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        
        let middleSeparator = UIView()
        middleSeparator.backgroundColor = .darkBlue
        
        [durationMinutesValueLabel, durationMinutesLabel, middleSeparator, durationSecondsValueLabel, durationSecondsLabel].forEach { addSubview($0) }
        [].forEach { addSubview($0) }
        
        middleSeparator.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 2, height: 0)
        
        middleSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //        durationLabel.backgroundColor = .cyan
        
        durationMinutesLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: middleSeparator.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width / 4, height: 0)
        
        //        durationValueLabel.backgroundColor = .yellow
        
        durationMinutesValueLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: durationMinutesLabel.leftAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        //        weightLabel.backgroundColor = .cyan
        durationSecondsLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: frame.width / 4, height: 0)
        
        //        speedValueLabel.backgroundColor = .yellow
        durationSecondsValueLabel.anchor(top: topAnchor, left: middleSeparator.rightAnchor, bottom: bottomAnchor, right: durationSecondsLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
