//
//  TableViewController.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 25/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
//    var tableData = ["Jambes", "Epaules", "Pectoraux"]
    var tableData = [Training(name: "Jambes", date: Date()),
                     Training(name: "Epaules", date: Date()),
                     Training(name: "Pecs", date: Date())
                    ]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.title = "Trainings"
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .red
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        
    }
}

extension TableViewController {
    
    
    // MARK: Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
                
        cell.training = tableData[indexPath.row]
        
        return cell
    }
    
    
    
    // MARK: Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            
            self.tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            success(true)
        }
        deleteAction.backgroundColor = .red
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
    // MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    /*
     
     */
    
    
    
}

