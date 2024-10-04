//
//  EmptyHomeViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class EmptyHomeViewController: BaseViewController {

    // MARK: UI Components
    private let emptyHomeView = EmptyHomeView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(emptyHomeView)

        //TODO: 라우터 수정
        emptyHomeView.tapExpense = { [weak self] in
            guard let self else { return }
            router.presentPlanExpenseViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        emptyHomeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
