//
//  PlanExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class PlanExpenseView: BaseView {

    // MARK: UI Components
    lazy var expensePlanLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.numberOfLines = 0
        return label
    }()

    lazy var periodTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "기간"
        textField.addLeftImage(image: AkkinIcon.miniCalendar)
        return textField
    }()

    lazy var budgetTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "에산"
        textField.addLeftImage(image: AkkinIcon.tag)
        textField.addRightLabel(text: "원", textColor: .akkinGray6)
        textField.addCommas()
        return textField
    }()

    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(AkkinString.confirm, for: .normal)
        return button
    }()


    // MARK: Properties
    var tapPeriodTextField: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(expensePlanLabel)
        addSubview(periodTextField)
        addSubview(budgetTextField)
        addSubview(confirmButton)

        periodTextField.addTarget(self, action: #selector(didTapPeriodTextField), for: .touchDown)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        expensePlanLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).inset(50)
        }

        periodTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expensePlanLabel.snp.bottom).offset(24)
            $0.height.equalTo(56)
        }

        budgetTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(periodTextField.snp.bottom).offset(12)
            $0.height.equalTo(56)
        }

        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
    }

    // MARK: Event
    @objc private func didTapPeriodTextField() {
        tapPeriodTextField?()
    }
}
