//
//  BodyweightCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 05/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class BodyweightCell: UITableViewCell {
    
    var set: Set? {
        didSet {
            if let reps = set?.repetitions {
                repsValueLabel.text = "\(reps)"
            }
        }
    }
    
    let repsValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "reps".uppercased()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        
        [repsValueLabel, repsLabel].forEach { addSubview($0) }        
        
        repsLabel.anchor(top: topAnchor, left: centerXAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        repsValueLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: centerXAnchor , paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
