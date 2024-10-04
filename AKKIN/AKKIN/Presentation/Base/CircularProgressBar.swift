//
//  CircularProgressBar.swift
//  AKKIN
//
//  Created by 신종원 on 9/30/24.
//

import Foundation
import UIKit

class CircularProgressView: UIView {

    private let lineWidth: CGFloat = 5

    var value: Double? {
        didSet {
            guard let _ = value else { return }
            setProgress(diameter: 28, progress: 0.75)
        }
    }

    override func draw(_ rect: CGRect) {
       super.draw(rect)

       let path = UIBezierPath()
       let radius = (rect.width - lineWidth) / 2
       path.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                   radius: radius,
                   startAngle: 0,
                   endAngle: 2 * .pi,
                   clockwise: true)
       path.lineWidth = lineWidth
       UIColor.akkinGray3_1.set()
       path.stroke()
    }
    func setProgress(diameter: CGFloat, progress: Double) {
        backgroundColor = .clear

        let radius = (diameter - lineWidth) / 2
        let startAngle = CGFloat.pi / 2
        let endAngle = (.pi * 2) * CGFloat(progress) - startAngle

        let circularPath = UIBezierPath(arcCenter: CGPoint(x: diameter / 2, y: diameter / 2),
                                        radius: radius,
                                        startAngle: -startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)

        let circularLayer = CAShapeLayer()
        circularLayer.path = circularPath.cgPath
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.strokeColor = UIColor.akkinGreen.cgColor
        circularLayer.lineWidth = lineWidth
        circularLayer.lineCap = .round

        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.addSublayer(circularLayer)

    }
}
