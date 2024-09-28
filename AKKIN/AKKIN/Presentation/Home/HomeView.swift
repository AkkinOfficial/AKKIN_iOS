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

