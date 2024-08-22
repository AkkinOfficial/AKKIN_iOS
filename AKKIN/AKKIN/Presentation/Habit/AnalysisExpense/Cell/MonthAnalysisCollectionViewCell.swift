//
//  MonthAnalysisCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 8/15/24.
//

import UIKit
import SnapKit

class MonthAnalysisCollectionViewCell: UICollectionViewCell {

    static let identifier = "MonthAnalysisCollectionViewCell"

    // MARK: UI Components
    let categoryImageBackgroudView = UIView().then {
        $0.backgroundColor = .akkinBG
        $0.layer.cornerRadius = 20.5
    }

    let categoryImageLabel = UILabel().then {
        $0.text = "🍽️"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.textAlignment = .center
    }

    let categoryStackView = UIStackView().then {
        $0.axis = .vertical
    }

    let categoryTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let categoryPercentLabel = UILabel().then {
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    let categoryExpenseLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let detailButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton.withTintColor(.akkinGray6), for: .normal)
    }

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    var tapDetail: (() -> Void)?

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(categoryImageBackgroudView)
        contentView.addSubview(categoryTitleLabel)
        contentView.addSubview(categoryStackView)
        contentView.addSubview(categoryExpenseLabel)
        contentView.addSubview(detailButton)

        categoryImageBackgroudView.addSubview(categoryImageLabel)
        categoryStackView.addArrangedSubviews(categoryTitleLabel,
                                              categoryPercentLabel)

        detailButton.addTarget(self, action: #selector(handleDetailButtonEvent), for: .touchUpInside)
    }

    @objc private func handleDetailButtonEvent() {
        tapDetail?()
    }

    // MARK: Layout
    private func makeConstraints() {
        categoryImageBackgroudView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(45)
        }

        categoryImageLabel.snp.makeConstraints {
            $0.center.equalTo(categoryImageBackgroudView)
        }

        categoryStackView.snp.makeConstraints {
            $0.leading.equalTo(categoryImageBackgroudView.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(41)
        }

        categoryExpenseLabel.snp.makeConstraints {
            $0.trailing.equalTo(detailButton.snp.leading).offset(-4)
            $0.centerY.equalToSuperview()
        }

        detailButton.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
    }
}

extension MonthAnalysisCollectionViewCell {
    func setData(monthAnaysisData: MonthAnalysis) {
        if let category = Category.toImageString(monthAnaysisData.category) {
            categoryImageLabel.text = category.categoryImageString
        } else {
            categoryImageLabel.text = "⚠️"
        }
        categoryTitleLabel.text = monthAnaysisData.category
        categoryPercentLabel.text = "\(monthAnaysisData.percent)%"
        categoryExpenseLabel.text = "\(monthAnaysisData.expense.toPriceFormat) 원"
    }
}
