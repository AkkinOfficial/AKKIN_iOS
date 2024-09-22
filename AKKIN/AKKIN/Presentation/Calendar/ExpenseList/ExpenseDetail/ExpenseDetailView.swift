//
//  ExpenseDetailView.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseDetailView: BaseView {

    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let navigationTitleLabel = UILabel().then {
        $0.text = "상세 지출 내역"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let kebabButton = BaseButton().then {
        $0.setImage(AkkinButton.kebabButton.withTintColor(.akkinBlack2), for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let categoryBackgroundView = UIView().then {
        $0.backgroundColor = .akkinGray9
        $0.layer.cornerRadius = 32
    }

    let categoryImageLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28)
    }

    let infoLabel = UILabel().then {
        $0.textColor = .akkinGray10
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    let expenseLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }

    let memoLabel = UILabel().then {
        $0.textColor = .akkinGray10
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    // MARK: Properties
    var tapBackButtonEvent: (() -> Void)?
    var tapKebabButtonEvent: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(kebabButton)

        addSubview(categoryBackgroundView)
        addSubview(categoryImageLabel)
        addSubview(infoLabel)
        addSubview(titleLabel)
        addSubview(expenseLabel)
        addSubview(memoLabel)

        backButton.addTarget(self, action: #selector(handleBackButtonEvent), for: .touchUpInside)
        kebabButton.addTarget(self, action: #selector(handleKebabButtonEvent), for: .touchUpInside)
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
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
        }

        kebabButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        categoryBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(154)
            $0.height.width.equalTo(64)
        }

        categoryImageLabel.snp.makeConstraints {
            $0.center.equalTo(categoryBackgroundView)
        }

        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryBackgroundView.snp.bottom).offset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
        }

        expenseLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
        }

        memoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(expenseLabel.snp.bottom).offset(12)
        }
    }

    // MARK: Event
    @objc func handleBackButtonEvent() {
        tapBackButtonEvent?()
    }

    @objc func handleKebabButtonEvent() {
        tapKebabButtonEvent?()
    }}
