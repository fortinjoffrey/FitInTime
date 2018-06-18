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
    
    let sectionsAndRowsNumberArray = [[1,2], [2,1]]
    
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
//        case 0:
//            let cell = tableView.dequeuseReusableCell(withIdentifier: subtitleCellId, for: indexPath, textLabelText: "Title", detailTextLabelText: "Subtitle", selectionStyle: nil, accessoryType: nil)
//            return cell
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeuseReusableCell(withIdentifier: rightDetailCellId, for: indexPath, textLabelText: "Timer par défaut", detailTextLabelText: setupDefaultTimerText(), selectionStyle: nil, accessoryType: nil)
                return cell
            } else {
                let cell = tableView.dequeuseReusableCell(withIdentifier: defaultCellId, for: indexPath, textLabelText: "Lancer le timer automatiquement", detailTextLabelText: nil, selectionStyle: .none, accessoryType: nil)
                cell.accessoryView = setupTimerSwitch()
                return cell
            }
        default:
            let cell = tableView.dequeuseReusableCell(withIdentifier: rightDetailCellId, for: indexPath, textLabelText: "Version", detailTextLabelText: "1.1", selectionStyle: .none, accessoryType: .none)
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
    
    fileprivate func setupTimerSwitch() -> UISwitch {
        let automaticTimerSwitch = UISwitch()
        if let state = UserDefaults.standard.value(forKey: "automaticTimerSwitchIsOn") as? Bool {
            automaticTimerSwitch.isOn = state
        } else {
            UserDefaults.standard.set(true, forKey: "automaticTimerSwitchIsOn")
            automaticTimerSwitch.isOn = true
        }
        automaticTimerSwitch.tag = 0
        automaticTimerSwitch.addTarget(self, action: #selector(handleSwitchValueChanged), for: .valueChanged)
        return automaticTimerSwitch
    }
    
    @objc fileprivate func handleSwitchValueChanged( sender: UISwitch) {
        if sender.tag == 0 {
            UserDefaults.standard.set(sender.isOn, forKey: "automaticTimerSwitchIsOn")
        }
    }
    
    
}
