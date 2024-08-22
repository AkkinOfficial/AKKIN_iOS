//
//  MonthAnalysisView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit

final class MonthAnalysisView: UIStackView {

    // MARK: Init
    init() {
        super.init(frame: .zero)

        configureSubviews()
        makeConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureSubviews() {
        distribution = .fill
        backgroundColor = .akkinAnalysisDefault
        layer.cornerRadius = 6
    }

    // MARK: Layout
    private func makeConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(19)
        }
    }

    func setData(monthAnaysisData: [MonthAnalysis]) {
        for monthAnaysis in monthAnaysisData {
            let color = monthAnaysis.color
            let percent = monthAnaysis.percent
            let firstFlag = monthAnaysis.firstFlag

            let analysisView = AnalysisView(color: color,
                                            precent: percent,
                                            firstFlag: firstFlag)
            addArrangedSubview(analysisView)
        }

        let defaultAnalysisView = UIView()
        defaultAnalysisView.snp.makeConstraints {
            $0.height.equalTo(19)
        }

        addArrangedSubview(defaultAnalysisView)
    }
}
