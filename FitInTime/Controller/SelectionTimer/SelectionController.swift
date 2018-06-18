//
//  SelectionController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 07/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SelectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var timers = [SelectedTimer(seconds: 15, minutes: 0),
                  SelectedTimer(seconds: 30, minutes: 0),
                  SelectedTimer(seconds: 45, minutes: 0),
                  SelectedTimer(seconds: 0, minutes: 1),
                  SelectedTimer(seconds: 30, minutes: 1),
                  SelectedTimer(seconds: 0, minutes: 2),
                  SelectedTimer(seconds: 0, minutes: 3),
                  SelectedTimer(seconds: 0, minutes: 5),
                  SelectedTimer(seconds: 30, minutes: 7),
                  SelectedTimer(seconds: 0, minutes: 10),
                  SelectedTimer(seconds: 0, minutes: 15)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Timer"
        navigationItem.largeTitleDisplayMode = .never        
        collectionView?.backgroundColor = .white
        collectionView?.register(SelectionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension SelectionController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timers.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectionCell
        
        cell.timer = timers[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedTimer = timers[indexPath.item]
        
        guard let seconds = selectedTimer.seconds else { return }
        guard let minutes = selectedTimer.minutes else { return }
        let count = minutes * 60 + seconds
        
        let runningTimerController = RunningTimerController()
        runningTimerController.modalPresentationStyle = .overFullScreen
        runningTimerController.delegate = self
        runningTimerController.timerValue = CGFloat(count)
        
        
        present(runningTimerController, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 50, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 35, left: 35, bottom: 8, right: 35)
    }
    
}






