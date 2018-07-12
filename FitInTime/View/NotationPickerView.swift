//
//  NotationPickerView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class NotationPickerView: UIPickerView {
    
    open let data = [Int16](0...10)
    var selectedData: Int16 = 5
    var redToGreenMode = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        let rotationAngle: CGFloat = -.pi / 2
        self.transform = CGAffineTransform(rotationAngle: rotationAngle)
        self.selectRow(Int(selectedData), inComponent: 0, animated: false)
    }
    
    convenience init(redToGreenMode: Bool) {
        self.init(frame: .zero)
        self.redToGreenMode = redToGreenMode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.forEach {
            $0.layer.borderWidth = 0
            $0.isHidden = $0.frame.height <= 1.0
        }
    }
}

extension NotationPickerView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension NotationPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {        
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(data[row])"
        
        let hue = redToGreenMode ? CGFloat(row)/CGFloat(data.count) * 0.3 : CGFloat(data.count - row - 1)/CGFloat(data.count) * 0.3
        
//        let hue = CGFloat(row)/CGFloat(data.count) * 0.3
        label.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        
        let rotationAngle: CGFloat = .pi / 2
        label.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedData = data[row]
    }
}
