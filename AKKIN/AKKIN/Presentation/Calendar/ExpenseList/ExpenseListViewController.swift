//
//  ExpenseListViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 9/22/24.
//

import UIKit

final class ExpenseListViewController: BaseViewController {

    // MARK: UI Components
    private let expenseListView = ExpenseListView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(expenseListView)
    }

    // MARK: Layout
    override func makeConstraints() {
        expenseListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
