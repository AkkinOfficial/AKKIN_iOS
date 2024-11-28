//
//  MonthAnalysisHeaderView.swift
//  AKKIN
//
//  Created by 박지윤 on 11/27/24.
//

import UIKit

final class MonthAnalysisHeaderView: BaseView {

    // MARK: Properties
    private var currentYear = DataManager.shared.currentMonth ?? 2024
    private var currentMonth = DataManager.shared.currentMonth ?? 11

    // MARK: UI Components
    private let monthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
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
        $0.setUnderline()
    }

    private let nextMonthButton = BaseButton().then {
        $0.setImage(AkkinButton.nextButton, for: .normal)
        $0.isEnabled = true
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
    private var analysisData = AnalysisData.emptyAnalysisData
    private var challengeData = ChallengeData.emptyChallengeData
    var totalExpense = 0
    var month = 0

    // TODO: Empty Case UI Test
    var challengeIsEmpty = false
    var analysisIsEmpty = false

    var tapPrevious: (() -> Void)?
    var tapMonth: (() -> Void)?
    var tapNext: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        backgroundColor = .white

        addSubview(monthStackView)
        addSubview(totalExpenseLabel)
        addSubview(monthAnalysisView)

        monthStackView.addArrangedSubviews(previousMonthButton,
                                           monthButton,
                                           nextMonthButton)

        previousMonthButton.addTarget(self, action: #selector(handlePreviousButtonEvent), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(handleNextButtonEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        monthStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(23)
        }

        previousMonthButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }

        nextMonthButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }

        totalExpenseLabel.snp.makeConstraints {
            $0.top.equalTo(monthStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }

        monthAnalysisView.snp.makeConstraints {
            $0.top.equalTo(totalExpenseLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview()
        }

        if challengeIsEmpty {
            addPlanExpenseGuideView()
        }
    }
}

extension MonthAnalysisHeaderView {
    func setData(analysisData: AnalysisData, challengeData: ChallengeData) {
        self.analysisData = analysisData
        self.challengeData = challengeData

        updateMonthButtonTitle()
        monthButton.isEnabled = true
        monthButton.backgroundColor = .clear

        // TODO:
        challengeIsEmpty = challengeData.endDate == 0 ? true : false
        analysisIsEmpty = analysisData.element.isEmpty ? true : false

        if analysisIsEmpty {
            setAnalysisEmptyView()
        } else {
            totalExpenseLabel.text = "\(analysisData.totalAmount.toPriceFormat) 원"
            removeMonthAnalysisSubViews()
            monthAnalysisView.setData(analysisElement: analysisData.element)

            if challengeIsEmpty {
                setChallengeEmptyView()
            } else {
                print("= challengeIsNonEmpty")
            }
        }
    }

    private func setChallengeEmptyView() {
        let analysisExpenseEmptyView = AnalysisExpenseEmptyView()
        analysisExpenseEmptyView.setData(message: "새로운 지출 챌린지를 시작할까요?",
                                         buttonTitle: "챌린지 시작하기")
        addSubview(analysisExpenseEmptyView)
        analysisExpenseEmptyView.snp.makeConstraints {
            $0.top.equalTo(monthAnalysisView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(117)
        }
    }

    private func setAnalysisEmptyView() {
        totalExpenseLabel.removeFromSuperview()
        monthAnalysisView.removeFromSuperview()
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

extension MonthAnalysisHeaderView {
    @objc private func handlePreviousButtonEvent() {
        if currentMonth == 1 {
            currentYear -= 1
            currentMonth = 12
        } else {
            currentMonth -= 1
        }
        updateMonthButtonTitle()

        tapPrevious?()
    }

    @objc private func handleNextButtonEvent() {
        if currentMonth == 12 {
            currentYear += 1
            currentMonth = 1
        } else {
            currentMonth += 1
        }
        updateMonthButtonTitle()

        tapNext?()
    }

    private func updateMonthButtonTitle() {
        let monthText = "\(currentMonth)월"
        monthButton.setTitle(monthText, for: .normal)
    }
}
