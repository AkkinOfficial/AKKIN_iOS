//
//  MonthAnalysisCollectionViewHeader.swift
//  AKKIN
//
//  Created by 박지윤 on 8/16/24.
//

import UIKit

final class MonthAnalysisCollectionViewHeader: UICollectionReusableView {

    static let identifier = "MonthAnalysisCollectionViewHeader"

    // MARK: UI Components
    private let monthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    let monthButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
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

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    let monthAnalysisList: [MonthAnalysis] = MonthAnalysis.monthAnalysisList
    var totalExpense = 0
    var month = 0

    var tapPrevious: (() -> Void)?
    var tapMonth: (() -> Void)?
    var tapNext: (() -> Void)?

    // MARK: Configuration
    private func configureSubviews() {
        addSubview(monthStackView)
        addSubview(totalExpenseLabel)
        addSubview(monthAnalysisView)

        monthStackView.addArrangedSubviews(previousMonthButton,
                                           monthButton,
                                           nextMonthButton,
                                           emtpyView)

        previousMonthButton.addTarget(self, action: #selector(handlePreviousButtonEvent), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(handleNextButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    private func makeConstraints() {
        monthStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
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
}

extension MonthAnalysisCollectionViewHeader {
    @objc private func handlePreviousButtonEvent() {
        tapPrevious?()
    }

    @objc private func handleNextButtonEvent() {
        tapNext?()
    }

    func setData(monthAnaysisData: [MonthAnalysis], totalExpense: Int) {
        let month = monthAnaysisData[0].month
        monthButton.setTitle("\(month)월", for: .normal)
        monthButton.setUnderline()
        totalExpenseLabel.text = "\(totalExpense.toPriceFormat) 원"

        removemonthAnalysisSubViews()
        monthAnalysisView.setData(monthAnaysisData: monthAnaysisData)
    }

    private func removemonthAnalysisSubViews() {
        if !(monthAnalysisView.subviews.isEmpty) {
            for subview in monthAnalysisView.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}
