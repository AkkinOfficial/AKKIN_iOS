//
//  AddExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AddExpenseView: BaseView {

    // MARK: UI Components
    private let addExpenseNavigationBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let backButton = BaseButton().then {
        $0.setBackButton()
    }

    private let addExpenseTitleLabel = UILabel().then {
        $0.text = "지출 추가하기"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    lazy var addExpenseLabel: UILabel = {
        let label = UILabel()
        label.text = "지출한 내역을 \n기록해보세요."
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    lazy var expenseAmountTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "지출 금액"
        textField.addLeftImage(image: AkkinIcon.wallet)
        textField.addRightLabel(text: "원", textColor: .akkinGray6)
        return textField
    }()

    lazy var expenseCategoryTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "소비 카테고리"
        textField.addLeftImage(image: AkkinIcon.tag)
        return textField
    }()

    lazy var expenseContentTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "지출 내용"
        textField.addLeftImage(image: AkkinIcon.bookmark)
        return textField
    }()

    lazy var memoTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "메모(선택)"
        textField.addLeftImage(image: AkkinIcon.memo)
        return textField
    }()

    lazy var expenseDayTextField: BaseTextField = {
        let textField = BaseTextField()
        formatter.dateFormat = "yyyy-MM-dd"
        textField.text = formatter.string(from: Date())
        textField.addLeftImage(image: AkkinIcon.miniCalendar)
        textField.addRightLabel(text: "오늘", textColor: .akkinGreen)
        return textField
    }()

    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(AkkinString.confirm, for: .normal)
        button.isEnabled = true
        return button
    }()

    // MARK: Properties
    var formatter = DateFormatter()
    var tapCategoryTextField: (() -> Void)?
    var tapExpenseDayTextField: (() -> Void)?
    var tapConfirmButton: (() -> Void)?

    // MARK: Custom Keyboard
    private let customKeyboardVC = CustomKeyboardViewController()


    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(addExpenseNavigationBar)
        addExpenseNavigationBar.addSubview(backButton)
        addExpenseNavigationBar.addSubview(addExpenseTitleLabel)
        addSubview(addExpenseLabel)
        addSubview(expenseAmountTextField)
        addSubview(expenseCategoryTextField)
        addSubview(expenseContentTextField)
        addSubview(memoTextField)
        addSubview(expenseDayTextField)
        addSubview(confirmButton)

        customKeyboardVC.delegate = self
        expenseAmountTextField.inputView = customKeyboardVC.view

        expenseCategoryTextField.addTarget(self, action: #selector(didTapCategoryTextField), for: .touchDown)
        expenseDayTextField.addTarget(self, action: #selector(didTapExpenseDayTextField), for: .touchDown)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside) 

    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        addExpenseNavigationBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(56)
            $0.horizontalEdges.equalToSuperview()
        }
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        addExpenseTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
      
        addExpenseLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(addExpenseNavigationBar.snp.bottom).offset(32)
        }

        expenseAmountTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(addExpenseLabel.snp.bottom).offset(24)
            $0.height.equalTo(56)
        }

        expenseCategoryTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expenseAmountTextField.snp.bottom).offset(12)
            $0.height.equalTo(56)
        }

        expenseContentTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expenseCategoryTextField.snp.bottom).offset(12)
            $0.height.equalTo(56)
        }

        memoTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expenseContentTextField.snp.bottom).offset(12)
            $0.height.equalTo(84)
        }

        expenseDayTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(memoTextField.snp.bottom).offset(12)
            $0.height.equalTo(56)
        }

        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
    }

    // MARK: Event
    @objc private func didTapCategoryTextField() {
        tapCategoryTextField?()
    }

    @objc private func didTapExpenseDayTextField() {
        tapExpenseDayTextField?()
    }

    @objc private func didTapConfirmButton() {
        tapConfirmButton?()
    }
}

extension AddExpenseView: CustomKeyboardDelegate {
    func customKeyboard(_ keyboard: CustomKeyboardViewController, didEnterAmount amount: String) {
        expenseAmountTextField.text = amount
    }
}
