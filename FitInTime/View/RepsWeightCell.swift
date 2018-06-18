//
//  RepsWeightCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class RepsWeightCell: UITableViewCell {
    
    var set: Set? {
        didSet {
            if let reps = set?.repetitions, let weight = set?.weight {
                repsValueLabel.text = "\(reps)"
                weightValueLabel.text = "\(weight)"
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
    
    let weightValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .blueCustom
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "kgs".uppercased()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        
        let middleSeparator = UIView()
        middleSeparator.backgroundColor = .darkBlue
        
        [repsValueLabel, repsLabel, middleSeparator, weightValueLabel, weightLabel].forEach { addSubview($0) }
        
        middleSeparator.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 2, height: 0)
        
        middleSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        repsLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: middleSeparator.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width / 4, height: 0)
        
        repsValueLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: repsLabel.leftAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        weightLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: frame.width / 4, height: 0)
        
        weightValueLabel.anchor(top: topAnchor, left: middleSeparator.rightAnchor, bottom: bottomAnchor, right: weightLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/*
 var set: Set? {
 didSet {
 
 if let reps = set?.repetitions, let weight = set?.weight {
 
 let boldAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor:UIColor.black]
 
 let valueAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor:UIColor.blue,NSAttributedStringKey.backgroundColor:UIColor.orange]
 
 let repsString = String(reps)
 
 let finalRepsString = "".padding(toLength: 3 - repsString.count , withPad: " ", startingAt: 0) + "\(reps)"
 
 let weightString = String(weight)
 
 let finalWeightString = "".padding(toLength: 3 - weightString.count, withPad: " ", startingAt: 0) + "\(weight)"
 
 
 let attributedText = NSMutableAttributedString(string: finalRepsString, attributes: valueAttributes)
 
 attributedText.append(NSAttributedString(string: "    REPS\t\t", attributes: boldAttributes ))
 
 attributedText.append(NSAttributedString(string: finalWeightString, attributes: valueAttributes))
 
 attributedText.append(NSAttributedString(string: "    KGS", attributes: boldAttributes))
 
 label.attributedText = attributedText
 }
 }
 }
 */
