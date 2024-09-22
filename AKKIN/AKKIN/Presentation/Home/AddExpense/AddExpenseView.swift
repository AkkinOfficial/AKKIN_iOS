//
//  AddExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AddExpenseView: BaseView {

    // MARK: UI Components
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

    lazy var expenseDetailLabel: BaseTextField = {
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
        formatter.dateFormat = "yyyy.MM.dd"
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


    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(addExpenseLabel)
        addSubview(expenseAmountTextField)
        addSubview(expenseCategoryTextField)
        addSubview(expenseDetailLabel)
        addSubview(memoTextField)
        addSubview(expenseDayTextField)
        addSubview(confirmButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        addExpenseLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).inset(50)
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

        expenseDetailLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expenseCategoryTextField.snp.bottom).offset(12)
            $0.height.equalTo(56)
        }

        memoTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(expenseDetailLabel.snp.bottom).offset(12)
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
}
