import Foundation
import UserNotifications
import ReSwift
import CoreLocation

class WorkoutManager {
    var currentExerciseIndex = 0
    var currentRepetition = 1
    var timer: Timer?
    var currentSequence: ExerciseSequence
    var startTime: Date?
    var coordinates: [Coordinate] = []
    var speedTimer: Timer?
    var runWalkTime = 0
    var previousExercice = "none"
    init(sequence: ExerciseSequence) {
        self.currentSequence = sequence
    }

    func startWorkout() {
        startExercise()
        startSpeedTimer()
    }
    func startSpeedTimer() {
        self.previousExercice = "run"
        self.scheduleNotification(
            title: "Start",
            message: "Time to run, here we go !!",
            identifier: "start")
        speedTimer?.invalidate()
        speedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.updateLiveSpeed(time:timer)
            self?.runWalkTime += 1
           
        }
    }
    func scheduleNotification(title:String, message:String, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    func updateLiveSpeed(time:Timer) {
        guard coordinates.count > 1 else { return }
        
        let lastCoordinate = coordinates[coordinates.count - 1]
        let previousCoordinate = coordinates[coordinates.count - 2]
        let distance = calculateDistance(from: previousCoordinate, to: lastCoordinate)
        let time = Double(runWalkTime) / 3600.0
        let currentSpeed = distance / time
        mainStore.dispatch(WorkoutAction.updateSpeedRun(speed: Float(currentSpeed)))
        
    }
    func startExercise() {
        timer?.invalidate() // Arrêtez le timer existant
        if currentExerciseIndex < currentSequence.exercises.count {
            let exercise = currentSequence.exercises[currentExerciseIndex]
            startTime = Date() // Sauvegardez l'heure de début de l'exercice
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                self?.updateRemainingTime()
                if self == nil {
                    timer.invalidate()
                }
            }
            mainStore.dispatch(WorkoutAction.startExercise(name: exercise.name, duration: exercise.duration))
        } else {
            handleSequenceCompletion()
        }
    }
    
    func addCoordinate(latitude: Double, longitude: Double, type: String) {
            let coordinate = Coordinate()
            coordinate.latitude = latitude
            coordinate.longitude = longitude
            coordinate.type = type
            coordinates.append(coordinate)
           let info = calculateDistancesAndSpeeds()
        if(self.previousExercice != type){
            self.previousExercice = type
            scheduleNotification(title: "time's up !", message: "it's time to \(type)", identifier: type)
        }
        //print(info)
        }
    
    func calculateDistancesAndSpeeds() -> (runDistance: Double, walkDistance: Double, runSpeed: Double, walkSpeed: Double) {
           var runDistance = 0.0
           var walkDistance = 0.0
           var runTime: TimeInterval = 0
           var walkTime: TimeInterval = 0
           // print("count coord : \(coordinates.count)")
           for (index, coordinate) in coordinates.enumerated() {
               if index > 0 {
                   let previousCoordinate = coordinates[index - 1]
                   let distance = calculateDistance(from: previousCoordinate, to: coordinate)
                   let timeInterval = calculateTimeInterval(from: previousCoordinate, to: coordinate)

                   if coordinate.type == "run" {
                       runDistance += distance
                       runTime += timeInterval
                      // print("runTime \(runTime)")
                       mainStore.dispatch(WorkoutAction.updateDistanceRun(distance: Float(runDistance)))
                   } else if coordinate.type == "walk" {
                       walkDistance += distance
                       walkTime += timeInterval
                      // print("runTime \(walkTime)")
                       mainStore.dispatch(WorkoutAction.updateDistanceWalk(distance: Float(walkDistance)))
                   }
               }
           }

           let runSpeed = runTime > 0 ? runDistance / runTime : 0
           let walkSpeed = walkTime > 0 ? walkDistance / walkTime : 0

           return (runDistance, walkDistance, runSpeed, walkSpeed)
       }
    
    private func calculateDistance(from: Coordinate, to: Coordinate) -> Double {
            // Implémentez ici le calcul de la distance en utilisant l'haversine ou autre formule
        let firsLocation = CLLocation(latitude:from.latitude, longitude:from.longitude)
        let secondLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distance = firsLocation.distance(from: secondLocation) / 1000

            return distance
        }
    private func calculateTimeInterval(from: Coordinate, to: Coordinate) -> TimeInterval {
            // Implémentez ici la différence de temps entre deux coordonnées
            return 0.0
        }
    
    @objc func updateRemainingTime() {
        guard timer != nil else { return }  // Ajoutez cette vérification pour s'assurer que le timer n'est pas nil

        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        let remainingTime = max(0, currentSequence.exercises[currentExerciseIndex].duration - elapsedTime)
        mainStore.dispatch(WorkoutAction.updateRemainingTime(time: remainingTime))
        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil  // Assurez-vous de réinitialiser le timer ici aussi
            exerciseCompleted()
        }
    }
    

    func exerciseCompleted() {
        mainStore.dispatch(WorkoutAction.completeExercise)
        currentExerciseIndex += 1
        runWalkTime = 0
        startExercise()
    }

    func workoutCompleted() {
        timer?.invalidate()
        mainStore.dispatch(WorkoutAction.completeWorkout)
    }

    func handleSequenceCompletion() {
        if currentRepetition < currentSequence.repetitions {
            currentRepetition += 1
            mainStore.dispatch(WorkoutAction.updateCurrentRepetition(sequence: currentRepetition))
            currentExerciseIndex = 0
            startExercise()
        } else {
            workoutCompleted()
        }
    }
    
    func stopWorkout(){
    guard timer != nil else { return }
        timer?.invalidate()
        timer = nil  // Ajoutez cette ligne pour vous débarrasser de la référence au timer
    }
}
