//
//  HomeView.swift
//  AKKIN
//
//  Created by 성현주 on 9/14/24.
//

import UIKit

final class HomeView: BaseView {

    // MARK: UI Components
    lazy var addExpenseButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("지출 추가하기", for: .normal)
        button.isEnabled = true
        return button
    }()

    lazy var toggleButton: CustomToggleButton = {
        let button = CustomToggleButton()
        return button
    }()

    lazy var expensePlanLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.setLineSpacing(10)
        label.textAlignment = .center
        return label
    }()

    lazy var progressView : CustomProgressView = {
        let progressView = CustomProgressView()
        return progressView
    }()

    // MARK: Properties
    var tapAddExpense: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(addExpenseButton)
        addSubview(toggleButton)
        addSubview(progressView)
        addSubview(expensePlanLabel)

        addExpenseButton.addTarget(self, action: #selector(didTapAddExpenseButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        addExpenseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(56)
        }
        toggleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(119)
            $0.width.equalTo(219)
            $0.height.equalTo(49)
        }
        expensePlanLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toggleButton.snp.bottom).offset(40)
        }
        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(180) 
        }
    }

    // MARK: Event
    @objc private func didTapAddExpenseButton() {
        tapAddExpense?()
    }
}

