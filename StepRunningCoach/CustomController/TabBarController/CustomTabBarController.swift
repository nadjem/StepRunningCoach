//
//  CustomTabBarController.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 25/08/2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    var upperLineView: UIView!
    let spacing: CGFloat = 12
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
            super.viewDidLoad()
        self.delegate = self
        self.tabBar.unselectedItemTintColor = .lightText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
            }
        }

    /// Add tabbar item indicator uper line
    /// - Parameters:
    ///   - index:Tabbar item index
    ///   - isFirstTime: needed for first load view
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
          guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
              return
          }
          if !isFirstTime{
              UIView.animate(withDuration: 0.15, animations: {
                  self.upperLineView.frame.size.width = 10
                  self.upperLineView.frame.size.height = 2
              })
              UIView.animate(withDuration: 0.25, animations: {
                  
                  let moveRight = CGAffineTransform(translationX: (tabView.frame.minX - self.view.frame.minX ) , y: 0.0)
                  
                  self.upperLineView.transform = moveRight
              })
              { _ in
                      UIView.animate(withDuration: 0.15, animations: {
                          self.upperLineView.frame.size.width = (tabView.frame.size.width - self.spacing - 40) / 2
                          self.upperLineView.frame.size.height = 4
                          })
                  }
              
          } else {
              guard let subView = tabView.subviews.first else{
                  return
              }
              upperLineView = UIView(frame:
                                        CGRect(
                                            x: subView.frame.minX - spacing,
                                            y: tabView.frame.minY + 4.0,
                                            width: (tabView.frame.size.width - spacing - 40) / 2,
                                            height: 4
                                        )
              )
              upperLineView.layer.cornerRadius = 4
              tabBar.addSubview(upperLineView)
              tabBar.clipsToBounds = true
          }
          upperLineView.backgroundColor = UIColor.white
      }
}
extension CustomTabBarController: UITabBarControllerDelegate {
    
    /// triggered func on didselect tabbar item
    /// - Parameters:
    ///   - tabBarController: UITabBarController
    ///   - viewController: UIViewController
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let subView = tabBar.subviews[tabBarController.selectedIndex].subviews.first
        self.performSpringAnimation(imgView: subView!)
        
        addTabbarIndicatorView(index: self.selectedIndex)
            let tabBarIndex = tabBarController.selectedIndex
            if tabBarIndex == 0 {
                //do your stuff
            }
       }
    
    /// Perform Scale animation on selected bar item image
    /// - Parameter imgView: subView for the tabbar item image
    func performSpringAnimation(imgView: UIView) {

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {

            imgView.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in

        }
    }

}
