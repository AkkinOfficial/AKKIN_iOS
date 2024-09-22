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
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let navigationTitleLabel = UILabel().then {
        $0.text = "상세 지출 내역"
        $0.textColor = .akkinBlack2
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }

    private let kebabButton = BaseButton().then {
        $0.setImage(AkkinButton.kebabButton, for: .normal)
    }

    private let categoryBackgroundView = UIView().then {
        $0.backgroundColor = .akkinGray9
        $0.layer.cornerRadius = 32
    }

    private let categoryImageLabel = UILabel().then {
        $0.text = "🛒"
        $0.font = UIFont.systemFont(ofSize: 28)
    }

    private let infoLabel = UILabel().then {
        $0.text = "생활"
        $0.textColor = .akkinGray10
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    private let contentLabel = UILabel().then {
        $0.text = "생필품"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    private let expenseLabel = UILabel().then {
        $0.text = "13,680"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    }

    private let memoLabel = UILabel().then {
        $0.text = "친구 만나서 파스타 냠냠"
        $0.textColor = .akkinGray10
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(backButton)
        addSubview(navigationTitleLabel)
        addSubview(kebabButton)

        addSubview(categoryBackgroundView)
        addSubview(categoryImageLabel)
        addSubview(infoLabel)
        addSubview(contentLabel)
        addSubview(expenseLabel)
        addSubview(memoLabel)
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

        kebabButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        categoryBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(195)
        }

        categoryImageLabel.snp.makeConstraints {
            $0.center.equalTo(categoryBackgroundView)
        }

        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryBackgroundView.snp.bottom).offset(16)
        }

        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
        }

        expenseLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
        }

        memoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
        }
    }

    // MARK: Event
}
