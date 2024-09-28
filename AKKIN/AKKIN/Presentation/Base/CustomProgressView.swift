//
//  CustomProgressView.swift
//  AKKIN
//
//  Created by 성현주 on 9/29/24.
//

import UIKit
import SnapKit

class CustomProgressView: BaseView {

    // MARK: UI Components
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    private let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Properties
    private var _totalAmount: CGFloat = 0 {
        didSet {
            setProgress()
        }
    }

    private var _usedAmount: CGFloat = 0 {
        didSet {
            setProgress()
        }
    }

    var totalAmount: CGFloat {
        get {
            return _totalAmount
        }
        set {
            _totalAmount = max(0, newValue)
            setProgress()
        }
    }

    var usedAmount: CGFloat {
        get {
            return _usedAmount
        }
        set {
            _usedAmount = max(0, newValue)
            setProgress()
        }
    }

    var lineWidth: CGFloat = 25.0 {
        didSet {
            setupLayers()
        }
    }

    override func configureSubviews() {
        super.configureSubviews()

        setupLayers()
        addSubview(centerImageView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        centerImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(45)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = circularPath().cgPath
        progressLayer.path = circularPath().cgPath

    }

    // MARK: Methods
    private func setupLayers() {
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.akkinBG.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.akkinGreen.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
    }

    private func circularPath() -> UIBezierPath {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        return UIBezierPath(arcCenter: center, radius: (bounds.width - lineWidth) / 2, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
    }

    private func setProgress() {
        let remainingAmount = totalAmount - usedAmount
        let progress = remainingAmount / totalAmount

        progressLayer.strokeEnd = progress
        backgroundLayer.path = circularPath().cgPath
        progressLayer.path = circularPath().cgPath

        animateLayer(layer: progressLayer)
    }

    private func animateLayer(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = layer.strokeEnd
        animation.duration = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "progressAnim")
    }

     func adduseAmount(_ amount: CGFloat) {
        if amount <= totalAmount {
            usedAmount += amount
            setProgress()
        }
    }

    func setCenterImage(_ image: UIImage?) {
        centerImageView.image = image
    }
}
