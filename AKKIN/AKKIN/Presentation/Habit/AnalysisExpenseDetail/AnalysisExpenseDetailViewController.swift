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

        analysisExpenseView.setData(analysisData: analysisData, challengeData: ChallengeData.emptyChallengeData)
        analysisExpenseView.monthAnalysisHeaderView.setData(analysisData: analysisData, challengeData: ChallengeData.emptyChallengeData)
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

        analysisExpenseView.monthAnalysisHeaderView.tapPrevious = { [self] in
            
        }

        analysisExpenseView.monthAnalysisHeaderView.tapNext = { [self] in
            
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
