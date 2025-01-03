//
//  AddExpenseConfirmView.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import UIKit

final class AddExpenseConfirmView: BaseView {

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

    private let expenseStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 12
    }

    lazy var backgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()

    let iconImageView: UILabel = {
        let imageLabel = UILabel()
        imageLabel.textAlignment = .center
        imageLabel.font = UIFont.systemFont(ofSize: 28)
        return imageLabel
    }()


    lazy var expenseContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    lazy var expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .akkinGreen
        return label
    }()

    lazy var expenseMemoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .akkinGray4
        return label
    }()

    lazy var confirmButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(AkkinString.confirm, for: .normal)
        button.isEnabled = true
        return button
    }()

    // MARK: Properties
    var tapExpense: (() -> Void)?
    var tapConfirmButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(addExpenseNavigationBar)
        addExpenseNavigationBar.addSubview(backButton)
        addExpenseNavigationBar.addSubview(addExpenseTitleLabel)
        addSubview(backgroundCircleView)
        addSubview(iconImageView)
        addSubview(expenseStackView)
        addSubview(confirmButton)

        expenseStackView.addArrangedSubviews(expenseContentLabel,expenseAmountLabel,expenseMemoLabel)

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

        backgroundCircleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(274)
            make.width.height.equalTo(64)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(backgroundCircleView)
        }

        expenseStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundCircleView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
    }

    // MARK: Event
    @objc private func didTapConfirmButton() {
        tapConfirmButton?()
    }
}

