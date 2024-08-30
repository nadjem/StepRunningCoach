//
//  GradientExtension.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 27/08/2024.
//

import UIKit

@IBDesignable
extension UIView
{

    @IBInspectable
    var startColor: UIColor
    {
        get
        {
            guard let color = layer.value(forKeyPath: "startColor") as? UIColor else
            {
                return UIColor.clear
            }
            return color
        }
        set
        {
            layer.setValue(newValue, forKeyPath: "startColor")
            setGradient()
        }
    }
    @IBInspectable
    var endColor: UIColor
    {
        get
        {
            guard let color = layer.value(forKeyPath: "endColor") as? UIColor else
            {
                return UIColor.clear
            }
            return color
        }
        set
        {
            layer.setValue(newValue, forKeyPath: "endColor")
            setGradient()
        }
    }
    // @IbInspectable to set gradient dropdown list select for direction topToBottom, bottomToTop leftToRight or rightToLeft
    @IBInspectable
    var isVertical: Bool
    {
        get
        {
            guard let isVertical = layer.value(forKeyPath: "isVertical") as? Bool else
            {
                return true
            }
            return isVertical
        }
        set
        {
            layer.setValue(newValue, forKeyPath: "isVertical")
            setGradient()
            
        }
    }
    // @IbInspectable to set gradient dropdown list select for direction topToBottom, bottomToTop leftToRight or rightToLeft
    func setGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        if isVertical
        {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
        else
        {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
