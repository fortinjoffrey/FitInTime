//
//  MainTabBarController.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 14/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        setupControllers()                
    }
    
    fileprivate func setupControllers() {                
        
        let trainingsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "trainings_unselected"), selectedImage: #imageLiteral(resourceName: "trainings_selected"), rootViewController: TrainingsAutoUpdateController())
        trainingsNavController.tabBarItem.title = "Entraînements"
        
        let exercicesNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "exercices_unselected"), selectedImage: #imageLiteral(resourceName: "exercices_selected"), rootViewController: ListExercicesAutoUpdateController())
        exercicesNavController.tabBarItem.title = "Exercices"
        
        let timerLayout = UICollectionViewFlowLayout()
        let timerNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "timer_unselected"), selectedImage: #imageLiteral(resourceName: "timer_selected"), rootViewController: SelectionController(collectionViewLayout: timerLayout))
        timerNavController.tabBarItem.title = "Timer"
        
        let settingsController = SettingsController(style: .grouped)
        let settingsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "settings_unselected"), selectedImage: #imageLiteral(resourceName: "settings_selected"),rootViewController: settingsController)
        settingsNavController.tabBarItem.title = "Paramètres"
        
        tabBar.tintColor = .orangeCustom
        viewControllers = [trainingsNavController, exercicesNavController, timerNavController, settingsNavController]        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
}
