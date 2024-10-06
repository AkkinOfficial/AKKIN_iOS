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

        configureView()

        habitView.makePiggyBankNonEmptyView.tapDetail = {
            [weak self] in
                guard let self else { return }
            router.popToPiggyBankDetailViewController()
        }
        habitView.makePiggyBankEmptyView.tapPiggyBankButton = { [weak self] in
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

    private func configureView() {
        let model = PiggyBankModel.dummy
        let rate = CGFloat(model.achievementRate)/100
        habitView.makePiggyBankNonEmptyView.circularProgressBar.value = rate
        habitView.makePiggyBankNonEmptyView.piggyBankNameLabel.text = "\(model.name)"
        habitView.makePiggyBankNonEmptyView.piggyBankImageLabel.text = "\(model.emoji)"

        print("Saved = \(model.currentAmount), Goal = \(model.goalAmount), Rate = \(CGFloat(model.achievementRate)/100)")
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

