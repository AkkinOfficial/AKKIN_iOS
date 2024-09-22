//
//  AddExpenseViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class AddExpenseViewController: BaseViewController {

    // MARK: UI Components
    private let addExpenseView = AddExpenseView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
       view.addSubview(addExpenseView)
    }

    // MARK: Layout
    override func makeConstraints() {
        addExpenseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
