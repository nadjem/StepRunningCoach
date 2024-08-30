//
//  BottomHomeViewController.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 29/08/2024.
//
import Foundation
import UIKit
import RealmSwift
import ReSwift

class BottomHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {
    let realm = try! Realm()
    var weeks: Results<TrainingWeek>? = nil
    let transition = CircularTransition()
    var startPosition: CGPoint?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 300)
        layout.minimumLineSpacing = 50
        layout.numberOfItemsPerPage = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 90)
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .fast
        weeks = realm.objects(TrainingWeek.self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height:(UIScreen.main.bounds.height / 2) - 110  )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return weeks?.count ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Access
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCustomCell", for: indexPath) as! WeekCustomCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        cell.backgroundColor = UIColor.white
        let week = weeks?[indexPath.item]
        cell.label.text =  week?.name
        cell.layoutSubviews()
        cell.backgroundImage.image = UIImage(named:"runner_\(indexPath.item).png")
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell {
                let cellFrameInSuperview = cell.superview?.convert(cell.frame, to: self.view)
                let cellCenterInSuperview = CGPoint(x: (cellFrameInSuperview?.midX)!, y: (cellFrameInSuperview?.midY)! * 2 + 200)
                transition.startingPoint = cellCenterInSuperview
                startPosition = cellCenterInSuperview
            }
        if let indexPaths = collectionView.indexPathsForSelectedItems{
           let destinationController = segue.destination as! WeekDetailViewController
            destinationController.currentWeekFromMain = weeks?[indexPaths[0].row].name ?? ""
            mainStore.dispatch(UpdateCurrentWeekAction(week: weeks?[indexPaths[0].row].name ?? ""))
            mainStore.dispatch(UpdateWeekIndexAction(weekIndex:indexPaths[0].row))
            collectionView.deselectItem(at: indexPaths[0], animated: false)
        }
            let destinationVC = segue.destination
            destinationVC.transitioningDelegate = self
            destinationVC.modalPresentationStyle = .custom
        }
        
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = UIColor.clear
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = startPosition ?? CGPoint.zero
        transition.circleColor = UIColor.clear
        return transition
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
