//
//  WeekDetailViewController.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 30/08/2024.
//

import UIKit
import ReSwift
import RealmSwift
class WeekDetailViewController: UIViewController {
    var currentWeekFromMain = ""
    let realm = try! Realm()
    var currentWeek:TrainingWeek? = nil
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewEffect: UIVisualEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.imageView?.contentMode = .scaleAspectFill
      
        // Do any additional setup after loading the view.
        mainStore.subscribe(self) {
                    $0.select { $0 }
                }
        let weeks = realm.objects(TrainingWeek.self)
        if let week = weeks.first(where: { $0.name == currentWeekFromMain }) {
            currentWeek = week
            print(currentWeek as Any)
            titleLabel.text = currentWeek?.name ?? ""
        }
        
        viewEffect.alpha = 0
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
            self.dismiss(animated: true)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.viewEffect.alpha = 1
        }
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
extension WeekDetailViewController: StoreSubscriber {
    func newState(state: AppState) {
        print(state.trainingState)
        let imageName = "runner_\(state.trainingState.weekIndex).png"
        bgImage.image = UIImage(named:imageName)
    }
}
