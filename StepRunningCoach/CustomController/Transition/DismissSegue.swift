//
//  DismissSegue.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 31/08/2024.
//

import UIKit

class DismissSegue: UIStoryboardSegue {

    override func perform() {
        if let p = source.presentingViewController {
            p.dismiss(animated: true, completion: nil)
        }
    }

}
