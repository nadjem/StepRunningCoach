//
//  TopHomeViewController.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 27/08/2024.
//

import UIKit
import ReSwift
class TopHomeViewController: UIViewController {


    @IBOutlet weak var circle: UIView!
    
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var walkLabel: UILabel!
    @IBOutlet weak var runLabel: UILabel!
    @IBOutlet weak var nextDayLabel: UILabel!
    @IBOutlet weak var nextWeekLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainStore.subscribe(self) {
                    $0.select { $0 }
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
extension TopHomeViewController: StoreSubscriber {
    func newState(state: AppState) {
        
        nextWeekLabel.text = "week: \(state.nextProgram.week)"
    
        nextDayLabel.text = "day: \(state.nextProgram.day)"
        runLabel.text = "run: \(state.nextProgram.run) min"
        walkLabel.text = "walk: \(state.nextProgram.walk) min "
        repeatLabel.text = "repeat: \(state.nextProgram.sequence) time"
        
    }
}

