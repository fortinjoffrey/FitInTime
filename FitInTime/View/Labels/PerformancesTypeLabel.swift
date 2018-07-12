//
//  PerformancesTypeLabel.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 13/07/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class PerformancesTypeLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text.uppercased()
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
