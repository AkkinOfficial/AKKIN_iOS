//
//  ExpenseListView.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseListView: BaseView {

    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let navigationTitleLabel = UILabel().then {
        $0.text = "지출 내역"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
    }

    private let dateButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousDateButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    private let dateButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
    }

    private let nextDateButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
    }

    private let savingLabel = UILabel().then {
        $0.text = "아낀 금액: 8,190원"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
    }

    private let dividerView = UIView().then {
        $0.backgroundColor = .akkinGray8
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(addButton)

        addSubview(dateButtonStackView)
        dateButtonStackView.addArrangedSubviews(
            previousDateButton,
            dateButton,
            nextDateButton)

        addSubview(dividerView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        backButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.leading.equalToSuperview().inset(16)
        }

        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(15)
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        dateButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        dividerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(16)
        }
    }

    // MARK: Event
}
