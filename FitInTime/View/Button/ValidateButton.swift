//
//  ValidateButton.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 19/04/2020.
//  Copyright © 2020 Joffrey Fortin. All rights reserved.
//

import UIKit

class ValidateButton : UIButton {
    
    override init(frame: CGRect) {
          super.init(frame: frame)
    }
    
    convenience init(type: UIButton.ButtonType) {
        self.init(frame: .zero)
        setTitle("Valider", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = .blueCustom
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
