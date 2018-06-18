//
//  SettingsSubtitleCell.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 17/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SettingsSubtitleCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
