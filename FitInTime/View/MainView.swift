//
//  MainView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 13/07/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
