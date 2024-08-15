//
//  HomeView.swift
//  AKKIN
//
//  Created by 성현주 on 9/14/24.
//

import UIKit

final class HomeView: BaseView {

    // MARK: UI Components

    lazy var planExpenseButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("지출 계획하기", for: .normal)
        button.isEnabled = true
        return button
    }()

    // MARK: Properties
    var tapExpense: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(planExpenseButton)

        planExpenseButton.addTarget(self, action: #selector(didTapPlanExpenseButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        planExpenseButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(120)
            $0.center.equalToSuperview()
            $0.height.equalTo(48)
        }
    }

    // MARK: Event
    @objc private func didTapPlanExpenseButton() {
        tapExpense?()
    }
}

