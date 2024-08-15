//
//  AnalysisExpenseView.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AnalysisExpenseView: BaseView {

    let monthAnalysisList: [MonthAnalysis] = MonthAnalysis.monthAnalysisList

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }

    private let monthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    private let monthButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.setUnderline()
    }

    private let nextMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
    }

    private let emtpyView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let totalExpenseLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    private let monthAnalysisView = MonthAnalysisView()

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setData()
        monthAnalysisView.setData(monthAnaysisData: monthAnalysisList)

        addSubview(scrollView)

        scrollView.addSubview(monthStackView)
        monthStackView.addArrangedSubviews(previousMonthButton,
                                           monthButton,
                                           nextMonthButton,
                                           emtpyView)

        scrollView.addSubview(totalExpenseLabel)
        scrollView.addSubview(monthAnalysisView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        monthStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.width.equalToSuperview()
            $0.height.equalTo(23)
        }

        totalExpenseLabel.snp.makeConstraints {
            $0.top.equalTo(monthStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }

        monthAnalysisView.snp.makeConstraints {
            $0.top.equalTo(totalExpenseLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview()
        }
    }

    // MARK: Event

    // MARK: Data
    private func setData() {
        monthButton.setTitle("8월", for: .normal)
        let totalExpense = 688120
        totalExpenseLabel.text = "\(totalExpense.toPriceFormat) 원"
    }
}
