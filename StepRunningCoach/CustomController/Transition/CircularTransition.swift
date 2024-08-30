//
//  CircularTransition.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 29/08/2024.
//
import UIKit

class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var circle = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }

    var duration = 0.5
    var transitionMode: CircularTransitionMode = .present
    var circleColor = UIColor.white

    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       // animate presention from circle that scale to fit view
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size

                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = .clear
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)

                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.layer.cornerRadius = 0
                    presentedView.center = viewCenter
                }, completion: { success in
                    transitionContext.completeTransition(success)
                })
            }
        }
        else if transitionMode == .dismiss {
            let transitionModeKey = transitionMode == .present ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
            if let returningView = transitionContext.viewController(forKey: transitionModeKey) {
                let viewCenter = returningView.view.center
                let viewSize = returningView.view.frame.size

                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.view.center = self.startingPoint
                    returningView.view.alpha = 0
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView.view, belowSubview: returningView.view)
                        containerView.insertSubview(self.circle, belowSubview: returningView.view)
                    }
                }, completion: { success in
                    returningView.view.center = viewCenter
                    returningView.view.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
        else {
            let transitionModeKey = transitionMode == .pop ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
            if let returningView = transitionContext.viewController(forKey: transitionModeKey) {
                let viewCenter = returningView.view.center
                let viewSize = returningView.view.frame.size

                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.view.center = self.startingPoint
                    returningView.view.alpha = 0
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView.view, belowSubview: returningView.view)
                        containerView.insertSubview(self.circle, belowSubview: returningView.view)
                    }
                }, completion: { success in
                    returningView.view.center = viewCenter
                    returningView.view.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
    }

    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)

        return CGRect(origin: CGPoint.zero, size: size)
    }
}
