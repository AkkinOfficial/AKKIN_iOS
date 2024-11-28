//
//  AnalysisExpenseEmptyView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class AnalysisExpenseEmptyView: BaseView {

    // MARK: UI Components
    private let analysisExpenseEmptyLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let analysisExpenseEmptyButton = BaseButton()

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        backgroundColor = .white
        layer.cornerRadius = 16

        addSubview(analysisExpenseEmptyLabel)
        addSubview(analysisExpenseEmptyButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        analysisExpenseEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        analysisExpenseEmptyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    // MARK: Data
    func setData(message: String, buttonTitle: String) {
        analysisExpenseEmptyLabel.text = message
        analysisExpenseEmptyButton.setGuideButton(buttonTitle)
    }
}
