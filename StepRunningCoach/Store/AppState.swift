//
//  AppState.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//

import Foundation
import ReSwift

struct AppState {
    var trainingState: trainingState
    var workoutState: WorkoutState
    var nextProgram: nextProgram
}

struct WorkoutState {
    var currentExercise: String = ""
    var currentDuration: TimeInterval = 0
    var remainingTime: TimeInterval = 0
    var currentRepetition: Int = 1
    var isWorkoutCompleted: Bool = false
    var currentDistanceRun: Float = 0.0
    var currentDistanceWalk: Float = 0.0
    var currentSpeedRun: Float = 0.0
    var currentSpeedWalk: Float = 0.0
    var currentHeartRate: Double = 0
}


struct trainingState {
    var currentWeek: String
    var currentDay: String
    var isRunning: Bool
    var weekIndex: Int
    var dayIndex: Int
    var trainingDay: TrainingDay?
}

struct nextProgram {
    var week: String
    var day: String
    var run: String
    var walk: String
    var sequence: String
    var dones: Int
}
