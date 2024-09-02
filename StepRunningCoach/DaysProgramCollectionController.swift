//
//  DaysProgramCollectionController.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//

import Foundation
import UIKit
import RealmSwift
import ReSwift
import CoreLocation

class DayProgramViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate
{
    let realm = try! Realm()
    var week: TrainingWeek? = nil
    var currentWeekFromStore = ""
    var currentWeekIndex = 0
    var locationManager: CLLocationManager?
    @IBOutlet weak var daysCollectionView: UICollectionView!

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        daysCollectionView!.contentInset = UIEdgeInsets(top: 100, left: 80, bottom: 0, right: 80)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        // initialSetup()
        mainStore.subscribe(self) {
                    $0.select { $0 }
                }
        let weeks = realm.objects(TrainingWeek.self)
        if let w = weeks.first(where: { $0.name == currentWeekFromStore }) {
            week = w
        }
    }
    
    private func initialSetup() {
          view.backgroundColor = .white
          let gradientLayer = CAGradientLayer()
          gradientLayer.colors = [UIColor.white.cgColor, UIColor.gray.cgColor]
          gradientLayer.locations = [0.0, 1.0]
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
          gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.6)
          gradientLayer.frame = view.frame
          view.layer.insertSublayer(gradientLayer, at: 0)
       }
    
    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
         
                let width = collectionView.bounds.width * 0.9
                let height = collectionView.bounds.height * 0.2
        
            
                return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return week?.days.count ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Access
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCustomCell", for: indexPath) as! DayCustomCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
      //  cell.backgroundColor = UIColor.white
       /*
        let week = weeks?[indexPath.item]
        cell.label.text =  week?.name
        cell.layoutSubviews()
        cell.backgroundImage.image = UIImage(named:"image_\(indexPath.item + 1).png")
        */
    
    // cell.weekImage.image = UIImage(named:"image_\(currentWeekIndex + 1).png")
        cell.dayLabel.text = week?.days[indexPath.item].name
        let run = week!.days[indexPath.item].run
        cell.runLabel.text = "Running \(String(describing: run)) min"
        cell.walkLabel.text = "Walking \(String(describing: week!.days[indexPath.item].walk)) min"
        cell.repeatLabel.text = "Repeat sequence \(String(describing: week!.days[indexPath.item].repeatCount)) time"
       /* cell.infoTapAction = {
            // implement your logic here, e.g. call preformSegue()
            mainStore.dispatch(UpdateTrainingDay(traininDay: self.week!.days[indexPath.item]))
            //self.performSegue(withIdentifier: "showInfo", sender:self)
            
        }*/
     
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showRun" {
          
                if let indexPaths = daysCollectionView.indexPathsForSelectedItems{
                    let destinationController = segue.destination as! RunViewController
                //    destinationController.hidesBottomBarWhenPushed = true
                    daysCollectionView.deselectItem(at: indexPaths[0], animated: false)
                   destinationController.selectedDay = week!.days[indexPaths[0].item]
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
        return 10
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
        return 3
    }
    
    //MARK: - MyCustomCellDelegator Methods

     func callSegueFromCell(dayData dataobject: AnyObject) {
       //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
         //self.performSegue(withIdentifier: "showInfo", sender:dataobject )

     }

}

extension DayProgramViewController: StoreSubscriber {
    func newState(state: AppState) {
        // Mise à jour de la vue en fonction du nouvel état
        // par exemple: self.collectionView.reloadData()
        currentWeekFromStore = state.trainingState.currentWeek
        currentWeekIndex = state.trainingState.weekIndex

    }
}

