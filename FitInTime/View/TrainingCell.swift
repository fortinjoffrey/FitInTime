//
//  TrainingCell.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {
    
    var training: Training? {
        didSet {
            
            guard let startDate = training?.startDate else { return }
            guard let endDate = training?.endDate else { return }
            guard let name = training?.name else { return }
            
            if let isDone = training?.isDone {
                if isDone {
                    accessoryType = UITableViewCellAccessoryType.checkmark
                    stateView.backgroundColor = .blueCustom
                    stateLabel.text = "TERMINÉ"
                } else {
                    accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    stateView.backgroundColor = .red
                    stateLabel.text = "EN COURS"
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "FR_fr")
            dateFormatter.dateFormat = "dd"
            let dayString = dateFormatter.string(from: startDate)
            dateFormatter.dateFormat = "MMMM"
            let monthString = dateFormatter.string(from: startDate)
            
            let attributedText = NSMutableAttributedString(string: "\(dayString)\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: monthString.uppercased(), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: UIFont.systemFontSize - 3), NSAttributedStringKey.foregroundColor:UIColor.gray]))
            
            dateLabel.attributedText = attributedText
            
            nameLabel.text = name
            
            
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
            
            if let hours = components.hour, let minutes = components.minute {
                if hours < 0 || minutes < 0 || hours > 23 {
                    durationLabel.text = ""
                } else {
                    durationLabel.text = "\(hours)h" + String(format: "%02d", minutes)
                }
            }
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        return label
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        return label
    }()
    
    let stateView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        setupViews()
        
        setupLayout()
    }
    
    fileprivate func setupViews() {
        [dateLabel, stateView, nameLabel, durationLabel, stateLabel].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        
        dateLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: frame.width / 7, height: 0)
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stateView.anchor(top: nil, left: dateLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 3, height: frame.height / 2)
        stateView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.anchor(top: nil, left: stateView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: frame.width / 1.5, height: 0)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stateLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width / 2, height: 0)
        
        durationLabel.anchor(top: stateLabel.topAnchor, left: stateLabel.rightAnchor, bottom: stateLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width / 5, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
