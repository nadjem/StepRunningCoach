//
//  SlideExtension.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 27/08/2024.
//

import UIKit

extension UIView {

    func slideY(y:CGFloat) {

        let xPosition = self.frame.origin.x

        let height = self.frame.height
        let width = self.frame.width

        UIView.animate(withDuration: 1.0, animations: {

            self.frame = CGRect(x: xPosition, y: y, width: width, height: height)

        })
    }
}
