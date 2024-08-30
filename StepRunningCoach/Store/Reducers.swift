//
//  Reducers.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//

import Foundation
import ReSwift
func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        trainingState: trainingReducer(action: action, state: state?.trainingState),
        workoutState: workoutReducer(action: action, state: state?.workoutState),
        nextProgram: nextProgramReducer(action: action, state: state?.nextProgram)
    )
}
func trainingReducer(action: Action, state: trainingState?) -> trainingState {
    var state = state ?? trainingState(currentWeek: "", currentDay: "", isRunning: false, weekIndex: 0, dayIndex: 0, trainingDay: nil)

    switch action {
    case let action as UpdateCurrentWeekAction:
        state.currentWeek = action.week
    case let action as UpdateWeekIndexAction:
        state.weekIndex = action.weekIndex
    case let action as UpdateCurrentDayAction:
        state.currentDay = action.day
    case let action as UpdateDayIndexAction:
        state.dayIndex = action.dayIndex
    case let action as UpdateIsRunningAction:
        state.isRunning = action.isRunning
    case let action as UpdateTrainingDay:
        state.trainingDay = action.traininDay
    default:
        break
    }

    return state
}

func nextProgramReducer(action: Action, state: nextProgram?) -> nextProgram {
    var state = state ?? nextProgram(week: "", day: "", run: "", walk: "", sequence: "", dones: 0)

    switch action {
    case let action as NextProgramAction:
        switch action {
        case let .updateNextProgram(week, day, run, walk, sequence):
            state.week = week
            state.day = day
            state.run = run
            state.walk = walk
            state.sequence = sequence
        case let .updateDones(dones):
            state.dones = dones
        }
    default:
        break
    }

    return state
}

func workoutReducer(action: Action, state: WorkoutState?) -> WorkoutState {
    var state = state ?? WorkoutState()

    switch action {
    case let action as WorkoutAction:
        switch action {
        case let .startExercise(name, duration):
            state.currentExercise = name
            state.currentDuration = duration
        case .completeExercise: break
        case let .updateRemainingTime(time):
            state.remainingTime = time
        case .completeWorkout:
            state.isWorkoutCompleted = true
        case let .updateCurrentRepetition(sequence):
            state.currentRepetition = sequence
            
        case let .updateSpeedRun(speed):
            state.currentSpeedRun = speed
            
        case let .updateSpeedWalk(speed):
            state.currentSpeedWalk = speed
            
        case let .updateDistanceRun(distance):
            state.currentDistanceRun = distance
            
        case let .updateDistanceWalk(distance):
            state.currentDistanceWalk = distance
        case let .updateHeartRate(rate):
            state.currentHeartRate = rate
        }
    default:
        break
    }

    return state
}

