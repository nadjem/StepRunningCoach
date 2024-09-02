import UIKit

class BreathView: UIView {
    let duration = 5.0
    let rotationDuration = 5.0
    
    let numberOfLayer = 63
    let colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.purple, UIColor.systemMint, UIColor.red, UIColor.blue, UIColor.yellow, UIColor.magenta]
    var layers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assurez-vous que les animations sont configurées après que la vue soit chargée
        setupView()
    }
    
    private func setupView() {
        let breathViewSize: CGFloat = 160.0
        let breathViewFrame = CGRect(x: ((self.bounds.width ) / 2),
                                     y: (self.bounds.height ) / 2,
                                     width: breathViewSize,
                                     height: breathViewSize)
        
        let breathView = UIView(frame: breathViewFrame)
        breathView.backgroundColor = .clear
        breathView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addSubview(breathView)
        
        let breathLayer = CALayer()
        breathLayer.frame = breathView.bounds
        breathView.layer.addSublayer(breathLayer)
        
        for count in 1...numberOfLayer {
            //let randomColor = UIColor.random()
            let layer = CAShapeLayer()
            let size = CGFloat(160)
            let rect = CGRect(x: (breathLayer.bounds.width - size) / 2 + CGFloat(count * 2),
                              y: (breathLayer.bounds.height - size) / 2 + CGFloat(count * 2),
                              width: size,
                              height: size)
            
            let squarePath = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
            layer.path = squarePath
            layer.strokeColor = UIColor.white.cgColor
            layer.lineWidth = 5;
            layer.opacity = 0.0
           // layer.opacity = Float(count) * 0.005
            //layer.fillColor = colors[count - 1].cgColor
            //layer.fillColor = randomColor.cgColor
            layer.fillColor = UIColor.systemTeal.cgColor
            
            let rotationAngle = CGFloat(Double(count) * 36.0 * .pi / 180.0)
            layer.setAffineTransform(CGAffineTransform(rotationAngle: rotationAngle))
            let delay = CFTimeInterval(count) * 0.2
            layers.append(layer)
            addScaleAnimation(to: layer, withDelay: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.addMorphingAnimation(to: layer, fromPath: squarePath, toRect: rect)
                    }            //
            addRotationAnimation(to: layer,withDelay: delay, opacity: Float(count) * 0.05)
            breathLayer.addSublayer(layer)
            
        }
        
        // Test d'animation simple sur le premier calque
        /* if let firstLayer = layers.first {
         addScaleAnimation(to: firstLayer)
         addRotationAnimation(to: firstLayer)
         }*/
    }
    
    private func addScaleAnimation(to layer: CAShapeLayer, withDelay delay: CFTimeInterval) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.01
        scaleAnimation.toValue = 2.0
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scaleAnimation.duration = duration
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.beginTime = CACurrentMediaTime() + delay
        scaleAnimation.isRemovedOnCompletion = false
        layer.add(scaleAnimation, forKey: "scale")
    }
    
    private func addRotationAnimation(to layer: CAShapeLayer, withDelay delay: CFTimeInterval, opacity: Float) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rotationAnimation.duration = rotationDuration
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.beginTime = CACurrentMediaTime() + delay
        rotationAnimation.isRemovedOnCompletion = false
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            layer.opacity = opacity
        }
        layer.add(rotationAnimation, forKey: "rotation")
    }
        
    private func addMorphingAnimation(to layer: CAShapeLayer, fromPath: CGPath, toRect rect: CGRect) {
            let morphAnimation = CABasicAnimation(keyPath: "path")
            
            // Forme finale : cercle
            let circlePath = UIBezierPath(ovalIn: rect).cgPath
            
            morphAnimation.fromValue = fromPath
            morphAnimation.toValue = circlePath
            morphAnimation.duration = 6.0
            morphAnimation.autoreverses = true
            morphAnimation.repeatCount = .infinity
            morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            layer.add(morphAnimation, forKey: "morph")
        }
    
}

extension UIColor {
    static func random() -> UIColor {
        // Génération de composants RGB aléatoires
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0.5...1) // Alpha entre 0.5 et 1 pour des couleurs pas totalement transparentes

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
