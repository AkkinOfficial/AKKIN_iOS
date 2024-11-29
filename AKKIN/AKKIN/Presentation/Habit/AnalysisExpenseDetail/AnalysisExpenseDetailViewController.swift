//
//  AnalysisExpenseDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AnalysisExpenseDetailViewController: BaseViewController {

    // MARK: UI Components
    private let analysisExpenseView = AnalysisExpenseDetailView()
  
    private let backButton = BaseButton().then {
        $0.setBackButton()
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
    }

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Properties
    private var analysisData = AnalysisData.emptyAnalysisData
    private var challengeData = ChallengeData.emptyChallengeData

    // MARK: Init
    init(analysisData: AnalysisData, challengeData: ChallengeData) {
        self.analysisData = analysisData
        self.challengeData = challengeData

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        analysisExpenseView.setData(analysisData: analysisData, challengeData: challengeData)
        analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: challengeData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        router.viewController = self
        setNavigationItem()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(analysisExpenseView)

        analysisExpenseView.tapBackButtonEvent = { [self] in
            router.popViewController()
        }

        analysisExpenseView.tapAddButtonEvent = { [self] in
            print("tap add button")
        }

        analysisExpenseView.tapMonthButtonEvent = { [self] in
            router.presentModeSelectViewController()
        }

        analysisExpenseView.monthAnalysisHeaderView.tapPrevious = { [self] year, month in
            getMonthlyAnaylsis(year: year, month: month)
        }

        analysisExpenseView.monthAnalysisHeaderView.tapNext = { [self] year, month in
            getMonthlyAnaylsis(year: year, month: month)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        analysisExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension AnalysisExpenseDetailViewController: SelectMonthViewControllerDelegate {
    func dismissButtonTapped() {
        analysisExpenseView.monthAnalysisCollectionView.reloadData()
    }
}

extension AnalysisExpenseDetailViewController {
    // MARK: Network
    private func getMonthlyAnaylsis(year: Int, month: Int) {
        print("💸 getMonthlyAnaylsis called")
        NetworkService.shared.analysis.getMonthlyAnaylsis(year: year, month: month) { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? MonthlyAnalysisResponse else { return }
                print("🎯 getMonthlyAnaylsis success")
                analysisData = data.body

                // CASE3, CASE4: analysisEmpty
                analysisExpenseView.setData(analysisData: analysisData, challengeData: challengeData)
                analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: challengeData)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                // CASE3: analysisEmpty & challengeNonEmpty
//                habitView.setAnalysisExpenseEmtpyView(analysisCase: .emptyAnalysisNonEmptyChallenge)

                // TODO: 임시 데이터 (다 지워야 함)
                // CASE1, CASE2: analysisNonEmpty
//                analysisData = AnalysisData.emptyAnalysisData
//                challengeData = ChallengeData.emptyChallengeData
//                analysisExpenseView.setData(analysisData: analysisData, challengeData: challengeData)
//                analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: challengeData)

                // CASE3: challengeNonEmpty
//                analysisData = AnalysisData.testAnalysisData
//                analysisExpenseView.setData(analysisData: analysisData, challengeData: challengeData)
//                analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: challengeData)

                // CASE4: challengeEmpty
//                analysisData = AnalysisData.emptyAnalysisData
//                analysisExpenseView.setData(analysisData: analysisData, challengeData: challengeData)
//                analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: challengeData)
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


