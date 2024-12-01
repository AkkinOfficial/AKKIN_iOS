//
//  AnalysisView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

final class AnalysisView: BaseView {

    // MARK: Init
    init(color: UIColor, precent: Double, firstFlag: Bool, lastFlag: Bool) {
        super.init(frame: .zero)

        setData(color: color, percent: precent, firstFlag: firstFlag, lastFlag: lastFlag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI Components

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        snp.makeConstraints {
            $0.height.equalTo(19)
        }
    }

    private func setData(color: UIColor, percent: Double, firstFlag: Bool, lastFlag: Bool) {
        backgroundColor = color
        let screenWidth = UIScreen.main.bounds.size.width
        let width = screenWidth * percent / 100

        snp.makeConstraints {
            $0.width.equalTo(width)
        }

        layer.cornerRadius = 6

        if firstFlag && lastFlag {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner,
                                   .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else if firstFlag {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else if lastFlag {
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            layer.maskedCorners = []
        }
    }
}
