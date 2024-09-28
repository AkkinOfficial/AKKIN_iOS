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

    // MARK: Properties
    private var currentType: String = "daily"

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
        //TODO: 네트워크 메서드 추가
        configureView(for: currentType)
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(homeView)

        homeView.tapAddExpense = { [weak self] in
            guard let self else { return }
            router.presentAddExpenseViewController()
        }

        homeView.toggleButton.tapToggle = { [weak self] in
            guard let self else { return }
            self.toggleType()
        }

        configureView(for: currentType)
    }

    private func toggleType() {
        currentType = (currentType == "daily") ? "all" : "daily"
        configureView(for: currentType)
    }

    private func configureView(for type: String) {
        guard let model = HomeModel.dummy(for: type) else { return }

        homeView.progressView.totalAmount = CGFloat(model.savedAmount)
        homeView.progressView.usedAmount = CGFloat(model.expenseAmount)

        switch type {
        case "daily":
            homeView.progressView.setCenterImage(AkkinIcon.habitFilled)
        case "all":
            homeView.progressView.setCenterImage(AkkinIcon.piggyBankFilled)
        default:
            break
        }

        print("Updated to \(type) type: Saved = \(model.savedAmount), Used = \(model.expenseAmount), Available = \(model.availableAmount)")
    }

    // MARK: Layout
    override func makeConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
