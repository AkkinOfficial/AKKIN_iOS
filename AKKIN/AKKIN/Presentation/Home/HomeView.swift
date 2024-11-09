//
//  HomeView.swift
//  AKKIN
//
//  Created by 성현주 on 9/14/24.
//

import UIKit

final class HomeView: BaseView {

    // MARK: UI Components
    private let homeNavigationBar = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let homeLogo: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "ic_logo")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .akkinGray5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .clear
        return button
    }()
    let homeAlarmButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "alarm_button")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .akkinGray5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .clear
        return button
    }()
    let homeKebbabButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "kebab_button")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .akkinGray5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .clear
        return button
    }()

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
        addSubview(homeNavigationBar)
        homeNavigationBar.addSubview(homeLogo)
        homeNavigationBar.addSubview(homeAlarmButton)
        homeNavigationBar.addSubview(homeKebbabButton)
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
        homeNavigationBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
            $0.horizontalEdges.equalToSuperview()
        }
        homeLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        homeAlarmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(48)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        homeKebbabButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        addExpenseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(56)
        }

        toggleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeNavigationBar.snp.bottom).offset(8)
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

