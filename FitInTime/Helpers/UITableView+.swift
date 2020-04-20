//
//  UITableView+.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 06/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeuseReusableCell(withIdentifier identifier: String, for indexPath: IndexPath,textLabelText: String?, detailTextLabelText: String?, selectionStyle: UITableViewCell.SelectionStyle?, accessoryType: UITableViewCell.AccessoryType?) -> UITableViewCell {
        
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = textLabelText
        cell.detailTextLabel?.text = detailTextLabelText
        if let selectionStyle = selectionStyle {
            cell.selectionStyle = selectionStyle
        }
        if let accessoryType = accessoryType {
            cell.accessoryType = accessoryType
        }
        return cell
    }
}
