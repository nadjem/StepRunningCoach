//
//  MultiStrokeCircle.swift
//  StepRunningCoach
//
//  Created by Nadjem Medjdoub on 28/08/2024.
//
import UIKit

@IBDesignable
class DividedCircleView: UIView {
    private var gradientLayers: [CAGradientLayer] = []
    private var glowLayers: [CAShapeLayer] = []  // Array pour stocker les glow layers
    
    @IBInspectable var startColor1: UIColor = .red { didSet { updateGradients() } }
    @IBInspectable var endColor1: UIColor = .orange { didSet { updateGradients() } }
    @IBInspectable var startColor2: UIColor = .green { didSet { updateGradients() } }
    @IBInspectable var endColor2: UIColor = .blue { didSet { updateGradients() } }
    @IBInspectable var startColor3: UIColor = .yellow { didSet { updateGradients() } }
    @IBInspectable var endColor3: UIColor = .purple { didSet { updateGradients() } }
    @IBInspectable var startColor4: UIColor = .cyan { didSet { updateGradients() } }
    @IBInspectable var endColor4: UIColor = .magenta { didSet { updateGradients() } }
    @IBInspectable var glowColor: UIColor = .white { didSet { updateGradients() } }
    @IBInspectable var glowIntensity: CGFloat = 10 { didSet { updateGradients() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradients()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradients()
    }

    private func setupGradients() {
        gradientLayers.forEach { $0.removeFromSuperlayer() }
        gradientLayers.removeAll()

        glowLayers.forEach { $0.removeFromSuperlayer() }
        glowLayers.removeAll()

        let colors = [
            (startColor1, endColor1),
            (startColor2, endColor2),
            (startColor3, endColor3),
            (startColor4, endColor4)
        ]
        
        let segmentAngle = (2 * CGFloat.pi) / CGFloat(colors.count)
        for i in 0..<colors.count {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colors[i].0.cgColor, colors[i].1.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = bounds

            let maskLayer = CAShapeLayer()
            let startAngle = CGFloat(i) * segmentAngle
            let endAngle = startAngle + segmentAngle
            let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - 10, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = 20
            
            maskLayer.path = path.cgPath
            maskLayer.strokeColor = UIColor.black.cgColor
            maskLayer.fillColor = UIColor.clear.cgColor
            maskLayer.lineWidth = 12

            // Configuration du glow pour ce segment
            let glowLayer = CAShapeLayer()
            glowLayer.path = path.cgPath
            glowLayer.lineWidth = 16
            glowLayer.strokeColor = glowColor.cgColor
            glowLayer.fillColor = UIColor.clear.cgColor
            glowLayer.shadowColor = glowColor.cgColor
            glowLayer.shadowOffset = CGSize.zero
            glowLayer.shadowRadius = glowIntensity
            glowLayer.shadowOpacity = 1
            glowLayer.masksToBounds = false
            layer.addSublayer(glowLayer)
            glowLayers.append(glowLayer)
        
            // Configuration du glow pour ce segment
            let glowLayer2 = CAShapeLayer()
            glowLayer2.path = path.cgPath
            glowLayer2.lineWidth = 14
            glowLayer2.strokeColor = UIColor.black.cgColor
            glowLayer2.fillColor = UIColor.clear.cgColor
            glowLayer2.shadowColor = UIColor.clear.cgColor
            glowLayer2.shadowOffset = CGSize.zero
            glowLayer2.shadowRadius = 0
            glowLayer2.shadowOpacity = 0
            glowLayer2.masksToBounds = false
            layer.addSublayer(glowLayer2)
            glowLayers.append(glowLayer2)
            
            gradientLayer.mask = maskLayer
            layer.addSublayer(gradientLayer)
            gradientLayers.append(gradientLayer)

            
        }
    }

    private func updateGradients() {
        setupGradients()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradients()
    }
}
