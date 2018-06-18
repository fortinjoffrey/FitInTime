//
//  ListExercicesAutoUpdateController+Exercices.swift
//  FitInTime
//
//  Created by Joffrey Fortin on 29/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController {
    
    func createDefaultsExercices() {
        
//        let categories = ["Poids libres","Machines, poulie", "Cardio","Poids du corps","Gainage"]
        
        let defaultsExercices = [
            // PECTORAUX DE BASE
            ["Développé couché barre", "Pectoraux", "Triceps", "Poids libres"],
            ["Développé couche haltères","Pectoraux","Triceps","Poids libres"],
            ["Développé incliné barre","Pectoraux","Triceps","Poids libres"],
            ["Développé incliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Développé decliné barre","Pectoraux","Triceps","Poids libres"],
            ["Dips prise large buste penché","Pectoraux","Triceps","Poids du corps"],
            ["Pull over","Pectoraux","Triceps","Poids libres"],
            ["Pec deck","Pectoraux","Triceps","Machines, poulie"],
            ["Pompes prise large","Pectoraux","Triceps","Poids du corps"],
            ["Écarté machine","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté couché haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté couché poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté decliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté decliné poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté incliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté incliné poulie","Pectoraux","Triceps","Machines, poulie"],
            
            // DELTOIDES DE BASE
            ["Développé militaire barre","Deltoïdes","","Poids libres"],
            ["Développé militaire haltères","Deltoïdes","","Poids libres"],
            ["Développé militaire machines","Deltoïdes","","Machines, poulie"],
            ["Développé nuque barre","Deltoïdes","","Poids libres"],
            ["Développé nuque haltères","Deltoïdes","","Poids libres"],
            ["Développé arnold","Deltoïdes","","Poids libres"],
            ["Élévations latérales haltères","Deltoïdes","","Poids libres"],
            ["Élévations latérales poulie","Deltoïdes","","Machines, poulie"],
            ["Élévations frontales haltères","Deltoïdes","","Poids libres"],
            ["Élévations frontales barre","Deltoïdes","","Poids libres"],
            ["Élévations frontales poulie","Deltoïdes","","Machines, poulie"],
            ["Rowing barre coudes ouverts","Deltoïdes","","Poids libres"],
            ["Rowing poulie coudes ouverts","Deltoïdes","","Machines, poulie"],
            ["Oiseau poulie","Deltoïdes","Trapèzes","Machines, poulie"],
            ["Oiseau haltères","Deltoïdes","Trapèzes","Poids libres"],
            
            // ABDOMINAUX
            ["Crunch","Abdominaux","","Poids du corps"],
            ["Crunch poulie haute","Abdominaux","","Machines, poulie"],
            ["Crunch machine","Abdominaux","","Machines, poulie"],
            ["Enroulement du bassin","Abdominaux","","Poids du corps"],
            ["Gainage planche","Abdominaux","","Gainage"],
            ["Gainage oblique","Abdominaux","","Gainage"],
            ["Flexions latérales","Abdominaux","","Poids du corps"],
            ["Obliques","Abdominaux","","Poids du corps"],
            
            // QUADRICEPS
            ["Hack squat","Quadriceps","","Poids libres"],
            ["Front squat barre","Quadriceps","","Poids libres"],
            ["Front squat smith machine","Quadriceps","","Machines, poulie"],
            ["Squat barre","Quadriceps","","Poids libres"],
            ["Squat smith machine","Quadriceps","","Machines, poulie"],
            ["Montées sur banc","Quadriceps","","Poids du corps"],
            ["Fentes smith machine","Quadriceps","","Machines, poulie"],
            ["Fentes haltères","Quadriceps","","Poids libres"],
            ["Leg extension","Quadriceps","","Machines, poulie"],
            
            // BICEPS
            ["Curl haltères","Biceps","","Poids libres"],
            ["Curl barre","Biceps","","Poids libres"],
            ["Curl poulie basse","Biceps","","Machines, poulie"],
            ["Curl incliné","Biceps","","Poids libres"],
            ["Curl marteau poulie basse","Biceps","","Machines, poulie"],
            ["Curl marteau haltères","Biceps","","Poids libres"],
            ["Curl pupitre poulie basse","Biceps","","Machines, poulie"],
            ["Curl pupitre haltères","Biceps","","Poids libres"],
            ["Curl pupitre barre","Biceps","","Poids libres"],
            ["Curl araignée haltères","Biceps","","Poids libres"],
            ["Curl araignée barre","Biceps","","Poids libres"],
            ["Curl concentré","Biceps","","Poids libres"],
            ["Curl poulie vis à vis","Biceps","","Machines, poulie"],
            
            // AVANT BRAS
            ["Curl inversé poulie","Avant-bras","","Machines, poulie"],
            ["Curl inversé haltères","Avant-bras","","Poids libres"],
            ["Curl inversé au pupitre","Avant-bras","","Poids libres"],
            ["Extension des poignets","Avant-bras","","Poids libres"],
            ["Flexion des poignets","Avant-bras","","Poids libres"],
            
            // TRAPEZES
            
            ["Shrug haltères","Trapèzes","","Poids libres"],
            ["Shrug barre","Trapèzes","","Poids libres"],
            ["Shrug machine","Trapèzes","","Machines, poulie"],
            ["Shrug poulie","Trapèzes","","Machines, poulie"],
            
            // TRICEPS
            ["Barre au front poulie","Triceps","","Machines, poulie"],
            ["Barre au front barre","Triceps","","Poids libres"],
            ["Développé couché prise serrée","Triceps","","Poids libres"],
            ["Dips machine","Triceps","","Machines, poulie"],
            ["Dips entre deux bancs","Triceps","","Poids du corps"],
            ["Dips prise serrée","Triceps","","Poids du corps"],
            ["Extension poulie haute corde","Triceps","","Machines, poulie"],
            ["Extension poulie haute barre droite","Triceps","","Machines, poulie"],
            ["Extension nuque haltères","Triceps","","Poids libres"],
            ["Extension nuque poulie","Triceps","","Machines, poulie"],
            ["Kickback","Triceps","","Poids libres"],
            ["Kickback poulie","Triceps","","Machines, poulie"],
            ["Pompes prise diamant","Triceps","","Poids du corps"],
            ["Pompes prise serrée","Triceps","","Poids du corps"],
            
            // LOMBAIRES
            ["Good morning","Lombaires","","Poids libres"],
            ["Extension au banc à lombaires","Lombaires","","Machines, poulie"],
            ["Soulevé de terre poulie","Lombaires","","Machines, poulie"],
            
            // ISCHIO
            ["Leg curl","Ischio-Jambiers","","Machines, poulie"],
            
            // DORSAUX
            ["Traction prise large","Dorsaux","","Poids du corps"],
            ["Traction prise neutre","Dorsaux","","Poids du corps"],
            ["Traction prise serrée en pronation","Dorsaux","","Poids du corps"],
            ["Traction prise serrée en supination","Dorsaux","","Poids du corps"],
            ["Traction machine","Dorsaux","","Machines, poulie"],
            ["Traction poulie haute en pronation","Dorsaux","","Machines, poulie"],
            ["Traction poulie haute en supination","Dorsaux","","Machines, poulie"],
            ["Rowing assis poulie basse","Dorsaux","","Machines, poulie"],
            ["Rowing barre","Dorsaux","","Poids libres"],
            ["Rowing haltères","Dorsaux","","Poids libres"],
            
            
            // FESSIERS
            ["Soulevé de terre","Fessiers","","Poids libres"],
            ["Soulevé de terre sumo","Fessiers","","Poids libres"],
            ["Fentes glissées","Fessiers","","Poids du corps"],
            ["Fentes smith machine","Fessiers","","Machines, poulie"],
            
            // MOLLETS
            ["Chameau","Mollets","","Poids libres"],
            ["Mollets assis","Mollets","","Machines, poulie"],
            ["Mollets debout machine","Mollets","","Machines, poulie"],
            ["Mollets debout","Mollets","","Poids du corps"],
            
            // CARDIO
            ["Rameur","Cardio","","Cardio"],
            ["Vélo elliptique","Cardio","","Cardio"],
            ["Vélo de course","Cardio","","Cardio"],
            ["Marcheur","Cardio","","Cardio"],
            ["Mountain climber","Cardio","","Cardio"],
            ["Tapis de course","Cardio","","Cardio"],
            
            
//            ["","Mollets","",""],
            ]
        
        defaultsExercices.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[3], primaryGroup: exercice[1], secondaryGroup: exercice[2], training: nil)
        }
    }
    
}
