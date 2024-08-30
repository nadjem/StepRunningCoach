import UIKit

class GradientCircleView: UIView {

    private var gradientLayer: CAGradientLayer!
    private var circleLayer: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        // Création du gradient layer
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.systemTeal.cgColor, UIColor.blue.cgColor] // Modifiez pour les couleurs souhaitées
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        layer.addSublayer(gradientLayer)

        // Création du cercle layer
        circleLayer = CAShapeLayer()
        circleLayer.lineWidth = 15 // Épaisseur de la bordure
        circleLayer.fillColor = UIColor.clear.cgColor // Transparent à l'intérieur
        circleLayer.strokeColor = UIColor.black.cgColor // La couleur est remplacée par le gradient
        gradientLayer.mask = circleLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        // Mise à jour du chemin du cercle pour qu'il corresponde à la vue
        let path = UIBezierPath(ovalIn: bounds.insetBy(dx: circleLayer.lineWidth / 2, dy: circleLayer.lineWidth / 2))
        circleLayer.path = path.cgPath
    }
}
