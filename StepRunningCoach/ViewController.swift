//
//  ViewController.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 25/08/2024.
//

import UIKit
import RealmSwift
import ReSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var weeks: Results<TrainingWeek>? = nil
    var nextProgram: Any? = nil
    var countDones: Int = 0
    @IBOutlet weak var donesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weeks = realm.objects(TrainingWeek.self)
         nextProgram = self.getNextProgram()
        countDones = self.getCountDones()
        donesLabel.text = countDones.description
        mainStore.dispatch(NextProgramAction.updateDones(dones: countDones))
        if(nextProgram == nil){
            donesLabel.text = "Alls"
        }else{
            if let nextProgramDict = nextProgram as? [String: Any],
                   let weekName = nextProgramDict["weekName"] as? String,
                   let day = nextProgramDict["day"] as? TrainingDay { // Cast en TrainingDay au lieu de String
                    
                    // Maintenant vous pouvez accéder aux propriétés spécifiques de day
                    let dayName = day.name
                    let runValue = "\(day.run)" // Convertir les valeurs numériques en String
                    let walkValue = "\(day.walk)"
                    let sequenceValue = "\(day.repeatCount)" // Par exemple
                    
                    mainStore.dispatch(NextProgramAction.updateNextProgram(
                        week: weekName,
                        day: dayName,
                        run: runValue,
                        walk: walkValue,
                        sequence: sequenceValue
                    ))
                }
        }
       
    }


    func getNextProgram() -> [String: Any]? {
        if let trainingWeeks = weeks {
            for week in trainingWeeks {
                for day in week.days {
                    if day.done == false { // ou `day.done == 0` si c'est un entier
                        // Retourne un dictionnaire contenant le nom de la semaine et les données du jour
                        return ["weekName": week.name, "day": day]
                    }
                }
            }
        }
        return nil // En cas où il n'y a pas de jour avec `done == false`
    }
    
    func getCountDones() -> Int {
        var count = 0
        if let trainingWeeks = weeks {
            for week in trainingWeeks {
                for day in week.days {
                    if day.done == true { // ou `day.done == 1` si c'est un entier
                        count += 1
                    }
                }
            }
        }
        return count
    }
    
}

