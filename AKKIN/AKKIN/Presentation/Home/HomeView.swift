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

    lazy var homeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.setLineSpacing(10)
        label.textAlignment = .center
        return label
    }()

    private let parentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }

    private let expenseStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 12
    }

    private let challengeStackview = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 12
    }

    lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "사용금액"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.text = "챌린지 금액"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    lazy var challengeAmountLabel: UILabel = {
        let label = UILabel()
        label.text = AkkinString.expensePlanHeadLine
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
        addSubview(homeTitleLabel)
        addSubview(parentStackView)

        parentStackView.addArrangedSubviews(expenseStackview, challengeStackview)
        expenseStackview.addArrangedSubviews(expenseLabel, expenseAmountLabel)
        challengeStackview.addArrangedSubviews(challengeLabel, challengeAmountLabel)

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

        homeTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(toggleButton.snp.bottom).offset(40)
        }

        progressView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(180)
        }

        parentStackView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(65)
        }
    }

    // MARK: Event
    @objc private func didTapAddExpenseButton() {
        tapAddExpense?()
    }
}

