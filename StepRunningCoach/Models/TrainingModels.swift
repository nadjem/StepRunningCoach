//
//  TrainingModels.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 18/08/2024.
//
import Foundation
import RealmSwift

class TrainingDay: Object {
    @objc dynamic var name = ""
    @objc dynamic var repeatCount = 0
    @objc dynamic var run = 0
    @objc dynamic var walk = 0
    @objc dynamic var done = false
    @objc dynamic var speed: Double = 0.0
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var heartRate: Int = 0
    let coordinates = List<Coordinate>()
}

class TrainingWeek: Object {
    @objc dynamic var name = ""
    let days = List<TrainingDay>()
   
}

class Coordinate: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var type: String = "" // "run" or "walk"
}

struct Exercise {
    let name: String
    let duration: TimeInterval // in secondes
}

struct ExerciseSequence {
    let exercises: [Exercise]
    let repetitions: Int
}
