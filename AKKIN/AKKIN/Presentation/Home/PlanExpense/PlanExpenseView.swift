//
//  PlanExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class PlanExpenseView: BaseView {

    // MARK: UI Components
    private let planExpenseNavigationBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill

    }

    let backButton = BaseButton().then {
        $0.setBackButton()
    }

    private let planExpenseLabel = UILabel().then {
        $0.text = "챌린지 시작하기"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    lazy var expensePlanLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    lazy var helperLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .akkinGreen
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
        textField.placeholder = "챌린지 설정 금액"
        textField.addLeftImage(image: AkkinIcon.tag)
        textField.addRightLabel(text: "원", textColor: .akkinGray6)
        textField.addCommas()
        return textField
    }()

    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(AkkinString.confirm, for: .normal)
        button.isEnabled = true
        return button
    }()


    // MARK: Properties
    var tapPeriodTextField: (() -> Void)?
    var tapConfirmButton: (() -> Void)?
    var editbudgetTextField: ((String) -> Void)?

    // MARK: Custom Keyboard
    private let customKeyboardVC = CustomKeyboardViewController()


    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(planExpenseNavigationBar)
        planExpenseNavigationBar.addSubview(backButton)
        planExpenseNavigationBar.addSubview(planExpenseLabel)
        addSubview(expensePlanLabel)
        addSubview(periodTextField)
        addSubview(budgetTextField)
        addSubview(confirmButton)
        addSubview(helperLabel)

        periodTextField.addTarget(self, action: #selector(didTapPeriodTextField), for: .touchDown)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        budgetTextField.addTarget(self, action: #selector(didEditbudgetTextField), for: .allEditingEvents)

        customKeyboardVC.delegate = self
        budgetTextField.inputView = customKeyboardVC.view
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        navigationBar.snp.makeConstraints {
            $0.top.width.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }

        navigationLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.center.equalToSuperview()
        }

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

        helperLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(budgetTextField.snp.bottom).offset(8)
        }
    }

    // MARK: Event
    @objc private func didTapPeriodTextField() {
        tapPeriodTextField?()
    }
    @objc private func didTapConfirmButton() {
        tapConfirmButton?()
    }
    @objc private func didEditbudgetTextField() {
        editbudgetTextField?(budgetTextField.text ?? "")
    }
}

extension PlanExpenseView: CustomKeyboardDelegate {
    func customKeyboard(_ keyboard: CustomKeyboardViewController, didEnterAmount amount: String) {
        budgetTextField.text = amount
        editbudgetTextField?(amount)
    }
}
