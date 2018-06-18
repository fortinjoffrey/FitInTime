//
//  SelectionCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 07/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SelectionCell: UICollectionViewCell {
    
    var timer: SelectedTimer? {
        didSet {
            guard let seconds = timer?.seconds else { return }
            guard let minutes = timer?.minutes else { return }
            
            let boldAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor:UIColor.gray]
            
            let valueAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor:UIColor.black]
            
            var attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: ""))
            
            if minutes == 0 {
                attributedText = NSMutableAttributedString(string: "\(seconds)", attributes: valueAttributes)
                attributedText.append(NSAttributedString(string: "SEC", attributes: boldAttributes ))
            } else if seconds == 0 {
                attributedText = NSMutableAttributedString(string: "\(minutes)", attributes: valueAttributes)
                attributedText.append(NSAttributedString(string: "MIN", attributes: boldAttributes ))
            } else {
                attributedText = NSMutableAttributedString(string: "\(minutes)", attributes: valueAttributes)
                attributedText.append(NSAttributedString(string: "MIN", attributes: boldAttributes ))
                attributedText.append(NSAttributedString(string: "\(seconds)", attributes: valueAttributes))
                attributedText.append(NSAttributedString(string: "SEC", attributes: boldAttributes))
            }
            timerLabel.attributedText = attributedText
        }
    }        
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
//        backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
        backgroundColor = .lightBlue
        
        addSubview(timerLabel)
        
        timerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        layer.cornerRadius = 10
//        setupCellShadow()
        
    }
    
    private func setupCellShadow() {
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        clipsToBounds = false
        layer.cornerRadius = 10
    }
    
}
















