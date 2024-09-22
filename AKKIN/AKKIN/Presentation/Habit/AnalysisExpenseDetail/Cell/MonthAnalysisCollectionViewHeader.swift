//
//  MonthAnalysisCollectionViewHeader.swift
//  AKKIN
//
//  Created by 박지윤 on 8/16/24.
//

import UIKit

final class MonthAnalysisCollectionViewHeader: UICollectionReusableView {

    // MARK: Properties
    static let identifier = "MonthAnalysisCollectionViewHeader"

    // MARK: UI Components
    private let monthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let previousMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    let monthButton = BaseButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
    }

    private let nextMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
        $0.isEnabled = true
        $0.backgroundColor = .clear
    }

    private let emtpyView = UIView().then {
        $0.backgroundColor = .clear
    }

    let totalExpenseLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }

    let monthAnalysisView = MonthAnalysisView()

    let planExpenseGuideView = PlanExpenseGuideView()

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
    let monthAnalysisList = MonthAnalysis.monthAnalysisList
    var totalExpense = 0
    var month = 0

    // TODO: Empty Case UI Test
    var planisEmpty = false

    var tapPrevious: (() -> Void)?
    var tapMonth: (() -> Void)?
    var tapNext: (() -> Void)?

    // MARK: Configuration
    private func configureSubviews() {
        backgroundColor = .white

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

        if planisEmpty {
            addPlanExpenseGuideView()
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
        print("reloadData()")
        let currentMonth = DataManager.shared.currentMonth
        monthButton.setTitle("\(currentMonth ?? month)월", for: .normal)
        monthButton.setUnderline()
        monthButton.isEnabled = true
        monthButton.backgroundColor = .clear
        totalExpenseLabel.text = "\(totalExpense.toPriceFormat) 원"

        removeMonthAnalysisSubViews()
        monthAnalysisView.setData(monthAnaysisData: monthAnaysisData)
    }

    private func removeMonthAnalysisSubViews() {
        if !(monthAnalysisView.subviews.isEmpty) {
            for subview in monthAnalysisView.subviews {
                subview.removeFromSuperview()
            }
        }
    }

    private func addPlanExpenseGuideView() {
        addSubview(planExpenseGuideView)

        planExpenseGuideView.snp.makeConstraints {
            $0.top.equalTo(monthAnalysisView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(117)
        }
    }
}
