//
//  ReportTrainingController+UITableView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 31/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ReportTrainingController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        performancesTableView.dataSource = self
        performancesTableView.delegate = self
        performancesTableView.tableFooterView = UIView()
        performancesTableView.allowsSelection = false
        performancesTableView.isScrollEnabled = false
        registerTableViewCells()
        setupTableViewHeight()
    }
    
    func registerTableViewCells() {
        performancesTableView.register(UITableViewCell.self, forCellReuseIdentifier: reportTrainingCellId)
        performancesTableView.register(RepsWeightCell.self, forCellReuseIdentifier: cellIds[0])
        performancesTableView.register(CardioCell.self, forCellReuseIdentifier: cellIds[1])
        performancesTableView.register(BodyweightCell.self, forCellReuseIdentifier: cellIds[2])
        performancesTableView.register(GainageCell.self, forCellReuseIdentifier: cellIds[3])
        performancesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIds[4])
    }
    
    func setupTableViewHeight() {
        var numberOfSets = 0
        sets.forEach { numberOfSets += $0.count }        
        tableViewHeight = CGFloat(exercices.count) * tableViewHeaderHeight + CGFloat(numberOfSets) * tableViewCellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let exercice = exercices[indexPath.section]
        let set = sets[indexPath.section][indexPath.row]        
        
        switch exercice.category {
        case "Poids libres","Machines, poulie", "Poids libres / Machines":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[0], for: indexPath) as! RepsWeightCell
            cell.set = set
            return cell
        case "Cardio":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[1], for: indexPath) as! CardioCell
            cell.set = set
            return cell
        case "Poids du corps":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[2], for: indexPath) as! BodyweightCell
            cell.set = set
            return cell
        case "Gainage":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[3], for: indexPath) as! GainageCell
            cell.set = set
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[4], for: indexPath)
            cell.textLabel?.text = ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .darkBlue
        label.textColor = .white
        label.textAlignment = .center
        label.text = exercices[section].name
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
}
