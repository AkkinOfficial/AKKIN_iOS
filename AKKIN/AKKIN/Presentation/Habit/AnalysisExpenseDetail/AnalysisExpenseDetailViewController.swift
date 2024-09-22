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
    let monthAnalysisList = MonthAnalysis.monthAnalysisList

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        analysisExpenseView.getTotalExpense(monthAnaysisData: monthAnalysisList)
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
