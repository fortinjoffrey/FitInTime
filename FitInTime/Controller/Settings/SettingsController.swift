//
//  SettingsController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 17/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    let subtitleCellId = "subtitleCellId"
    let rightDetailCellId = "rightDetailCellId"
    let defaultCellId = "defaultCellId"
    
    let sectionsAndRowsNumberArray = [[1,3], [2,1]]
    
           let tagNumberDict: [onOffSettingsEnum:Int] = [onOffSettingsEnum.automaticTimer         :0,   onOffSettingsEnum.automaticAddedAnimation :1]
    
    enum onOffSettingsEnum {
        case automaticTimer, automaticAddedAnimation
       }
    
    enum onOffSettings {
        case title, forKey
    }
    
    let test: [onOffSettingsEnum: [onOffSettings:String]] =
        [onOffSettingsEnum.automaticTimer:
            [onOffSettings.title:"Lancer le timer automatiquement",
             onOffSettings.forKey:"automaticTimerSwitchIsOn"],
         onOffSettingsEnum.automaticAddedAnimation:
         [onOffSettings.title:"Notification lors d'un ajout d'exercice",
          onOffSettings.forKey:"automaticAddedAnimationSwitchIsOn"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Paramètres"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Réinitialiser", style: .plain, target: self, action: #selector(handleReset))
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    @objc fileprivate func handleReset() {
        UserDefaults.standard.set(nil, forKey: "automaticTimerSwitchIsOn")
         UserDefaults.standard.set(nil, forKey: "automaticAddedAnimationSwitchIsOn")
        UserDefaults.standard.set(nil, forKey: "DefaultTimerCount")
        tableView.reloadData()
    }
    
    fileprivate func registerTableViewCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        tableView.register(SettingsSubtitleCell.self, forCellReuseIdentifier: subtitleCellId)
        tableView.register(SettingsRightDetailCell.self, forCellReuseIdentifier: rightDetailCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsAndRowsNumberArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsAndRowsNumberArray[section][1]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeuseReusableCell(withIdentifier: rightDetailCellId, for: indexPath, textLabelText: "Timer par défaut", detailTextLabelText: setupDefaultTimerText(), selectionStyle: nil, accessoryType: nil)
                return cell
            } else if indexPath.row == 1 {
           
                let cell = tableView.dequeuseReusableCell(withIdentifier: defaultCellId, for: indexPath, textLabelText: test[onOffSettingsEnum.automaticTimer]?[onOffSettings.title], detailTextLabelText: nil, selectionStyle: nil, accessoryType: nil)
                cell.accessoryView = setupTimerSwitch(value: onOffSettingsEnum.automaticTimer)
                return cell
            } else {
                let cell = tableView.dequeuseReusableCell(withIdentifier: defaultCellId, for: indexPath, textLabelText: test[onOffSettingsEnum.automaticAddedAnimation]?[onOffSettings.title], detailTextLabelText: nil, selectionStyle: Optional.none, accessoryType: nil)
                cell.accessoryView = setupTimerSwitch(value: onOffSettingsEnum.automaticAddedAnimation)
                return cell
            }
            
        default:
            let cell = tableView.dequeuseReusableCell(withIdentifier: rightDetailCellId, for: indexPath, textLabelText: "Version", detailTextLabelText: "1.1", selectionStyle: Optional.none, accessoryType: Optional.none)
            cell.accessoryType = .none
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let settingsTimerController = SettingsTimerController(style: .grouped)
            navigationController?.pushViewController(settingsTimerController, animated: true)
        }
    }
    
    fileprivate func setupDefaultTimerText() -> String {
        if let count = UserDefaults.standard.value(forKey: "DefaultTimerCount") as? Int {
            return "\(count / 60):" + String(format: "%02d", count % 60)
        }
        return "1:30"
    }
    
    
    fileprivate func setupTimerSwitch(value: onOffSettingsEnum) -> UISwitch {
        if let forKey = test[value]?[onOffSettings.forKey] {
        
            let swtch = UISwitch()
                   if let state = UserDefaults.standard.value(forKey: forKey) as? Bool {
                       swtch.isOn = state
                   } else {
                       UserDefaults.standard.set(true, forKey: forKey)
                       swtch.isOn = true
                   }
                   swtch.tag = tagNumberDict[value] ?? -1
                   swtch.addTarget(self, action: #selector(handleSwitchValueChanged), for: .valueChanged)
                   return swtch
        } else {
            return UISwitch()
        }
    }
    
    @objc fileprivate func handleSwitchValueChanged(sender: UISwitch) {
        
        if let key = tagNumberDict.first(where: {$0.value == sender.tag })?.key {
            if let forKey =  test[key]?[onOffSettings.forKey] {
                UserDefaults.standard.set(sender.isOn, forKey: forKey)
            }
        }
        
    }
    
}
