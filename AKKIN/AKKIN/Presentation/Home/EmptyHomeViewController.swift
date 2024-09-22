//
//  EmptyHomeViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 8/8/24.
//

import UIKit

final class EmptyHomeViewController: BaseViewController {

    // MARK: UI Components
    private let homeView = EmptyHomeView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(homeView)

        //TODO: 라우터 수정
        homeView.tapExpense = { [weak self] in
            guard let self else { return }
            router.presentPlanExpenseViewController()
            //router.presentAddExpenseViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
