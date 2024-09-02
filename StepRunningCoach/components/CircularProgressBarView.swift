import UIKit

class CircularProgressBar: UIView {

    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var haloLayer = CAShapeLayer()
    
    var progressColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
            haloLayer.strokeColor = progressColor.withAlphaComponent(0.3).cgColor
        }
    }

    var trackColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 20
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        haloLayer.path = circularPath.cgPath
        haloLayer.fillColor = UIColor.clear.cgColor
        haloLayer.strokeColor = progressColor.withAlphaComponent(0.3).cgColor
        haloLayer.lineWidth = 21
        haloLayer.strokeEnd = 1
        haloLayer.shadowColor = UIColor.white.cgColor
        haloLayer.shadowRadius = 10
        haloLayer.shadowOpacity = 0.5
        haloLayer.shadowOffset = CGSize.zero
        layer.insertSublayer(haloLayer, below: progressLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 14
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    func setProgress(to progress: CGFloat, withAnimation: Bool = true) {
        var cappedProgress = progress
        if progress > 1 {
            cappedProgress = 1
        } else if progress < 0 {
            cappedProgress = 0
        }

        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = cappedProgress
            animation.duration = 0.5
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: "progressAnim")
            haloLayer.add(animation, forKey: "progressAnim")
        } else {
            progressLayer.strokeEnd = cappedProgress
            haloLayer.strokeEnd = cappedProgress
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        trackLayer.frame = bounds
        progressLayer.frame = bounds
        haloLayer.frame = bounds
        setupLayers()
    }
    
}
