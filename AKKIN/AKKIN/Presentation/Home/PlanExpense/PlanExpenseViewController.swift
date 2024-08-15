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

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(planExpenseView)
    }

    // MARK: Layout
    override func makeConstraints() {
        planExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
