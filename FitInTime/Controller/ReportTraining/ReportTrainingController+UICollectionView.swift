//
//  ReportTrainingController+UICollectionView.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 31/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ReportTrainingController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        groupsCollectionView.dataSource = self
        groupsCollectionView.delegate = self
        groupsCollectionView.register(GroupCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        groupsCollectionView.allowsSelection = false
        groupsCollectionView.isScrollEnabled = false        
        setupCollectionViewHeight()
    }
    
    func setupCollectionViewHeight() {
        
        guard let exercices = training?.exercices?.allObjects as? [Exercice] else { return }
        var countedOccurencesOfSamePrimaryGroups:[String:Int] = [:]
        exercices.forEach {
            if let group = $0.primaryGroup {
                if let counter = countedOccurencesOfSamePrimaryGroups[group] {
                    countedOccurencesOfSamePrimaryGroups[group] = counter + 1
                } else {
                    countedOccurencesOfSamePrimaryGroups[group] = 1
                }
            }
        }
        sortedCountedGroups = countedOccurencesOfSamePrimaryGroups.sorted { $0.value > $1.value }
        collectionViewHeight += CGFloat(sortedCountedGroups.count) * collectionViewCellHeight
        collectionViewHeight += CGFloat(max(sortedCountedGroups.count - 1, 0)) * collectionViewSpacing
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return sortedCountedGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! GroupCell

        if let _ = indexPath.first {
            let sum = sortedCountedGroups.reduce(0) { (result, tuple) -> Int in
                result + tuple.value
            }
            cell.numberOfExercices = sum
        }
        
        cell.groupNameAndOccurences = self.sortedCountedGroups[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
    
}
