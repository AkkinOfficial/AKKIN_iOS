//
//  HomeViewController.swift
//  AKKIN
//
//  Created by 성현주 on 9/15/24.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: UI Components
    private let homeView = HomeView()

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

        homeView.tapAddExpense = { [weak self] in
            guard let self else { return }
            router.presentAddExpenseViewController()
        }
        //TODO: model 변경 코드 추가
        homeView.toggleButton.tapToggle = { [weak self] in
            guard let self else { return }
            print("toggle")
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

