//
//  BlurryVisualEffectView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 12/07/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class BlurryVisualEffectView: UIVisualEffectView {
    
    init() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        super.init(effect: blurEffect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
