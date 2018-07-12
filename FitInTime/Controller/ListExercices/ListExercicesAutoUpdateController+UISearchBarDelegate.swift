//
//  ListExercicesAutoUpdateController+UISearchControllerDelegate.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 30/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if !searchText.isEmpty {
//            let predicate = NSPredicate(format: "name contains %@ && isListed = true", searchText)
            let predicate = NSPredicate(format: "name contains [cd] %@ && isListed = true", searchText)
            fetchResultsController.fetchRequest.predicate = predicate
        } else {
            fetchResultsController.fetchRequest.predicate = NSPredicate(format: "isListed = true")
        }        
        
        try? fetchResultsController.performFetch()
        tableView.reloadData()
    }
   
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        fetchResultsController.fetchRequest.predicate = NSPredicate(format: "isListed = true")
        try? fetchResultsController.performFetch()
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    
}

/*
 - (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
 - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
 - (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
 - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
 - (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
 
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
 - (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed
 - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
 - (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed

 */

