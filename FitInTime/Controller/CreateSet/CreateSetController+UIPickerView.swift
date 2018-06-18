//
//  CreateSetController+UIPickerView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension CreateSetController: UIPickerViewDataSource, UIPickerViewDelegate {
        
    func setupRepsWeightPickerViews() {
        
        repsPickerData = [Int16](1...100)
        weightPickerData = [Int16](0...200)
        
        repsPickerView.selectRow(9, inComponent: 0, animated: false)
        weightPickerView.selectRow(24, inComponent: 0, animated: false)
    }
    
    func setupDurationSpeedPickerViews() {
        
        durationPickerData = [Int16](1...90)
        speedPickerData = [Int16](1...32)
        
        durationPickerView.selectRow(14, inComponent: 0, animated: false)
        speedPickerView.selectRow(11, inComponent: 0, animated: false)
    }
    
    func setupMinutesSecondsPickerViews() {
        
        gainageMinutesPickerData = [Int16](0...30)
        gainageSecondsPickerData = [Int16](0...59)
        
        gainageMinutesPickerView.selectRow(0, inComponent: 0, animated: false)
        gainageSecondsPickerView.selectRow(30, inComponent: 0, animated: false)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        if pickerView == repsPickerView {
            label.text = "\(repsPickerData[row])"
        } else if pickerView == weightPickerView {
            label.text = "\(weightPickerData[row])"
        } else if pickerView == durationPickerView {
            label.text = "\(durationPickerData[row])"
        } else if pickerView == speedPickerView {
            label.text = "\(speedPickerData[row])"
        } else if pickerView == gainageMinutesPickerView {
            label.text = "\(gainageMinutesPickerData[row])"
        } else if pickerView == gainageSecondsPickerView {
            label.text = "\(gainageSecondsPickerData[row])"
        }
        return label
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == repsPickerView {
            return repsPickerData.count
        } else if pickerView == weightPickerView {
            return weightPickerData.count
        } else if pickerView == durationPickerView {
            return durationPickerData.count
        } else if pickerView == speedPickerView {
            return speedPickerData.count
        } else if pickerView == gainageMinutesPickerView {
            return gainageMinutesPickerData.count
        } else if pickerView == gainageSecondsPickerView {
            return gainageSecondsPickerData.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == repsPickerView {
            repsValueLabel.text = "\(repsPickerData[row])"
        } else if pickerView == weightPickerView{
            weightValueLabel.text = "\(weightPickerData[row])"
        } else if pickerView == durationPickerView {
            durationValueLabel.text = "\(durationPickerData[row])"
        } else if pickerView == speedPickerView {
            speedValueLabel.text = "\(speedPickerData[row])"
        } else if pickerView == gainageMinutesPickerView {
            gainageMinutesValueLabel.text = "\(gainageMinutesPickerData[row])"
        } else if pickerView == gainageSecondsPickerView {
            gainageSecondsValueLabel.text = "\(gainageSecondsPickerData[row])"
        }
    }
    
}
