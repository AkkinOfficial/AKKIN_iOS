//
//  PlanExpenseViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class PlanExpenseViewController: BaseViewController {

    // MARK: UI Components
    private let planExpenseView = PlanExpenseView()
    let setPeriodViewController = SetPeriodViewController()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        setPeriodViewController.delegate = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(planExpenseView)

        planExpenseView.tapPeriodTextField = { [weak self] in
            guard let self else { return }
            router.presentSetPeriodViewController(setPeriodViewController)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        planExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PlanExpenseViewController: SetPeriodViewControllerDelegate {
    
    func didSelectDates(startDate: String, endDate: String, duration: String) {
        planExpenseView.periodTextField.text = "\(startDate) ~ \(endDate)"
        planExpenseView.periodTextField.addRightLabel(text: duration)
    }
}
