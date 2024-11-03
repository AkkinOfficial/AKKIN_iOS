//
//  CircularProgressBar.swift
//  AKKIN
//
//  Created by 신종원 on 9/30/24.
//

import UIKit

class CircularProgressView: UIView {

    // MARK: - UI Properties
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    // MARK: - Customizable Properties
    var lineWidth: CGFloat = 5 {
        didSet {
            configureLayers()
        }
    }
    var progressColor: UIColor = .akkinGreen {
        didSet {
            progressLayer.strokeColor = UIColor.akkinGreen.cgColor
        }
    }
    var backgroundCircleColor: UIColor = .akkinGray3 {
        didSet {
            backgroundLayer.strokeColor = UIColor.akkinGray3.cgColor
        }
    }

    // Progress value (0.0 to 1.0)
    var progress: Double = 0.0 {
        didSet {
            setProgress(progress)
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .clear
        configureLayers()
    }

    private func configureLayers() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = backgroundCircleColor.cgColor
        layer.addSublayer(backgroundLayer)

        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)

        setProgress(progress)
    }

    // MARK: - Layout and Draw Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCircularPaths()
    }

    private func configureCircularPaths() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 3 / 2, clockwise: true)

        backgroundLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }

    // MARK: - Progress Update
    private func setProgress(_ progress: Double) {
        progressLayer.strokeEnd = CGFloat(max(0, min(progress, 1))) // Clamp between 0 and 1
    }
}
