//
//  ExpenseDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseDetailViewController: BaseViewController {

    // MARK: UI Components
    private let expenseDetailView = ExpenseDetailView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
    }

    // MARK: Properties

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseDetailView)
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
