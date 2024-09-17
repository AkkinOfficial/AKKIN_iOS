//
//  EmptyHomeView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class EmptyHomeView: BaseView {

    // MARK: UI Components

    lazy var emptyBillImageView = UIImageView().then {
        $0.image = AkkinImage.emptyBill
    }

    lazy var expenseChallengeLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expenseChallengeTitle
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .akkinGray6
        return label
    }()

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

        addSubview(emptyBillImageView)
        addSubview(expenseChallengeLabel)
        addSubview(planExpenseButton)

        planExpenseButton.addTarget(self, action: #selector(didTapPlanExpenseButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        expenseChallengeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyBillImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(115)
            $0.height.equalTo(85)
            $0.bottom.equalTo(expenseChallengeLabel.snp.top).offset(-40)
        }

        planExpenseButton.snp.makeConstraints {
            $0.top.equalTo(expenseChallengeLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(120)
            $0.height.equalTo(48)
        }
    }

    // MARK: Event
    @objc private func didTapPlanExpenseButton() {
        tapExpense?()
    }
}
