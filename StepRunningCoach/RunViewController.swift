//
//  RunViewController.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 20/08/2024.
//

import Foundation
import UIKit
import ReSwift
import RotatingLabel
import CoreLocation
import WatchConnectivity
import SwiftUI

class RunViewController: UIViewController, CLLocationManagerDelegate{
   // private var healthKitManager = HealthKitManager()
    var startTime: Date?
    var messageId = -1
    var locationManager: CLLocationManager!
    var workoutManager:WorkoutManager?

    var selectedDay: TrainingDay?
    var exercises: [Exercise]?
    var exerciseSequence: ExerciseSequence?
    var currentType:String?
    let progressBar = CircularProgressBar()

    @IBOutlet var mainRunView: UIView!
    @IBOutlet weak var animationView: BreathView!
    
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var exerciceView: UIView!
    @IBOutlet weak var lapsView: UIView!
    
    @IBOutlet weak var repeatLabel: UILabel!
    var repeatText = ""
    @IBOutlet weak var exercicesLabel: UILabel!
    
    
    @IBOutlet weak var gpsView: UIView!
    @IBOutlet weak var distanceRunView: UIView!
    @IBOutlet weak var speedRunView: UIView!
    @IBOutlet weak var heartRateView: UIView!
    
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var secondesView: UIView!
    
    @IBOutlet weak var runSpeedLabel: UILabel!
    @IBOutlet weak var runDistanceLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    var hoursLabel = RotatingLabel()
    var minutesLabel = RotatingLabel()
    var secondeslabel = RotatingLabel()
    
    @IBAction func close(_ sender: Any) {
        if(workoutManager != nil){
            workoutManager!.stopWorkout()
        }
        
        progressBar.isHidden = true
        animationView.isHidden = true
        hoursLabel.text = "00"
        minutesLabel.text = "00"
        secondeslabel.text = "00"
        mainStore.dispatch(WorkoutAction.updateRemainingTime(time: 0))
        mainStore.dispatch(WorkoutAction.startExercise(name: "", duration: .zero))
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func startTimer(_ sender: Any) {
        animationView.isHidden = false
        progressBar.isHidden = false
        gpsView.isHidden = false
        workoutManager = WorkoutManager(sequence: exerciseSequence!)
        workoutManager!.startWorkout()
        _ = self.animationView
    }
    
    
    
    override func viewDidLoad() {
        // print("WCSession.default.isReachable ? \(WCSession.default.isReachable)")
        
        setupLocationManager()
        setupCounterText()
        setupProgressCircle()
        progressBar.isHidden = false
        animationView.isHidden = true
        infoView.isHidden = false
        gpsView.isHidden = false
        if((selectedDay) != nil)
        {
            print("selected day")
            print(selectedDay as Any)
            exercises = [
                Exercise(name: "Running", duration: TimeInterval(selectedDay!.run * 60)),
                Exercise(name: "Walking", duration: TimeInterval(selectedDay!.walk * 60))
            ]
            exerciseSequence = ExerciseSequence(
                exercises: exercises!,
                repetitions: selectedDay!.repeatCount
            )
        }else{
            print("no selected day")
        }
        
        mainStore.subscribe(self) {
            $0.select { $0 }
        }
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupProgressCircle(){
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        // Calculer le centre de l'écran
        let centerX = ((screenWidth / 2) - 150) / 2
        let centerY = ((screenHeight / 2) - 150) / 2
        
        progressBar.frame = CGRect(x: centerX, y: centerY, width: 300, height: 300)
        progressBar.trackColor = .systemTeal.withAlphaComponent(0.3)
        progressBar.progressColor = .systemTeal
        view.addSubview(progressBar)
    }
    
    func setupCounterText(){
        hoursLabel.text = "00"
        minutesLabel.text = "00"
        secondeslabel.text = "00"
        
        lapsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        exerciceView.applyGradient(isVertical: false, colorArray: [
            .systemTeal,
            .systemPink
        ])
        exerciceView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        //distanceRunView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        distanceRunView.applyGradient(isVertical: false, colorArray: [
            .systemRed,
            .systemTeal
        ])
        
        //speedRunView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner,  ]
        speedRunView.applyGradient(isVertical: false, colorArray: [
            .systemTeal,
            .systemPink
        ])
        
       // speedRunView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        heartRateView.applyGradient(isVertical: false, colorArray: [
            .orange,
            .systemRed
        ])
        hoursLabel.decrementingColor = .systemMint
        hoursLabel.incrementingColor = .black
        minutesLabel.decrementingColor = .systemMint
        minutesLabel.incrementingColor = .black
        secondeslabel.decrementingColor = .systemMint
        secondeslabel.incrementingColor = .black
        
        hoursLabel.center = CGPoint(x:hoursView.frame.width / 2, y: hoursView.frame.height / 2)
        hoursLabel.frame = CGRect(x: 2, y: 0, width: hoursView.frame.width, height: hoursView.frame.height)
        hoursLabel.font = .myBoldSystemFont(ofSize: 51)
        
        hoursView.addSubview(hoursLabel)
        
        minutesLabel.center = CGPoint(x:hoursView.frame.width / 2, y: hoursView.frame.height / 2)
        minutesLabel.frame = CGRect(x: 2, y: 0, width: hoursView.frame.width, height: hoursView.frame.height)
        minutesLabel.font = .myBoldSystemFont(ofSize: 51)
        minutesView.addSubview(minutesLabel)
        
        secondeslabel.center = CGPoint(x:hoursView.frame.width / 2, y: hoursView.frame.height / 2)
        secondeslabel.frame = CGRect(x: 2, y: 0, width: hoursView.frame.width, height: hoursView.frame.height)
        secondeslabel.font = .myBoldSystemFont(ofSize: 51)
        secondesView.addSubview(secondeslabel)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        
        //let currentType = determineCurrentPhaseType()
        if(workoutManager != nil){
            workoutManager?.addCoordinate(latitude: latitude, longitude: longitude, type: currentType!)
        }
        
    }
    
    func determineCurrentPhaseType() -> String {
        guard let startTime = startTime else {
            return "run"
        }
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        
        let runDuration: TimeInterval = TimeInterval(selectedDay!.run * 60)
        let walkDuration: TimeInterval = TimeInterval(selectedDay!.walk * 60)
        let cycleDuration = runDuration + walkDuration
        
        let cyclePosition = elapsedTime.truncatingRemainder(dividingBy: cycleDuration)
        
        return cyclePosition < runDuration ? "run" : "walk"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
}

extension RunViewController: StoreSubscriber {
    func newState(state: AppState) {
        if !state.workoutState.isWorkoutCompleted {
            
            /*print(state.workoutState.currentDistanceRun)
             print(state.workoutState.currentDistanceRun < 1.0 ? "\(state.workoutState.currentDistanceRun * 1000)m" : "\(state.workoutState.currentDistanceRun )km")*/
            if(state.workoutState.currentExercise != ""){
                
                
                infoView.isHidden = false
                repeatText = "\(state.workoutState.currentRepetition )/\(String(describing: selectedDay!.repeatCount))"
                repeatLabel.text = repeatText
                currentType = state.workoutState.currentExercise == "Running" ? "run" : "walk"
                
                let distance = state.workoutState.currentDistanceRun < 1.0 ?
                "\(String( (Double(state.workoutState.currentDistanceRun) * 1000).rounded(digits:2)) )m" :
                "\(Double(state.workoutState.currentDistanceRun).rounded(digits:2) )km"
                
                runDistanceLabel.text = distance
                //let distanceMessage = ["distance": distance]
                //let typeMessage = ["type": currentType!]
                //let sequence = ["sequence": messageId]
                
                let message = ["type": currentType as Any, "distance": distance ] as [String : Any]
                let data = try? JSONSerialization.data(withJSONObject: message, options: [])
                
                //  WatchConnectivityManager.shared.sendData(data!)
                
                messageId += 1
                
                runSpeedLabel.text = "\(state.workoutState.currentSpeedRun.rounded()) km/h"
                
                exercicesLabel.text = state.workoutState.currentExercise
                if( state.workoutState.currentExercise == "Running" ){
                    exercicesLabel.startBlink()
                }else{
                    exercicesLabel.stopBlink()
                }
            }else{
                infoView.isHidden = false
                exercicesLabel.stopBlink()
            }
            
            let remainingTime = state.workoutState.remainingTime
            let totalTime = state.workoutState.currentDuration
            let elapsedTime = totalTime - remainingTime
            
            let progress = elapsedTime / totalTime
            progressBar.setProgress(to: progress, withAnimation: false)
            let hours = Int(remainingTime) / 3600
            let minutes = Int(remainingTime) / 60 % 60
            let seconds = Int(remainingTime) % 60
            
            hoursLabel.setText(hours > 9 ? String(describing: hours) : "0\(String(describing: hours))", animated: true)
            
            minutesLabel.setText(minutes > 9 ? String(describing: minutes) : "0\(String(describing: minutes))", animated: true)
            
            let secondesText = seconds > 9 ? String(describing: seconds) : "0\(String(describing: seconds))"
            let minuteText = minutes > 9 ? String(describing: minutes) : "0\(String(describing: minutes))"
            let hourText = hours > 9 ? String(describing: hours) : "0\(String(describing: hours))"
            heartRateLabel.text = "\(state.workoutState.currentHeartRate)BPM"
            secondeslabel.setText(secondesText, animated: true)
            let timerTime = "\(hourText):\(minuteText):\(secondesText)"
            // WatchConnectivityManager.shared.sendContext(["time":timerTime])
            
        }
        
    }
    
    
}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
    
