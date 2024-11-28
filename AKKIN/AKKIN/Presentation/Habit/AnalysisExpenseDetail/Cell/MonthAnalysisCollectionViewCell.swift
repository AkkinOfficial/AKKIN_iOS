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

    let categoryTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let categoryColorView = UIView().then {
        $0.layer.cornerRadius = 4
    }

    let categoryTitleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }

    let categoryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
    }

    let categoryRatioLabel = UILabel().then {
        $0.textColor = .akkinGray6
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    let expenseStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .trailing
    }

    let categoryExpenseLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    let categoryTotalLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
        contentView.addSubview(categoryStackView)
        contentView.addSubview(categoryExpenseLabel)

        categoryImageBackgroudView.addSubview(categoryImageLabel)
        
        categoryTitleStackView.addArrangedSubviews(categoryTitleLabel,
                                                   categoryColorView)
        categoryStackView.addArrangedSubviews(categoryTitleStackView,
                                              categoryRatioLabel)
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

        categoryColorView.snp.makeConstraints {
            $0.height.width.equalTo(8)
            $0.centerY.equalToSuperview()
        }

        categoryTitleStackView.snp.makeConstraints {
            $0.height.equalTo(21)
        }

        categoryStackView.snp.makeConstraints {
            $0.leading.equalTo(categoryImageBackgroudView.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(41)
        }

        categoryExpenseLabel.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
    }
}

extension MonthAnalysisCollectionViewCell {
    func setData(data: AnalysisElement) {
        categoryImageLabel.text = data.categoryEnum
        categoryTitleLabel.text = data.category
        let categoryColor = data.getCategoryColor(data.category)
        categoryColorView.backgroundColor = categoryColor
        categoryRatioLabel.text = "\(data.ratio)%"
        categoryExpenseLabel.text = "\(data.amount.toPriceFormat) 원"
    }

    func setExpenseListData(data: ExpenseData) {
        categoryExpenseLabel.removeFromSuperview()

        contentView.addSubview(expenseStackView)
        expenseStackView.addArrangedSubviews(categoryExpenseLabel, categoryTotalLabel)

        expenseStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        categoryImageLabel.text = data.category.categoryImageString
        categoryTitleLabel.text = data.title
        categoryRatioLabel.text = data.category.toString
        categoryRatioLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        categoryExpenseLabel.text = data.saving.toPriceFormat + " 원"
        categoryTotalLabel.text = data.total.toPriceFormat + " 원"
    }
}
