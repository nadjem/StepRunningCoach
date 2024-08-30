//
//  Actions.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//

import Foundation
import ReSwift

// Action for updating the current week
struct UpdateCurrentWeekAction: Action {
    let week: String
}

struct UpdateWeekIndexAction: Action {
    let weekIndex: Int
}

// Action for updating the current day
struct UpdateCurrentDayAction: Action {
    let day: String
}

struct UpdateDayIndexAction: Action {
    let dayIndex: Int
}

// Action for updating the running status
struct UpdateIsRunningAction: Action {
    let isRunning: Bool
}

struct UpdateTrainingDay: Action {
    let traininDay: TrainingDay?
}

enum WorkoutAction: Action {
    case startExercise(name: String, duration: TimeInterval)
    case updateRemainingTime(time: TimeInterval)
    case updateCurrentRepetition(sequence:Int)
    case updateDistanceRun(distance:Float)
    case updateSpeedRun(speed:Float)
    case updateDistanceWalk(distance:Float)
    case updateSpeedWalk(speed:Float)
    case updateHeartRate(rate:Double)
    case completeExercise
    case completeWorkout
    
}

enum NextProgramAction: Action {
    case updateNextProgram(week: String, day: String, run: String, walk: String, sequence: String)
    case updateDones(dones: Int)
}
