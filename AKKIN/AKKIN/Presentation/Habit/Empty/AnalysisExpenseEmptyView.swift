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
        $0.text = "분석할 수 있는 지출 기록이 없어요.\n본인의 지출을 계획하고 절약을 시작해보세요!"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let analysisExpenseEmptyButton = BaseButton().then {
        $0.setGuideButton("지출 계획하기")
    }

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

    // MARK: Event
}
