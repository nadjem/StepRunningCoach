//
//  Setup.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 18/08/2024.
//

import Foundation
import RealmSwift

func setupInitialData() {
    let realm = try! Realm()
    
    // Vérifiez si les données existent déjà
    if realm.objects(TrainingWeek.self).isEmpty {
        try! realm.write {
            let initialWeeksData: [[String: Any]] = [
                [
                    "name": "Week 1",
                    "days": [
                        ["name": "Day 1", "repeat": 3, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 4, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 5, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 6, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 7, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 2",
                    "days": [
                        ["name": "Day 1", "repeat": 8, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 9, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 10, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 11, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 12, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 3",
                    "days": [
                        ["name": "Day 1", "repeat": 13, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 14, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 15, "run": 1, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 3, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 4, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 4",
                    "days": [
                        ["name": "Day 1", "repeat": 5, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 6, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 7, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 8, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 9, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 5",
                    "days": [
                        ["name": "Day 1", "repeat": 10, "run": 2, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 3, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 4, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 5, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 6, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 6",
                    "days": [
                        ["name": "Day 1", "repeat": 7, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 8, "run": 3, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 2, "run": 4, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 3, "run": 4, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 4, "run": 4, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 7",
                    "days": [
                        ["name": "Day 1", "repeat": 5, "run": 4, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 6, "run": 4, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 1, "run": 9, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 2, "run": 9, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 3, "run": 9, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ],
                [
                    "name": "Week 8",
                    "days": [
                        ["name": "Day 1", "repeat": 1, "run": 14, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 2", "repeat": 2, "run": 14, "walk": 1, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 3", "repeat": 1, "run": 20, "walk": 0, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 4", "repeat": 1, "run": 25, "walk": 0, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []],
                        ["name": "Day 5", "repeat": 1, "run": 30, "walk": 0, "done": false, "speed": nil, "distance": nil, "heartRate": nil, "coordinates": []]
                    ]
                ]
            ]

            
            for weekData in initialWeeksData {
                let week = TrainingWeek()
                week.name = weekData["name"] as! String
                
                let daysData = weekData["days"] as! [[String: Any]]
                for dayData in daysData {
                    let day = TrainingDay()
                    day.name = dayData["name"] as! String
                    day.repeatCount = dayData["repeat"] as! Int
                    day.run = dayData["run"] as! Int
                    day.walk = dayData["walk"] as! Int
                    day.done = dayData["done"] as! Bool
                    // Ajoutez d'autres champs si nécessaire
                    week.days.append(day)
                }
                
                realm.add(week)
            }
        }
    }
}
