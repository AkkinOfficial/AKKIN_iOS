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

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getReports()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .akkinBG

        setNavigationItem()
        router.viewController = self
    }

    // MARK: Properties
    var monthAnalysisList = MonthAnalysis.monthAnalysisList

    // MARK: Configuration
    override func configureSubviews() {

        view.addSubview(habitView)

        habitView.tapPiggyBankButton = { [weak self] in
            guard let self else { return }
            router.popToMakePiggyBankStartViewController()
        }
        habitView.tapDetailButton = { [weak self] in
            guard let self else { return }
            router.presentAnalysisExpenseViewController()
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
}

extension HabitViewController {
    // MARK: Network
    private func getReports() {
        print("💸 getReports called")
        NetworkService.shared.reports.getReports() { result in
            switch result {
            case .success(let response):
                guard let data = response as? ReportsResponse else { return }
                print("🎯 getReports success")
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ReportsErrorResponse else { return }
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

