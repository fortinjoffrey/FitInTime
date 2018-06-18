//
//  SettingsTimerController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 06/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SettingsTimerController: UITableViewController {
    
    let cellId = "cellId"
    let defaultTimerCounts = [15, 30, 45, 60, 90, 120, 180, 300, 450, 600, 900]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Timer par défaut"
        tabBarController?.tabBar.isHidden = true
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultTimerCounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let count = defaultTimerCounts[indexPath.row]
        cell.textLabel?.text = "\(count / 60):" + String(format: "%02d", count % 60)
        if let savedCount = UserDefaults.standard.value(forKey: "DefaultTimerCount") as? Int {
            if savedCount == count {
                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.selectionStyle = .none
                cell.accessoryType = .checkmark
            }
        } else {
            UserDefaults.standard.set(90, forKey: "DefaultTimerCount")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let count = defaultTimerCounts[indexPath.row]
        cell?.accessoryType = .checkmark
        cell?.selectionStyle = .none
        UserDefaults.standard.set(count, forKey: "DefaultTimerCount")
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

