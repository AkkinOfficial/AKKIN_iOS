//
//  HabitViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class HabitViewController: BaseViewController {

    // MARK: UI Components
    private let habitView = HabitView()
    var bankId = 1

    // MARK: Environment
    private let router = BaseRouter()
    private let piggyBankService = PiggyBankService()
    private let refreshControl = UIRefreshControl()
    private var analysisData = AnalysisData.emptyAnalysisData
    private var challengeData = ChallengeData.testChallengeData

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getPiggyBankSummary()
        getChallenge()

        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        getMonthlyAnaylsis(year: currentYear, month: currentMonth)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = UIScreen.main.bounds
        view.backgroundColor = .akkinBG

        setNavigationItem()
        self.habitView.scrollView.refreshControl = refreshControl
        router.viewController = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

    }
    @objc func refreshData() {
        // 여기에 새로고침할 데이터를 불러오는 로직 추가 (예: API 호출)
        getPiggyBankSummary()
        // 새로고침 완료 시 refreshControl을 종료
        refreshControl.endRefreshing()
    }

    // MARK: Properties
    var monthAnalysisList = MonthAnalysis.monthAnalysisList

    // MARK: Configuration
    override func configureSubviews() {

        view.addSubview(habitView)

        habitView.makePiggyBankNonEmptyView.tapDetail = {
            [weak self] in
                guard let self else { return }
            router.popToPiggyBankDetailViewController(bankId: self.bankId)
        }

        habitView.makePiggyBankEmptyView.tapPiggyBankButton = { [weak self] in
            guard let self else { return }
            router.popToMakePiggyBankStartViewController()
        }

        habitView.tapDetailButton = { [weak self] in
            guard let self else { return }
            router.presentAnalysisExpenseViewController(analysisData: analysisData, challengeData: ChallengeData.emptyChallengeData)
        }

        habitView.analysisExpenseView.tapDetailButton = { [weak self] in
            guard let self else { return }
            router.presentCategoryDetailViewController(navigationTitle: monthAnalysisList[0].category)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        habitView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: Network
    private func getPiggyBankSummary() {
        print("💸 getPiggyBank called in HabitViewController")
        piggyBankService.getPiggyBankSummary { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? PiggyBankResponse else { return }
                print("🎯 getPiggyBank success in HabitViewController")
                print("\(data.code)")
                if data.code == "PIGGY_BANK_01" {
                    self?.habitView.viewState = .empty
                } else if data.body.isEmpty {
                    self?.habitView.viewState = .empty
                } else {
                    print("\n😆 값 불러와짐!!\n")
                    self?.habitView.viewState = .success

                    var formattedGoalAmount: String {
                        return formattedAmount(data.body[0].goalAmount)
                    }
                    var formattedCurrentAmount: String {
                        return formattedAmount(data.body[0].currentAmount)
                    }
                    self?.habitView.makePiggyBankNonEmptyView.piggyBankImageLabel.text = data.body[0].emoji
                    self?.habitView.makePiggyBankNonEmptyView.piggyBankNameLabel.text = data.body[0].name
                    self?.habitView.makePiggyBankNonEmptyView.goalAmount = formattedGoalAmount
                    self?.habitView.makePiggyBankNonEmptyView.piggyBankAmountLabel.text = formattedCurrentAmount
                    let rate =  CGFloat(data.body[0].achievementRate)/100
                    if rate == 1 {
                        self?.habitView.makePiggyBankNonEmptyView.piggyBankCompleteButton.isHidden = false
                    }
                    self?.habitView.makePiggyBankNonEmptyView.circularProgressBar.progress = rate
                    self?.bankId = data.body[0].id
                }

                func formattedAmount(_ amount: Int) -> String {
                    return NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)
                }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}

extension HabitViewController {
    // MARK: Network
    private func getChallenge() {
//        challengeData =
    }

    private func getMonthlyAnaylsis(year: Int, month: Int) {
        print("💸 getMonthlyAnaylsis called")
        NetworkService.shared.analysis.getMonthlyAnaylsis(year: year, month: month) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? MonthlyAnalysisResponse else { return }
                print("🎯 getMonthlyAnaylsis success")
                analysisData = data.body
                let analysisCase: AnalysisCase

                if data.body.element.isEmpty {
//                    if challengeData.isEmpty {
//                        habitView.setAnalysisExpenseEmtpyView(case: .emptyAnalysisEmptyChallenge)
//                    } else {
                        habitView.setAnalysisExpenseEmtpyView(analysisCase: .emptyAnalysisNonEmptyChallenge)
//                    }
                } else {
                    habitView.setAnalysisExpenseNonEmtpyView(data: data.body)
                }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                habitView.setAnalysisExpenseEmtpyView(analysisCase: .emptyAnalysisNonEmptyChallenge)
                // TODO: 임시 데이터
//                analysisData = AnalysisData.testAnalysisData
//                habitView.setAnalysisExpenseNonEmtpyView(data: analysisData)
                print("🤖 \(data)")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}

