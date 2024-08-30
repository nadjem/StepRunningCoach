//
//  DayCustomCell.swift
//  interval Running
//
//  Created by Nadjem Medjdoub on 19/08/2024.
//


import UIKit

class DayCustomCell: UICollectionViewCell {
    static let reuseIdentifier = "DayCustomCell"
    
    @IBOutlet weak var infoButton: UIButton!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekImage: UIImageView!
    
    @IBOutlet weak var runLabel: UILabel!
    @IBOutlet weak var walkLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    
    @IBAction func onInfoPressed(_ sender: Any) {
        infoTapAction?()
    }

    var infoTapAction : (()->())?
    
    // var cornerRadius: CGFloat = 10.0

         func viewDidLoad(){
             
        }
        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 1.0
            layer.shadowOpacity = 0.30
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 2)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }
    
}
