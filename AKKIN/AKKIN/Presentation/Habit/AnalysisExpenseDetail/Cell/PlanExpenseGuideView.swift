//
//  PlanExpenseGuideView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/22/24.
//

import UIKit

final class PlanExpenseGuideView: BaseView {

    // MARK: UI Components
    private let planExpenseGuideLabel = UILabel().then {
        $0.text = "새로운 지출 계획을 세우시겠어요?"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let planExpenseGuideButton = BaseButton().then {
        $0.setGuideButton("지출 계획하기")
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        configureView()

        addSubview(planExpenseGuideLabel)
        addSubview(planExpenseGuideButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        planExpenseGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }

        planExpenseGuideButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.07
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
    }

    // MARK: Event
}
